//
//  PokemonListUseCase.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public protocol PokemonListUseCaseProtocol {
    func execute(url: URL?) async throws -> PokemonList
}

class PokemonListUseCase: PokemonListUseCaseProtocol {
    private let pokemonRepository: PokemonRepositoryProtocol
    

    init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }

    func execute(url: URL?) async throws -> PokemonList {
        return try await pokemonRepository.fetchSpeciesList(url: url)
    }
}

public struct SpeciesListUseCaseFactory {
    public static func makepeciesListUseCase(pokemonRepository: PokemonRepositoryProtocol) -> PokemonListUseCaseProtocol {
        return PokemonListUseCase(pokemonRepository: pokemonRepository)
    }
}
