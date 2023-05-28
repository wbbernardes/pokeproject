//
//  APITarget.swift
//  
//
//  Created by Wesley Brito on 26/05/23.
//

import Foundation

public enum APITarget {
    case getSpeciesList(URL?)
    case getPokemonSpecie(id: Int)
    case getPokemonDetail(URL)

    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2")!
    }

    var path: String {
        switch self {
        case .getSpeciesList:
            return "/pokemon-species"
        case .getPokemonSpecie(let id):
            return "/pokemon-species/\(id)"
        case .getPokemonDetail:
            return ""
        }
    }

    var method: String {
        switch self {
        case .getSpeciesList, .getPokemonSpecie, .getPokemonDetail:
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
        case .getSpeciesList(let url):
            return url ?? baseURL.appendingPathComponent(path)
        case .getPokemonDetail(let url):
            return url
        default:
            return baseURL.appendingPathComponent(path)
        }
    }
}
