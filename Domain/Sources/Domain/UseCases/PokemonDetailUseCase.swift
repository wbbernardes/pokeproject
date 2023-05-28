//
//  PokemonDetailUseCase.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public protocol PokemonDetailUseCaseProtocol {
    func execute(id: Int) async throws -> PokemonDetail
}

class PokemonDetailUseCase: PokemonDetailUseCaseProtocol {
    private let pokemonRepository: PokemonRepositoryProtocol
    

    init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }

    func execute(id: Int) async throws -> PokemonDetail {
        var pokemonDetail: PokemonDetail = try await pokemonRepository.fetchPokemonDetail(id: id)
        pokemonDetail.evolutionChain = filterEvolutionChain(pokemonDetail.evolutionChain, with: id)
        return pokemonDetail
    }
    
    private func filterEvolutionChain(_ evolutionChain: PokemonEvolutionChain, with id: Int) -> PokemonEvolutionChain {
            if evolutionChain.species.id == id {
                return evolutionChain
            } else {
                for evolvesTo in evolutionChain.evolvesTo {
                    let result = filterEvolutionChain(evolvesTo, with: id)
                    if result.species.id == id {
                        return result
                    }
                }
            }
            return evolutionChain
        }
}

public struct PokemonDetailUseCaseFactory {
    public static func makePokemonDetailUseCase(pokemonRepository: PokemonRepositoryProtocol) -> PokemonDetailUseCaseProtocol {
        return PokemonDetailUseCase(pokemonRepository: pokemonRepository)
    }
}
