//
//  File.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func fetchSpeciesList(url: URL?) async throws -> SpeciesListDTO
    func fetchSpeciesDetail(id: Int) async throws -> EvolutionChainURLDTO
    func fetchEvolutionChain(id: Int) async throws -> EvolutionChainDTO
}

class PokemonRepository: PokemonRepositoryProtocol {
    
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIFactory.makeAPIService()) {
        self.apiService = apiService
    }

    func fetchSpeciesList(url: URL?) async throws -> SpeciesListDTO {
        return try await apiService.request(APITarget.getSpecies(url))
    }

    func fetchSpeciesDetail(id: Int) async throws -> EvolutionChainURLDTO {
        return try await apiService.request(APITarget.getSpecificSpecies(id: id))
    }

    func fetchEvolutionChain(id: Int) async throws -> EvolutionChainDTO {
        return try await apiService.request(APITarget.getEvolutionChain(id: id))
    }
}

struct PokemonRepositoryFactory {
    static func makePokemonRepository(apiService: APIServiceProtocol) -> PokemonRepositoryProtocol {
        return PokemonRepository(apiService: apiService)
    }
}
