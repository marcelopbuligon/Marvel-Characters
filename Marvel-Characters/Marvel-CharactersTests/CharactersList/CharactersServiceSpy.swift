import XCTest
@testable import Marvel_Characters

final class CharactersServiceSpy: CharactersServiceProtocol {
    var delegate: CharactersServiceDelegate?
    
    // MARK: - Test fetchCharactersByName
    private(set) var fetchCharactersByName = false
    private(set) var namePassed: String?
    
    func fetchCharactersByName(query: String) {
        fetchCharactersByName = true
        namePassed = query
    }
    
    // MARK: - Test fetchCharactersByOffset
    private(set) var fetchCharactersCalled = false
    private(set) var offsetPassed: String?
    
    func fetchCharactersByOffset(offset: String) {
        fetchCharactersCalled = true
        offsetPassed = offset
    }
}
