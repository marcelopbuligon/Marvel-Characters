import XCTest
@testable import Marvel_Characters

final class CharactersViewCellPresenterTests: XCTestCase {
    
    private let view = CharacterCellViewSpy()
    
    func test_attachView_shouldDelegateSetTitle() {
        let sut = CharactersViewCellPresenter(model: Character.fixture(name: "Wanda-Maximoff"))
        sut.attachView(view)
        
        XCTAssertTrue(view.setTitleCalled)
        XCTAssertEqual(view.titleTextPassed, "Wanda-Maximoff")
    }
    
    func test_attachView_givenNilTitle_shouldDelegateSetTitle() {
        let sut = CharactersViewCellPresenter(model: Character.fixture(name: nil))
        sut.attachView(view)
        
        XCTAssertTrue(view.setTitleCalled)
        XCTAssertEqual(view.titleTextPassed, "No Title Available")
    }
    
    func test_attachView_shouldDelegateSetDescription() {
        let sut = CharactersViewCellPresenter(model: Character.fixture(description: "The Vision is a fictional character portrayed by Paul Bettany in the Marvel Cinematic Universe (MCU)"))
        sut.attachView(view)
        
        XCTAssertTrue(view.setDescriptionCalled)
        XCTAssertEqual(view.descriptionTextPassed, "The Vision is a fictional character portrayed by Paul Bettany in the Marvel Cinematic Universe (MCU)")
    }
    
    func test_attachView_givenNilDescription_shouldDelegateSetDescription() {
        let sut = CharactersViewCellPresenter(model: Character.fixture(description: nil))
        sut.attachView(view)
        
        XCTAssertTrue(view.setDescriptionCalled)
        XCTAssertEqual(view.descriptionTextPassed, "There is no description for this character yet!")
    }
    
    func test_attachView_shouldDelegateSetImage() {
        let thumbnail = ThumbNail.fixture(
            path: "http://www.imageTest/iron",
            imgExtension: "jpg")
        let sut = CharactersViewCellPresenter(model: Character.fixture(thumbnail: thumbnail))
        sut.attachView(view)
        
        XCTAssertTrue(view.setImageCalled)
        XCTAssertEqual(view.imageUrlPassed, "http://www.imageTest/iron/portrait_uncanny.jpg")
    }
    
    func test_attachView_givenNilThumbnail_shouldDelegateSetImage() {
        let sut = CharactersViewCellPresenter(model: Character.fixture(thumbnail: nil))
        sut.attachView(view)
        
        XCTAssertTrue(view.setImageCalled)
        XCTAssertEqual(view.imageUrlPassed, "")
    }
    
    func test_attachView_shouldDelegateSetFooterLabel() {
        let sut = CharactersViewCellPresenter(model: Character.fixture())
        sut.attachView(view)
        
        XCTAssertTrue(view.setFooterLabelCalled)
        XCTAssertEqual(view.footerLabelPassed, "More Info")
    }
    
}
