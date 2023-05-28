//
//  PokemonDetailViewModel.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation
import Combine
import Domain

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    @Published var error: Error?

    private let pokemonDetailUseCase: PokemonDetailUseCaseProtocol
    private let pokemonId: Int

    init(pokemonDetailUseCase: PokemonDetailUseCaseProtocol, pokemonId: Int) {
        self.pokemonDetailUseCase = pokemonDetailUseCase
        self.pokemonId = pokemonId
    }

    func fetchPokemonDetail() async {
        Task { @MainActor in
            do {
                self.pokemonDetail = try await pokemonDetailUseCase.execute(id: pokemonId)
            } catch {
                self.error = error
            }
        }
    }
}
