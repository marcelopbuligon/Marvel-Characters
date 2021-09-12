import XCTest
@testable import Marvel_Characters

final class CharacterDetailsPresenterTests: XCTestCase {
    
    private let view = CharacterDetailsViewSpy()
    
    func test_attachView_shouldDelegateSetNavigationTitle() {
        let urlTest = [
            Urls.init(url:URL.init(fileURLWithPath: "http://marvel.com/universe/Agent_Zero?utm_campaign=apiRef&utm_source=20094465bc99cbd5b34ba9af069491ea")),
            Urls.init(url: URL.init(fileURLWithPath: "http://marvel.com/universe/Iron_Man_(Anthony_Stark)?utm_campaign=apiRef&utm_source=20094465bc99cbd5b34ba9af069491ea"))]
        let model = Character.fixture(urls: urlTest)
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)
        sut.hyperLinkDidTap()

        XCTAssertTrue(view.setCharacterURL)
        XCTAssertEqual(view.characterURLTextPassed, URL.init(fileURLWithPath: "http://marvel.com/universe/Iron_Man_(Anthony_Stark)?utm_campaign=apiRef&utm_source=20094465bc99cbd5b34ba9af069491ea"))
    }
    
    func test_attachView_givenNilName_shouldDelegateSetNavigationTitle() {
        let model = Character.fixture(name: nil)
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)

        XCTAssertTrue(view.setNavigationTitleCalled)
        XCTAssertEqual(view.navigationTitleTextPassed, "")
    }
    
    func test_attachView_shouldDelegateSetCharacterName() {
        let model = Character.fixture(name: "Iron-Man")
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)

        XCTAssertTrue(view.setCharacterNameCalled)
        XCTAssertEqual(view.characterNameTextPassed, "Iron-Man")
    }
    
    func test_attachView_givenNilName_shouldDelegateSetCharacterName() {
        let model = Character.fixture(name: nil)
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)

        XCTAssertTrue(view.setCharacterNameCalled)
        XCTAssertEqual(view.characterNameTextPassed, "No Title Available")
    }
    
    func test_attachView_shouldDelegateSetCharacterDescription() {
        let model = Character.fixture(description: "Tony Stark is Iron-Man. He is genius, billionaire, playboy and philanthropist.")
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)

        XCTAssertTrue(view.setCharacterDescriptionCalled)
        XCTAssertEqual(view.characterDescriptionTextPassed, "Tony Stark is Iron-Man. He is genius, billionaire, playboy and philanthropist.")
    }
    
    func test_attachView_givenDescriptionIsNil_shouldDelegateSetCharacterDescription() {
        let model = Character.fixture(description: nil)
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)

        XCTAssertTrue(view.setCharacterDescriptionCalled)
        XCTAssertEqual(view.characterDescriptionTextPassed, "There is no description for this character yet!")
    }
    
    
    func test_attachView_shouldDelegateSetCharacterImage() {
        let model = Character.fixture(thumbnail: ThumbNail.fixture(path: "http//www.ironmanpath.com/image", imgExtension: "jpg"))
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)

        XCTAssertTrue(view.setImageCalled)
        XCTAssertEqual(view.imageUrlPassed, "http//www.ironmanpath.com/image/portrait_uncanny.jpg")
    }
    
    func test_attachView_givenNilThumbnail_shouldDelegateSetCharacterImage() {
        let model = Character.fixture(thumbnail: nil)
        let sut = CharactersDetailsPresenter(model: model)
        sut.view = view
        sut.attachView(view)

        XCTAssertTrue(view.setImageCalled)
        XCTAssertEqual(view.imageUrlPassed, "")
    }
}
