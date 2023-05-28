//
//  PokemonList.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public struct PokemonList: Equatable, Hashable {
    public var next: URL?
    public var pokemonSpecies: [PokemonSpecies]
    
    public init(
        next: URL?,
        pokemonSpecies: [PokemonSpecies]
    ) {
        self.next = next
        self.pokemonSpecies = pokemonSpecies
    }
    
    public static let empty = PokemonList(next: URL(string: ""), pokemonSpecies: [])
}
