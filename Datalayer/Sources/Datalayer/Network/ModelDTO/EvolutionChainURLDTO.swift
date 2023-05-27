//
//  EvolutionChainURLDTO.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

struct EvolutionChainURLDTO: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
    
    init(url: String) {
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
    
    static let empty = EvolutionChainURLDTO(url: "")
}
