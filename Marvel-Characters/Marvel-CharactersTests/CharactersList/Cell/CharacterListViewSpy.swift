import Foundation
@testable import Marvel_Characters

final class CharacterCellViewSpy: CharactersViewCellPresenterDelegate {
    
    // MARK: - Test setupImage
    private(set) var setImageCalled = false
    private(set) var imageUrlPassed: String?
    
    func setupImage(imageUrl: String) {
        setImageCalled = true
        imageUrlPassed = imageUrl
    }
    
    // MARK: - Test setupTitle
    private(set) var setTitleCalled = false
    private(set) var titleTextPassed: String?
    
    func setupTitle(title: String) {
        setTitleCalled = true
        titleTextPassed = title
    }
    
    // MARK: - Test setupDescription
    private(set) var setDescriptionCalled = false
    private(set) var descriptionTextPassed: String?
    
    func setupDescription(description: String) {
        setDescriptionCalled = true
        descriptionTextPassed = description
    }
    
    // MARK: - Test setupFooterLabel
    private(set) var setFooterLabelCalled = false
    private(set) var footerLabelPassed: String?
    
    func setupFooterLabel(text: String) {
        setFooterLabelCalled = true
        footerLabelPassed = text
    }
}
