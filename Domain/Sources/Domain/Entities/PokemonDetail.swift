//
//  PokemonDetail.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public struct PokemonDetail: Equatable, Hashable, Identifiable {
    public let id: Int
    public let specie: PokemonSpecies
    public let evolutionChain: [PokemonSpecies]
    
    public init(id: Int, specie: PokemonSpecies, evolutionChain: [PokemonSpecies]) {
        self.id = id
        self.specie = specie
        self.evolutionChain = evolutionChain
    }
    
    public static let empty = PokemonDetail(id: 0, specie: PokemonSpecies.empty, evolutionChain: [])
}
