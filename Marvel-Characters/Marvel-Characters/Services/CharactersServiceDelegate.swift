//
//  CharactersServiceDelegate.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

protocol CharactersServiceDelegate: AnyObject {
    func didFindCharacters(_ response: [Character])
    func didFail(error:Error)
}
