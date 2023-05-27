//
//  APITarget.swift
//  
//
//  Created by Wesley Brito on 26/05/23.
//

import Foundation

public enum APITarget {
    case getSpecies(URL?)
    case getSpecificSpecies(id: Int)
    case getEvolutionChain(id: Int)

    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2")!
    }

    var path: String {
        switch self {
        case .getSpecies:
            return "/pokemon-species"
        case .getSpecificSpecies(let id):
            return "/pokemon-species/\(id)"
        case .getEvolutionChain(let id):
            return "/evolution-chain/\(id)"
        }
    }

    var method: String {
        switch self {
        case .getSpecies, .getSpecificSpecies, .getEvolutionChain:
            return "GET"
        }
    }

    var task: [String: Any] {
        return [:]
    }

    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }

    var url: URL {
        switch self {
        case .getSpecies(let url):
            return url ?? baseURL.appendingPathComponent(path)
        default:
            return baseURL.appendingPathComponent(path)
        }
    }
}
