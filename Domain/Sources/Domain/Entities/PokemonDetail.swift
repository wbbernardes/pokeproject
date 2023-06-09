//
//  PokemonDetail.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public struct PokemonDetail: Identifiable, Equatable {
    public let id: Int
    public let specie: PokemonSpecies
    public var evolutionChain: PokemonEvolutionChain
    
    public init(id: Int, specie: PokemonSpecies, evolutionChain: PokemonEvolutionChain) {
        self.id = id
        self.specie = specie
        self.evolutionChain = evolutionChain
    }
    
    public static let empty = PokemonDetail(id: 0, specie: PokemonSpecies.empty, evolutionChain: .empty)
    
    public static let mock: PokemonDetail = PokemonDetail(
        id: 1,
        specie: PokemonSpecies(
            id: 1,
            name: "bulbasaur"
        ),
        evolutionChain: PokemonEvolutionChain(
            species: PokemonSpecies(id: 1, name: "bulbasaur"),
            evolvesTo: [PokemonEvolutionChain(species: PokemonSpecies(id: 2, name: "ivysaur"), evolvesTo: [])]
        )
    )
}
