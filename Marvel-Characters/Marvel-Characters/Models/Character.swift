//
//  Character.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

struct Character: Codable {

    var name: String?
    var thumbnail: ThumbNail?
    var description: String?
    var urls: [Urls]
}
