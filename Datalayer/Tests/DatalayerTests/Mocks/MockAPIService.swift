//
//  File.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

@testable import Datalayer

class MockAPIService: APIServiceProtocol {
    // 2 results properties is needed because
    // in my fetchPokemonDetail I do 2 api requests
    var result: Result<Any, APIError>!
    var result2: Result<Any, APIError>!
    
    func request<T>(_ target: APITarget) async throws -> T {
        switch target {
        case .getSpeciesList:
            switch result {
            case .success(let object):
                return object as! T
            case .failure(let error):
                throw error
            case .none:
                fatalError("No result set for the service")
            }
        case .getPokemonSpecie:
            switch result {
            case .success(let object):
                return object as! T
            case .failure(let error):
                throw error
            case .none:
                fatalError("No result set for the service")
            }
        case .getPokemonDetail:
            switch result2 {
            case .success(let object):
                return object as! T
            case .failure(let error):
                throw error
            case .none:
                fatalError("No result set for the service")
            }
        }
    }
}
