//
//  MockNetworkSession.swift
//  
//
//  Created by Wesley Brito on 28/05/23.
//

import Foundation
@testable import Datalayer

struct MockNetworkSession: NetworkSession {
    var data: Data
    var response: URLResponse
    var error: URLError?
    
    func customDataTaskPublisher(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        } else {
            return (data, response)
        }
    }
}
