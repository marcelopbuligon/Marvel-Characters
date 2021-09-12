//
//  CharactersDetailsRouter.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 12/09/21.
//

import UIKit

final class CharactersDetailsRouter: Routerable {
    private var navigation: UINavigationController
    private var model: Character

    
    init(navigation: UINavigationController, model: Character) {
        self.navigation = navigation
        self.model = model
    }

    func makeViewController() -> UIViewController {
        let presenter = CharactersDetailsPresenter(model: model)
        let viewController = CharactersDetailsViewController(presenter: presenter)
        return viewController
    }
}
