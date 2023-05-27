//
//  PokemonListViewModel.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: PokemonList = .empty
    @Published var selectedPokemon: Int = 0
    @Published var error: Error?
    
    private let pokemonListUseCase: PokemonListUseCaseProtocol
    
    init(pokemonListUseCase: PokemonListUseCaseProtocol) {
        self.pokemonListUseCase = pokemonListUseCase
    }
    
    func fetchPokemonList() async {
        Task { @MainActor in
            do {
                self.pokemonList = try await pokemonListUseCase.execute(url: pokemonList.next)
            } catch {
                self.error = error
            }
        }
    }
}
