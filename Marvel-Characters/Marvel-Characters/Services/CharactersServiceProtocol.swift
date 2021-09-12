//
//  CharactersServiceProtocol.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

protocol CharactersServiceProtocol: AnyObject {
    var delegate: CharactersServiceDelegate? { get set }
    func fetchCharactersByName(query: String)
    func fetchCharactersByOffset(offset: String)
}
