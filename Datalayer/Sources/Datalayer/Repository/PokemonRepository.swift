//
//  File.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain

struct PokemonRepository: PokemonRepositoryProtocol {
    
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIFactory.makeAPIService()) {
        self.apiService = apiService
    }

    func fetchSpeciesList(url: URL?) async throws -> SpeciesList {
        let object: SpeciesListDTO = try await apiService.request(.getSpecies(url))
        return object.toDomain()
    }

    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        let object: EvolutionChainDTO = try await apiService.request(APITarget.getPokemonDetail(id: id))
        return object.toDomain()
    }
}

struct PokemonRepositoryFactory {
    static func makePokemonRepository(apiService: APIServiceProtocol) -> PokemonRepositoryProtocol {
        return PokemonRepository(apiService: apiService)
    }
}
