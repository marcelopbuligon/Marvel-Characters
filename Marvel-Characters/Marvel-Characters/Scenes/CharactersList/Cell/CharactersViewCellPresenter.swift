//
//  CharactersViewCellPresenter.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

protocol CharactersViewCellPresenterDelegate {
    func setupImage(imageUrl: String)
    func setupTitle(title: String)
    func setupDescription(description: String)
    func setupFooterLabel(text: String)
}

final class CharactersViewCellPresenter {
    private let model: Character
    private var view: CharactersViewCellPresenterDelegate?
    
    init(model: Character) {
        self.model = model
    }
    
    func attachView(_ view: CharactersViewCellPresenterDelegate) {
        self.view = view
        
        setCharacterImage()
        setCharacterDescription()
        setCharacterTitle()
        setFooterLabel()
    }
    
    private func setCharacterDescription() {
        let description = model.description == "" ? Localizable.inAppError.noDescription.rawValue : model.description
        view?.setupDescription(description: description ?? Localizable.inAppError.noDescription.rawValue)
    }
    
    private func setCharacterTitle() {
        let title = model.name == "" ? Localizable.inAppError.noTitle.rawValue : model.name
        view?.setupTitle(title: title ?? Localizable.inAppError.noTitle.rawValue)
    }
    
    private func setCharacterImage() {
        var imgUrl: String = ""
        
        if let path = model.thumbnail?.path, let imgExtension = model.thumbnail?.imageExtension {
           imgUrl = path + "/portrait_uncanny" + "." + imgExtension
        }
        view?.setupImage(imageUrl: imgUrl)
    }
    
    private func setFooterLabel() {
        let footerLabel = Localizable.welcomePage.footer.rawValue
        view?.setupFooterLabel(text: footerLabel)
    }
}
