import XCTest
@testable import Marvel_Characters

final class CharactersListPresenterTests: XCTestCase {

    private let view = CharactersViewSpy()
    private let service = CharactersServiceSpy()
    private let router = CharactersRouterSpy()
    private lazy var sut = CharactersListPresenter(service: service, router: router)
    
    override func setUp() {
        sut.view = view
    }

    func test_viewDidLoad_shouldDelegateShowLoader() {
        sut.attachView(view)
        
        XCTAssertTrue(view.showLoaderCalled)
    }
    
    func test_viewDidLoad_shouldServiceFetchCharacters() {
        sut.attachView(view)
        
        XCTAssertTrue(service.fetchCharactersCalled)
        XCTAssertEqual(service.offsetPassed, "0")
    }
    
    func test_fetchCharacters_withOffsetIncremented_shouldServiceFetchCharacters() {
        sut.userDidRequestedMoreCharacters()
        service.fetchCharactersByOffset(offset: "\(20)")

        XCTAssertTrue(service.fetchCharactersCalled)
        XCTAssertEqual(service.offsetPassed, "20")
    }
    
    func test_fetchCharacters_withName_shouldServiceFetchCharacters() {
        sut.inputTextDidChange("spider")
        
        XCTAssertTrue(service.fetchCharactersByName)
        XCTAssertEqual(service.namePassed, "spider")
    }
    
    func test_fetchCharacters_withNilName_shouldServiceFetchCharacters() {
        sut.inputTextDidChange("")
        
        XCTAssertEqual(service.namePassed, nil)
    }
    
    
    func test_didSelectItemAt_shouldRouterNavigateToCharacterDetailsScene() {
        sut.dataSource = [
            Character.fixture(name: "Loki"),
            Character.fixture(name: "Black Widow"),
            Character.fixture(name: "Vison"),
            Character.fixture(name: "Wanda Maximoff"),
            Character.fixture(name: "Iron-Man"),
        ]

        sut.rowDidTap(3)
        
        XCTAssertTrue(router.navigateToCharactersDetailsSceneCalled)
        XCTAssertEqual(router.characterPassed, Character.fixture(name: "Wanda Maximoff"))
    }
    
    func test_fetchCharactersSucceeded_shouldDelegateHideLoader() {
        sut.didFindCharacters([Character.fixture()])

        XCTAssertTrue(view.hideLoaderCalled)
    }
    
    func test_fetchCharactersSucceeded_shouldDelegateReloadData() {
        sut.didFindCharacters([Character.fixture()])
        
        XCTAssertTrue(view.reloadDataCalled)
    }
    
    func test_fetchCharactersFailed_shouldDelegateHideLoader() {
        sut.didFail(error: AppError.generic)
        
        XCTAssertTrue(view.hideLoaderCalled)
    }
    
    func test_fetchCharactersFailed_shouldDelegateShowErrorWithMessage() {
        sut.didFail(error: AppError.generic)
        XCTAssertTrue(view.showErrorCalled)
        XCTAssertEqual(view.errorMessagePassed, "Oops! An error has occurred")
    }
    
    func test_fetchCharactersFailed_tryAgainTapped() {
        sut.didFail(error: AppError.generic)
        sut.tryAgainButtonDidTap()
        XCTAssertTrue(view.tryAgainTapped)
    }
    
    func test_EmptyState_shouldDelegateShowEmptyState() {
        sut.didFindCharacters([])
        XCTAssertTrue(view.showEmptyStateCalled)
    }
}
