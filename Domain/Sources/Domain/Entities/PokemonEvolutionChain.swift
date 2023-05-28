//
//  PokemonEvolutionChain.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public struct PokemonEvolutionChain: Identifiable, Hashable {
    public let id: UUID = UUID()
    public let species: PokemonSpecies
    public let evolvesTo: [PokemonEvolutionChain]
    
    public init(species: PokemonSpecies, evolvesTo: [PokemonEvolutionChain]) {
        self.species = species
        self.evolvesTo = evolvesTo
    }
    
    public static let empty = PokemonEvolutionChain(species: .empty, evolvesTo: [])
}
