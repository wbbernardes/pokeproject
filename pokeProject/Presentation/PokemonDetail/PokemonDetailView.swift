//
//  PokemonDetailView.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    var pokemonName: String
    var pokemonImage: URL?
    
    init(viewModel: PokemonDetailViewModel, pokemonName: String, pokemonImage: URL?) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.pokemonName = pokemonName
        self.pokemonImage = pokemonImage
    }

    var body: some View {
        VStack {
            if let pokemonDetail = viewModel.pokemonDetail {
                VStack {
                    PokemonView(name: pokemonName, url: pokemonImage)
                    
                    if pokemonDetail.evolutionChain.evolvesTo.count > 0 {
                        VStack {
                            HStack {
                                Text("Possibles evolution")
                                    .font(.title)
                                    .padding(.bottom, 10)
                                
                                Spacer()
                            }
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(pokemonDetail.evolutionChain.evolvesTo, id: \.id) { evolutionChain in
                                        PokemonView(name: evolutionChain.species.name, url: evolutionChain.species.imageUrl)
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                    }
                }
            } else if let error = viewModel.error {
                Text("Error loading Pokemon: \(error.localizedDescription)")
            } else {
                ProgressView("Loading...")
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .onAppear {
            Task {
                await viewModel.fetchPokemonDetail()
            }
        }
    }
}
