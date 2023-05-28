//
//  MockPokemonDetailUseCase.swift
//  pokeProjectTests
//
//  Created by Wesley Brito on 28/05/23.
//

import Foundation
import Domain
import Datalayer

class MockPokemonDetailUseCase: PokemonDetailUseCaseProtocol {
    var result: Result<PokemonDetail, APIError>!

    func execute(id: Int) async throws -> PokemonDetail {
        switch result {
        case .success(let pokemonDetail):
            return pokemonDetail
        case .failure(let error):
            throw error
        case .none:
            fatalError("No result set for the use case")
        }
    }
}
