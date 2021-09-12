//
//  CharactersListPresenter.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

import Foundation

protocol CharactersListPresenterDelegate: AnyObject {
    func showAlert(message: String, buttonTitle: String, title: String)
    func reloadData()
    func showLoading()
    func hideLoading()
    func showEmptyState()
    func setNavigationTitle(_ text: String)
}

final class CharactersListPresenter: NSObject {
    
    var dataSource: [Character] = []
    
    weak var view: CharactersListPresenterDelegate?
    private var isFetching: Bool = false
    private var isFiltering: Bool = false
    
    private var offset: Int = 0
    private var limit: Int = 10
    private var service: CharactersServiceProtocol
    private var router: CharactersListRouterProtocol
    
    init(
        service: CharactersServiceProtocol = CharactersService(),
        router: CharactersListRouterProtocol
    ) {
        self.service = service
        self.router = router
        super.init()
        
        self.service.delegate = self
    }
    
    func attachView(_ view: CharactersListPresenterDelegate) {
        self.view = view
        view.setNavigationTitle(Localizable.welcomePage.title.rawValue)
        fetchCharacters()
    }
    
    func fetchingOrFiltering() -> Bool {
        if isFetching && isFiltering {
            return true
        } else {
            return false
        }
    }
    
    func tryAgainButtonDidTap() {
        clearTableView()
        fetchCharacters()
    }
    
    func inputTextDidChange(_ text: String) {
        let characterCount = text.count
        if characterCount  > 1 {
            offset = 0 
            isFiltering = true
            let inputText = text
            service.fetchCharactersByName(query: inputText)
            view?.showLoading()
        } else if characterCount == 0 {
            dataSource.removeAll()
            view?.reloadData()
            isFiltering = false
        } else {
            clearTableView()
        }
    }
    
    func rowDidTap(_ row: Int) {
        let model = dataSource[row]
        router.navigateToDetailsScene(model: model)
    }
    
    func userDidRequestedMoreCharacters() {
        fetchCharacters()
    }
    
    private func clearTableView() {
        dataSource.removeAll()
        view?.reloadData()
    }
    
    private func fetchCharacters() {
        service.fetchCharactersByOffset(offset: "\(offset)")
        view?.showLoading()
        isFetching = true
    }
}

extension CharactersListPresenter: CharactersServiceDelegate {
    func didFindCharacters(_ response: [Character]) {
        if response.isEmpty {
            view?.showEmptyState()
        }
        
        if !isFiltering {
            offset += limit
            response.forEach { dataSource.append($0) }
        } else {
            dataSource = response
        }
        isFetching = false
        view?.hideLoading()
        view?.reloadData()
    }
    
    func didFail(error: Error) {
        view?.hideLoading()
        isFetching = false
        view?.showAlert(
            message: Localizable.inAppError.generic.rawValue,
            buttonTitle: Localizable.inAppError.tryButton.rawValue,
            title: Localizable.inAppError.title.rawValue
        )
    }
}
