//
//  PokemonList.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public struct PokemonList: Equatable, Hashable {
    public let next: String?
    public let pokemonSpecies: [PokemonSpecies]
    
    public init(
        next: String?,
        pokemonSpecies: [PokemonSpecies]
    ) {
        self.next = next
        self.pokemonSpecies = pokemonSpecies
    }
    
    public static let empty = PokemonList(next: "", pokemonSpecies: [])
}
