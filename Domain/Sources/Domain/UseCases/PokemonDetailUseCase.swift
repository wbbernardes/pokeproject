//
//  PokemonDetailUseCase.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public protocol PokemonDetailUseCaseProtocol {
    func execute(id: Int) async throws -> PokemonDetail
}

class PokemonDetailUseCase: PokemonDetailUseCaseProtocol {
    private let pokemonRepository: PokemonRepositoryProtocol
    

    init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }

    func execute(id: Int) async throws -> PokemonDetail {
        return try await pokemonRepository.fetchPokemonDetail(id: id)
    }
}

public struct PokemonDetailUseCaseFactory {
    public static func makepeciesListUseCase(pokemonRepository: PokemonRepositoryProtocol) -> PokemonDetailUseCaseProtocol {
        return PokemonDetailUseCase(pokemonRepository: pokemonRepository)
    }
}
