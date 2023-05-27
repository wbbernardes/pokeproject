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

    func fetchSpeciesList(url: URL?) async throws -> PokemonList {
        let object: PokemonListDTO = try await apiService.request(.getSpecies(url))
        return object.toDomain()
    }

    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        let object: EvolutionChainDTO = try await apiService.request(APITarget.getPokemonDetail(id: id))
        return object.toDomain()
    }
}

public struct PokemonRepositoryFactory {
    public static func makePokemonRepository(apiService: APIServiceProtocol = APIFactory.makeAPIService()) -> PokemonRepositoryProtocol {
        return PokemonRepository(apiService: apiService)
    }
}
