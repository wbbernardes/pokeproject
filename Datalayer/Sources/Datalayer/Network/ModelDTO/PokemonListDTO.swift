//
//  PokemonListDTO.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain

struct PokemonListDTO: Decodable {
    let count: Int
    let next: String?
    var url: URL?
    let previous: String?
    let results: [PokemonSpeciesDTO]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    init(
        count: Int,
        next: String?,
        previous: String?,
        results: [PokemonSpeciesDTO]
    ) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        self.next = try container.decodeIfPresent(String.self, forKey: .next) ?? ""
        self.url = URL(string: self.next ?? "")
        self.previous = try container.decodeIfPresent(String.self, forKey: .previous) ?? ""
        self.results = try container.decodeIfPresent([PokemonSpeciesDTO].self, forKey: .results) ?? []
    }
}

extension PokemonListDTO {
    public func toDomain() -> PokemonList {
        return PokemonList(next: self.url, pokemonSpecies: self.results.map { $0.toDomain() })
    }
}
