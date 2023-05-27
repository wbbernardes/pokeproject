//
//  APIService.swift
//  
//
//  Created by Wesley Brito on 27/05/23.
//

import Foundation

public struct APIFactory {
    public static func makeAPIService() -> APIServiceProtocol {
        return APIService()
    }
}

public protocol APIServiceProtocol {
    func request<T: Decodable>(_ target: APITarget) async throws -> T
}

class APIService: APIServiceProtocol {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ target: APITarget) async throws -> T {
        var request = URLRequest(url: target.url)
        request.httpMethod = target.method
        request.allHTTPHeaderFields = target.headers
        
        let (data, response) = try await session.customDataTaskPublisher(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return try JSONDecoder().decode(T.self, from: data)
        case 400:
            throw APIError.badRequest
        case 401:
            throw APIError.unauthorized
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 500:
            throw APIError.serverError
        default:
            throw APIError.unknown
        }
    }
}

public protocol NetworkSession {
    func customDataTaskPublisher(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {
    public func customDataTaskPublisher(for request: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await self.data(for: request)
        return (data, response)
    }
}
