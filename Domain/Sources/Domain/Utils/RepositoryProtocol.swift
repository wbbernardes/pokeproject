//
//  File.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public protocol PokemonRepositoryProtocol {
    func fetchSpeciesList(url: URL?) async throws -> SpeciesList
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail
}
