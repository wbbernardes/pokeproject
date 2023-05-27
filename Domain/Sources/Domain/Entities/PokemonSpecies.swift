//
//  PokemonSpecies.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public struct PokemonSpecies: Equatable, Hashable {
    public let id: Int
    public let name: String
    public var imageUrl: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public static let empty = PokemonSpecies(id: 0, name: "")
}
