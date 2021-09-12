//
//  CharactersListViewController.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

import UIKit

final class CharactersListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var emptyStateView: UIImageView?
    
    private let presenter: CharactersListPresenter
    private let searchController = UISearchController(searchResultsController: nil)
    private let spinner = SpinnerController()
    
    init(presenter: CharactersListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localizable.welcomePage.searchBar.rawValue
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableView?.register(CharactersViewCell.nib, forCellReuseIdentifier: CharactersViewCell.identifier)
        tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

extension CharactersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputTextByUser = searchController.searchBar.text else { return }
        presenter.inputTextDidChange(inputTextByUser)
    }
}

extension CharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersViewCell.identifier, for: indexPath) as? CharactersViewCell else { return UITableViewCell()}
        let characters = presenter.dataSource[indexPath.row]
        let presenter = CharactersViewCellPresenter(model: characters)
        emptyStateView?.isHidden = true
        cell.configure(presenter: presenter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.rowDidTap(indexPath.row)
    }
}

extension CharactersListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let distanceToBottom = contentHeight - offsetY
        
        if distanceToBottom < tableView?.frame.height ?? 0 && !presenter.fetchingOrFiltering() {
            presenter.userDidRequestedMoreCharacters()
        }
    }    
}

extension CharactersListViewController: CharactersListPresenterDelegate {
    func showEmptyState() {
        DispatchQueue.main.async {
            self.emptyStateView?.isHidden = false
        }
    }
    
    func showAlert(message: String, buttonTitle: String, title: String) {
        let dialogMessage = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelButton = UIAlertAction(
            title: Localizable.inAppError.cancelButton.rawValue,
            style: .cancel,
            handler: nil)
        
        let tryAgainButton = UIAlertAction(
            title: buttonTitle,
            style: .default,
            handler: { [weak self] _ -> Void in
                self?.presenter.tryAgainButtonDidTap()
        })
        dialogMessage.addAction(cancelButton)
        dialogMessage.addAction(tryAgainButton)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.spinner.show()
            self.addChild(self.spinner)
            self.view.addSubview(self.spinner.view)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.hide()
        }
    }
    
    func setNavigationTitle(_ text: String) {
        navigationItem.title = text
    }
}
