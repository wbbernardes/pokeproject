//
//  PokemonListFactory.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Domain
import Datalayer

struct PokemonListFactory {
    static func makePokemonListViewModel() -> PokemonListViewModel {
        let pokemonRepository: PokemonRepositoryProtocol = PokemonRepositoryFactory.makePokemonRepository()
        let pokemonListUseCase: PokemonListUseCaseProtocol = PokemonListUseCaseFactory.makePokemonListUseCase(pokemonRepository: pokemonRepository)
        
        return PokemonListViewModel(pokemonListUseCase: pokemonListUseCase)
    }
}
