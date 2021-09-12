
import Foundation
@testable import Marvel_Characters

extension Character {
    static func fixture(name: String? = "",
                        thumbnail: ThumbNail? = nil,
                        urls: [Urls] = [Urls(url: URL.init(fileURLWithPath: ""))],
                        description: String? = ""
    ) -> Character {
        return Character(name: name, thumbnail: thumbnail, description: description, urls: urls)
    }
}

extension ThumbNail {
    static func fixture(path: String? = "",
                        imgExtension: String = ""
    ) -> ThumbNail {
        return ThumbNail(path: path, imageExtension: imgExtension)
    }
}
