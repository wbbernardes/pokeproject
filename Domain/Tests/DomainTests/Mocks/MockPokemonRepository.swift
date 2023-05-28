//
//  MockPokemonRepository.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

import Foundation
import Domain

enum APIError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case serverError // 500
    case unknown
}

class MockPokemonRepository: PokemonRepositoryProtocol {
    
    var listResult: Result<PokemonList, APIError>!
    var detailResult: Result<PokemonDetail, APIError>!
    
    func fetchSpeciesList(url: URL?) async throws -> PokemonList {
        switch listResult {
        case .success(let pokemonList):
            return pokemonList
        case .failure(let error):
            throw error
        case .none:
            fatalError("No result set for the service")
        }
    }

    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        switch detailResult {
        case .success(let pokemonDetail):
            return pokemonDetail
        case .failure(let error):
            throw error
        case .none:
            fatalError("No result set for the fetchPokemonDetail service")
        }
    }
}
