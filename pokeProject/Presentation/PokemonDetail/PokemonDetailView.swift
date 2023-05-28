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
    
    init(viewModel: PokemonDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            if let viewModel = viewModel.pokemonDetail {
                VStack {
                    Text(viewModel.specie.name)
                        .font(.largeTitle)
                        .padding(.bottom, 10)
                    
                    KFImage(viewModel.specie.imageUrl)
                        .cacheOriginalImage()
                        .diskCacheExpiration(.days(30))
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                VStack {
                    Text("Evolution")
                        .font(.title2)
                        .padding(.bottom, 10)
                    
                    ForEach(viewModel.evolutionChain, id: \.self) { evolutionChain in
                        VStack(spacing: 5) {
                            Text(evolutionChain.name)
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            KFImage(evolutionChain.imageUrl)
                                .cacheOriginalImage()
                                .diskCacheExpiration(.days(30))
                                .resizable()
                                .frame(width: 100, height: 100)
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
