import XCTest
@testable import Marvel_Characters

final class CharactersRouterSpy: CharactersListRouterProtocol {
    
    private(set) var navigateToCharactersDetailsSceneCalled = false
    private(set) var characterPassed: Character?
    
    func navigateToDetailsScene(model: Character) {
        navigateToCharactersDetailsSceneCalled = true
        characterPassed = model
    }
}
