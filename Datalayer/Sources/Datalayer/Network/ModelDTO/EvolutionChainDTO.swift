//
//  EvolutionChainDTO.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

struct EvolutionChainDTO: Decodable {
    let id: Int
    let chain: ChainLinkDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case chain
    }
    
    init(
        id: Int,
        chain: ChainLinkDTO
    ) {
        self.id = id
        self.chain = chain
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.chain = try container.decodeIfPresent(ChainLinkDTO.self, forKey: .chain) ?? ChainLinkDTO.empty
    }
    
    static let empty = EvolutionChainDTO(id: 0, chain: ChainLinkDTO.empty)
}
