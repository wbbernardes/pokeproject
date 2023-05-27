//
//  PokemonListViewModel.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [SpeciesList] = []
    @Published var selectedPokemon: Int = 0
    @Published var error: Error?
    
    private let fetchPokemonListUseCase: PokemonListUseCaseProtocol
    
    init(fetchProductsUseCase: FetchProductsUseCaseProtocol) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func fetchPokemonList() async {
        Task { @MainActor in
            do {
                self.products = try await fetchProductsUseCase.execute()
            } catch {
                self.error = error
            }
        }
    }
}
