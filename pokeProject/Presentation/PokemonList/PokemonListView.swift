//
//  PokemonListView.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import SwiftUI

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
                                Text(pokemon.name)
                                    .font(.headline)
                                    .lineLimit(1)
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
