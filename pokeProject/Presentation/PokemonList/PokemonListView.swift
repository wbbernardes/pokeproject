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
                } else {
                    List {
                        ForEach(viewModel.pokemonList.pokemonSpecies) { pokemon in
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
                    }
                    .navigationTitle("Pokémon")
                    .onAppear {
                        Task {
                            await viewModel.fetchPokemonList()
                        }
                    }
                    .refreshable {
                        await viewModel.fetchPokemonList()
                    }
                }
            }
        }
    }
}
