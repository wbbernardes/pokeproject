//
//  APIServiceTests.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

import XCTest
@testable import Datalayer

final class APIServiceTests: XCTestCase {
    var sessionMock: MockNetworkSession!
    var apiServiceMock: APIService!
    var responseMock: HTTPURLResponse!
    var json: Data!
    
    override func setUp() {
        super.setUp()
        json = """
        {
          "count": 1010,
          "next": "https://pokeapi.co/api/v2/pokemon-species?offset=20&limit=20",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon-species/1/"
            }
          ]
        }
        """.data(using: .utf8)
        responseMock = HTTPURLResponse(url: URL(string: "https://pokeapi.co/api/v2/pokemon-species")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        sessionMock = MockNetworkSession(data: json, response: responseMock, error: nil)
        apiServiceMock = APIService(session: sessionMock)
    }
    
    override func tearDown() {
        json = nil
        responseMock = nil
        sessionMock = nil
        apiServiceMock = nil
        super.tearDown()
    }
    
    func testSuccessfulRequest() async throws {
        // When
        let pokemonList: PokemonListDTO = try await apiServiceMock.request(APITarget.getSpeciesList(nil))
        
        // Then
        XCTAssertEqual(pokemonList.results.first?.name, "bulbasaur", "The name of the Pokémon is not as expected.")
    }
    
    func testFailedRequest() async {
        // Given
        sessionMock.data = Data()
        sessionMock.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        
        apiServiceMock = APIService(session: sessionMock)
        
        // When
        do {
            let _: PokemonListDTO = try await apiServiceMock.request(APITarget.getSpeciesList(nil))
            
            // Then
            XCTFail("This line shouldn't be executed as the previous line should throw an error.")
        } catch let error as APIError {
            XCTAssertEqual(error, APIError.notFound, "The error is not as expected.")
        } catch {
            XCTFail("Unexpected error occurred: \(error)")
        }
    }
}
