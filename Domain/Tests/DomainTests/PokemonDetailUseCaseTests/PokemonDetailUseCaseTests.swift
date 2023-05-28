//
//  PokemonDetailUseCaseTests.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

import XCTest
@testable import Domain

class PokemonDetailUseCaseTests: XCTestCase {

    var useCase: PokemonDetailUseCase!
    var mockRepository: MockPokemonRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockPokemonRepository()
        useCase = PokemonDetailUseCase(pokemonRepository: mockRepository)
    }

    func testExecuteSuccess() async throws {
        // Given
        let mockResponse = PokemonDetail(
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
        mockRepository.detailResult = .success(mockResponse)
        
        // When
        let result = try await useCase.execute(id: 1)
        
        // Then
        XCTAssertEqual(result.specie.id, 1)
        XCTAssertEqual(result.specie.name, "bulbasaur")
        XCTAssertEqual(result.evolutionChain.evolvesTo.first?.species.id, 2)
        XCTAssertEqual(result.evolutionChain.evolvesTo.first?.species.name, "ivysaur")
    }

    func testExecuteFailure() async throws {
        // Given
        mockRepository.detailResult = .failure(.unknown)
        
        // When
        do {
            _ = try await useCase.execute(id: 1)
            XCTFail("Expected .unknown error to be thrown")
        } catch {
            // Then
            XCTAssertEqual(error as? APIError, .unknown)
        }
    }
}
