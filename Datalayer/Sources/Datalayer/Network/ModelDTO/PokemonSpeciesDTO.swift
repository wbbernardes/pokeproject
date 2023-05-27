//
//  PokemonSpeciesDTO.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain

struct PokemonSpeciesDTO: Decodable {
    let name: String
    let url: String

    var id: Int {
        let urlComponents = url.components(separatedBy: "/")
        return Int(urlComponents[urlComponents.count - 2]) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    init(
        name: String,
        url: String
    ) {
        self.name = name
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
    
    static let empty = PokemonSpeciesDTO(name: "", url: "")
}

extension PokemonSpeciesDTO {
    public func toDomain() -> PokemonSpecies {
        return PokemonSpecies(id: self.id, name: self.name)
    }
}
