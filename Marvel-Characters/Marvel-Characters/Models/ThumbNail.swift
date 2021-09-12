//
//  ThumbNail.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

struct ThumbNail: Codable {
    var path: String?
    var imageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
