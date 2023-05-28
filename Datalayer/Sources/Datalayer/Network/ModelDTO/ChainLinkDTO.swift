//
//  ChainLinkDTO.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain

struct ChainLinkDTO: Decodable {
    let species: PokemonSpeciesDTO
    let evolvesTo: [ChainLinkDTO]
    
    enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
    }
    
    init(
        species: PokemonSpeciesDTO,
        evolvesTo: [ChainLinkDTO]
    ) {
        self.species = species
        self.evolvesTo = evolvesTo
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.species = try container.decodeIfPresent(PokemonSpeciesDTO.self, forKey: .species) ?? PokemonSpeciesDTO.empty
        self.evolvesTo = try container.decodeIfPresent([ChainLinkDTO].self, forKey: .evolvesTo) ?? []
    }
    
    static let empty = ChainLinkDTO(species: PokemonSpeciesDTO.empty, evolvesTo: [])
}

extension ChainLinkDTO {
    func toDomain() -> PokemonEvolutionChain {
        return PokemonEvolutionChain(
            species: species.toDomain(),
            evolvesTo: evolvesTo.map { $0.toDomain() }
        )
    }
}
