//
//  CharactersListRouter.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

import UIKit

protocol Routerable {
    func makeViewController() -> UIViewController
}

protocol CharactersListRouterProtocol: AnyObject {
    func navigateToDetailsScene(model: Character)
}

final class CharactersListRouter: Routerable {
    private var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func makeViewController() -> UIViewController {
        let presenter = CharactersListPresenter(router: self)
        let viewController = CharactersListViewController(presenter: presenter)
        return viewController
    }
}

extension CharactersListRouter: CharactersListRouterProtocol {
    func navigateToDetailsScene(model: Character) {
        
//        let router = CharactersDetailsRouter(navigation: navigation, model: model)
//         let vc = router.makeViewController()
//        navigation.present(vc, animated: true, completion: nil)
    }
}
