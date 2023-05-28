//
//  PokemonDetailFactory.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain
import Datalayer

struct PokemonDetailFactory {
    static func makePokemonDetailViewModel(pokemonId: Int) -> PokemonDetailViewModel {
        let pokemonRepository: PokemonRepositoryProtocol = PokemonRepositoryFactory.makePokemonRepository()
        let pokemonDetailUseCase: PokemonDetailUseCaseProtocol = PokemonDetailUseCaseFactory.makePokemonDetailUseCase(pokemonRepository: pokemonRepository)
        
        return PokemonDetailViewModel(pokemonDetailUseCase: pokemonDetailUseCase, pokemonId: pokemonId)
    }
}
