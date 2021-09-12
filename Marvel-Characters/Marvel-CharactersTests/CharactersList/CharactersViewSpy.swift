import XCTest
@testable import Marvel_Characters

final class CharactersViewSpy: CharactersListPresenterDelegate {

    // MARK: - Test showAlert
    private(set) var showErrorCalled = false
    private(set) var errorMessagePassed: String?
    private(set) var tryAgainTapped = false

    func showAlert(message: String, buttonTitle: String, title: String) {
        showErrorCalled = true
        tryAgainTapped = true
        errorMessagePassed = message
    }
    
    // MARK: - Test reloadData
    private(set) var reloadDataCalled = false

    func reloadData() {
        reloadDataCalled = true
    }
    
    // MARK: - Test showLoading
    private(set) var showLoaderCalled = false

    func showLoading() {
        showLoaderCalled = true
    }
    
    // MARK: - Test hideLoading
    private(set) var hideLoaderCalled = false

    func hideLoading() {
        hideLoaderCalled = true
    }
    
    // MARK: - Test setNavigationTitle
    private(set) var setupNavigationTitleCalled = false
    private(set) var navigationTitlePassed: String?
    
    func setNavigationTitle(_ text: String) {
        setupNavigationTitleCalled = true
        navigationTitlePassed = text
    }
}
