//
//  MockPokemonListUseCase.swift
//  pokeProjectTests
//
//  Created by Wesley Brito on 28/05/23.
//

import Foundation
import Domain
import Datalayer

class MockPokemonListUseCase: PokemonListUseCaseProtocol {
    var result: Result<PokemonList, APIError>!

    func execute(url: URL?) async throws -> PokemonList {
        switch result {
        case .success(let pokemonList):
            return pokemonList
        case .failure(let error):
            throw error
        case .none:
            fatalError("No result set for the use case")
        }
    }
}
