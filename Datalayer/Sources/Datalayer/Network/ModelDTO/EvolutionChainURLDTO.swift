//
//  EvolutionChainURLDTO.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

import Foundation

struct EvolutionChainURLDTO: Decodable {
    let evolutionChainData: EvolutionChainURLDataDTO
    
    enum CodingKeys: String, CodingKey {
        case evolutionChainData = "evolution_chain"
    }
    
    init(evolutionChainData: EvolutionChainURLDataDTO) {
        self.evolutionChainData = evolutionChainData
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.evolutionChainData = try container.decodeIfPresent(EvolutionChainURLDataDTO.self, forKey: .evolutionChainData) ?? .empty
    }
    
    static let empty = EvolutionChainURLDTO(evolutionChainData: .empty)
}

struct EvolutionChainURLDataDTO: Decodable {
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
    
    static let empty = EvolutionChainURLDataDTO(url: "")
}
