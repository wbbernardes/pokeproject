//
//  File.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

import XCTest
import Domain
@testable import Datalayer

class PokemonRepositoryTests: XCTestCase {
    var repository: PokemonRepositoryProtocol!
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        
        mockService = MockAPIService()
        repository = PokemonRepository(apiService: mockService)
    }
    
    func testFetchSpeciesList() async throws {
        let mockResponse = PokemonListDTO(
            count: 1,
            next: nil,
            previous: nil,
            results: [
                PokemonSpeciesDTO(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/")
            ]
        )
        mockService.result = .success(mockResponse)
        
        let result = try await repository.fetchSpeciesList(url: URL(string: "https://pokeapi.co/api/v2/pokemon-species")!)
        
        XCTAssertEqual(result.pokemonSpecies.count, 1)
        XCTAssertEqual(result.next, nil)
        XCTAssertEqual(result.pokemonSpecies.first?.name, "bulbasaur")
    }
    
    func testFetchPokemonDetail() async throws {
        let mockEvolutionChainData = EvolutionChainURLDTO(evolutionChainData: EvolutionChainURLDataDTO(url: "https://example.com"))
        
        let mockResponse = EvolutionChainDTO(
            id: 1,
            chain: ChainLinkDTO(
                species: PokemonSpeciesDTO(name: "Test Pokemon", url: "https://example.com"),
                evolvesTo: []
            )
        )
        mockService.result = .success(mockEvolutionChainData)
        mockService.result2 = .success(mockResponse)
        
        let result = try await repository.fetchPokemonDetail(id: 1)
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.evolutionChain.species.name, "Test Pokemon")
    }
}
