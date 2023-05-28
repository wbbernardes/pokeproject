//
//  PokemonListUseCaseTests.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

import XCTest
@testable import Domain

class PokemonListUseCaseTests: XCTestCase {
    
    var useCase: PokemonListUseCaseProtocol!
    var mockRepository: MockPokemonRepository!

    override func setUp() {
        super.setUp()
        
        mockRepository = MockPokemonRepository()
        useCase = PokemonListUseCaseFactory.makePokemonListUseCase(pokemonRepository: mockRepository)
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        
        super.tearDown()
    }

    func testExecuteWithSuccess() async throws {
        // Given
        let expectedPokemonList = PokemonList(
            next: nil,
            pokemonSpecies: [PokemonSpecies(id: 1, name: "bulbasaur")]
        )
        mockRepository.listResult = .success(expectedPokemonList)
        
        // When
        let result = try await useCase.execute(url: URL(string: "https://example.com"))
        
        // Then
        XCTAssertEqual(result, expectedPokemonList)
    }
    
    func testExecuteFailure() async throws {
        // Given
        mockRepository.listResult = .failure(.unknown)
        
        // When
        do {
            _ = try await useCase.execute(url: URL(string: "https://example.com"))
            XCTFail("Expected .unknown error to be thrown")
        } catch {
            // Then
            XCTAssertEqual(error as? APIError, .unknown)
        }
    }
}
