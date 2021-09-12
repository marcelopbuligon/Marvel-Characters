//
//  SpinnerController.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

import UIKit

final class SpinnerController: UIViewController {
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpinner()
        setupConstraints()
    }
    
    func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    
    func setupConstraints() {
        let horizontalConstraint = spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = spinner.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = spinner.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func hide() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func show() {
        view.frame = view.frame
        didMove(toParent: self)
    }
}
