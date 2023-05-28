//
//  PokemonListView.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import SwiftUI
import Kingfisher

struct PokemonListView: View {
    @StateObject var viewModel: PokemonListViewModel

    init(viewModel: PokemonListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                        .font(.headline)
                        .foregroundColor(.red)
                } else {
                    List {
                        ForEach(viewModel.filteredPokemon) { pokemon in
                            NavigationLink(destination: PokemonDetailView(viewModel: PokemonDetailFactory.makePokemonDetailViewModel(pokemonId: pokemon.id), pokemonName: pokemon.name, pokemonImage: pokemon.imageUrl) ) {
                                HStack {
                                    HStack(spacing: 10) {
                                        KFImage(pokemon.imageUrl)
                                            .cacheOriginalImage()
                                            .diskCacheExpiration(.days(30))
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(.gray, lineWidth: 1)
                                            )
                                        
                                        Text(pokemon.name)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("#\(pokemon.id)")
                                        .foregroundColor(.gray)
                                }
                            }
                            .onAppear {
                                if pokemon == viewModel.pokemonList.pokemonSpecies.last && viewModel.pokemonList.next != nil {
                                    loadMorePokemons()
                                }
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText)
                }
            }
            .navigationTitle("Pokemon")
            .onFirstAppear {
                Task {
                    await viewModel.fetchPokemonList()
                }
            }
        }
    }
    
    private func loadMorePokemons() {
        Task {
            await viewModel.fetchPokemonList()
        }
    }
}
