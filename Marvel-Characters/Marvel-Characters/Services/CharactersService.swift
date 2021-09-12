//
//  CharactersService.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

import Foundation

final class CharactersService: CharactersServiceProtocol {
    
    weak var delegate: CharactersServiceDelegate?
    private let apiRequester: APIRequestProtocol
    
    init(apiRequester: APIRequestProtocol = APIRequest()) {
        self.apiRequester = apiRequester
    }
    
    func fetchCharactersByName(query: String) {
        
        var urlComponent = makeBaseUrl()
        urlComponent.queryItems?.append(
            URLQueryItem(name: "nameStartsWith", value: query)
        )
    
        guard let urlString = urlComponent.url?.absoluteString else { return }
        
        apiRequester.request(
            urlString: urlString,
            method: .get,
            parameters: nil,
            success: { [weak self] (response: Response) in
                self?.delegate?.didFindCharacters(response.data?.results ?? [])
        }) { [delegate] (error) in
            delegate?.didFail(error: error)
        }
    }
    
    func fetchCharactersByOffset(offset: String) {
        
        var urlComponent = makeBaseUrl()
        urlComponent.queryItems?.append(contentsOf: [
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "offset", value: offset)
        ])

        guard let urlString = urlComponent.url?.absoluteString else { return }
        
        apiRequester.request(
            urlString: urlString,
            method: .get,
            parameters: nil,
            success: { [weak self] (response: Response) in
                self?.delegate?.didFindCharacters(response.data?.results ?? [])
        }) { [delegate] (error) in
            delegate?.didFail(error: error)
        }
    }
    
    private func makeBaseUrl() -> URLComponents {

        var components = URLComponents()
        components.scheme = "https"
        components.host = AppURL.base
        components.path = AppURL.charactersPath
        components.queryItems = [
            URLQueryItem(name: "apikey", value: AppKeys.publicKey),
            URLQueryItem(name: "hash", value: AppKeys.hash),
            URLQueryItem(name: "ts", value: AppKeys.timeStamp)
        ]
        return components
    }
}
