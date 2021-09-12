import XCTest
@testable import Marvel_Characters

final class CharacterDetailsViewSpy: CharactersDetailsPresenterDelegate {
 
    // MARK: - Test setupImage
    private(set) var setImageCalled = false
    private(set) var imageUrlPassed: String?
    
    func setupImage(imageUrl: String) {
        setImageCalled = true
        imageUrlPassed = imageUrl
    }
    
    // MARK: - Test setupTitle
    private(set) var setCharacterNameCalled = false
    private(set) var characterNameTextPassed: String?
    
    func setupTitle(title: String) {
        setCharacterNameCalled = true
        characterNameTextPassed = title
    }
    
    // MARK: - Test setupDescription
    private(set) var setCharacterDescriptionCalled = false
    private(set) var characterDescriptionTextPassed: String?
    
    func setupDescription(description: String) {
        setCharacterDescriptionCalled = true
        characterDescriptionTextPassed = description
    }
    
    // MARK: - Test openURL
    private(set) var setCharacterURL = false
    private(set) var characterURLTextPassed: URL?
    
    func openURL(_ url: URL) {
        setCharacterURL = true
        characterURLTextPassed = url
    }
    
    // MARK: - Test setNavigationTitle
    private(set) var setNavigationTitleCalled = false
    private(set) var navigationTitleTextPassed: String?
    
    func setNavigationTitle(_ text: String) {
        setNavigationTitleCalled = true
        navigationTitleTextPassed = text
    }
}
