//
//  PokemonDetailViewModelTests.swift
//  pokeProjectTests
//
//  Created by Wesley Brito on 28/05/23.
//

import XCTest
import Domain
import Datalayer
@testable import pokeProject

class PokemonDetailViewModelTests: XCTestCase {
    var useCase: MockPokemonDetailUseCase!
    var viewModel: PokemonDetailViewModel!
    let testPokemonId = 1
    
    override func setUp() {
        super.setUp()
        useCase = MockPokemonDetailUseCase()
        viewModel = PokemonDetailViewModel(pokemonDetailUseCase: useCase, pokemonId: testPokemonId)
    }
    
    override func tearDown() {
        useCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchPokemonDetailSuccess() async throws {
        // Given
        let mockPokemonDetail = PokemonDetail(
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
        
        useCase.result = .success(mockPokemonDetail)
        
        // When
        await viewModel.fetchPokemonDetail()
        
        // Wait for a brief moment to let the fetch operation finish
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Then
        XCTAssertEqual(viewModel.pokemonDetail, mockPokemonDetail)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchPokemonDetailFailure() async throws {
        // Given
        let expectedError = APIError.badRequest
        let expectation = XCTestExpectation(description: "PokemonList updates with error")
        
        useCase.result = .failure(.badRequest)
        
        // When
        await viewModel.fetchPokemonDetail()
        
        // Wait for a brief moment to let the fetch operation finish
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Then
        XCTAssertNil(viewModel.pokemonDetail)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error as? APIError, expectedError)
    }
}
