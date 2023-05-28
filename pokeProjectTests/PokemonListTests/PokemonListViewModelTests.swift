//
//  PokemonListViewModelTests.swift
//  pokeProjectTests
//
//  Created by Wesley Brito on 28/05/23.
//

import XCTest
import Domain
import Datalayer
@testable import pokeProject

class PokemonListViewModelTests: XCTestCase {
    var useCase: MockPokemonListUseCase!
    var viewModel: PokemonListViewModel!
    
    override func setUp() {
        super.setUp()
        useCase = MockPokemonListUseCase()
        viewModel = PokemonListViewModel(pokemonListUseCase: useCase)
    }
    
    override func tearDown() {
        useCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchPokemonListSuccess() async throws {
        // Given
        let mockPokemonList = PokemonList(next: nil, pokemonSpecies: [PokemonSpecies(id: 1, name: "bulbasaur")])
        useCase.result = .success(mockPokemonList)
        
        // When
        await viewModel.fetchPokemonList()
        
        // Wait for a brief moment to let the fetch operation finish
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Then
        XCTAssertEqual(viewModel.pokemonList, mockPokemonList)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchPokemonListFailure() async throws {
        // Given
        let expectedError = APIError.serverError
        let expectation = XCTestExpectation(description: "PokemonList updates with error")
        
        useCase.result = .failure(.serverError)
        
        // When
        await viewModel.fetchPokemonList()
        
        // Wait for a brief moment to let the fetch operation finish
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Then
        XCTAssertEqual(viewModel.pokemonList, .empty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error as? APIError, expectedError)
    }
}
