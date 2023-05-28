//
//  PokemonDetailView.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import SwiftUI
import Kingfisher

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
                }
                
                if pokemonDetail.evolutionChain.evolvesTo.count > 0 {
                    VStack {
                        Text("Evolution")
                            .font(.title2)
                            .padding(.bottom, 10)
                        
                        ScrollView(.vertical) {
                            ForEach(pokemonDetail.evolutionChain.evolvesTo, id: \.id) { evolutionChain in
                                VStack {
                                    PokemonView(name: evolutionChain.species.name, url: evolutionChain.species.imageUrl)
                                }
                            }
                        }
                    }
                }
            } else if let error = viewModel.error {
                Text("Error loading Pokemon: \(error.localizedDescription)")
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonDetail()
            }
        }
    }
}

struct PokemonView: View {
    var name: String
    var url: URL?
    
    var body: some View {
        VStack {
            Text(name)
                .font(.largeTitle)
                .padding(.bottom, 10)
                
            KFImage(url)
                .cacheOriginalImage()
                .diskCacheExpiration(.days(30))
                .resizable()
                .frame(width: 200, height: 200)
        }
    }
}
