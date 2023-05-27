//
//  SpeciesListUseCase.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public protocol SpeciesListUseCaseProtocol {
    func execute(url: URL?) async throws -> SpeciesList
}

class SpeciesListUseCase: SpeciesListUseCaseProtocol {
    private let pokemonRepository: PokemonRepositoryProtocol
    

    init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }

    func execute(url: URL?) async throws -> SpeciesList {
        return try await pokemonRepository.fetchSpeciesList(url: url)
    }
}

public struct SpeciesListUseCaseFactory {
    public static func makepeciesListUseCase(pokemonRepository: PokemonRepositoryProtocol) -> SpeciesListUseCaseProtocol {
        return SpeciesListUseCase(pokemonRepository: pokemonRepository)
    }
}
