//
//  MainViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: Properties
    let cardSelectView = CardSelectView.initFromNib()
    var cardSelectViewBottomConstraint:NSLayoutConstraint?
    var isMaximize:Bool = false {
        didSet{
            isMaximize ? self.maximizeCardSelectView() : self.minimizeCardSelectView()
        }
    }
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupCardSelectView()
    }
    //MARK: Setup views
    fileprivate func setupNavigationController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Configuration"
    }
    fileprivate func setupCardSelectView(){
        self.view.insertSubview(cardSelectView, aboveSubview: self.view)
        cardSelectView.translatesAutoresizingMaskIntoConstraints = false
        cardSelectViewBottomConstraint = cardSelectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 340)
        cardSelectViewBottomConstraint?.isActive = true
        cardSelectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardSelectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardSelectView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    //MARK: Handle Card Select View Sizing
    func maximizeCardSelectView() {
        cardSelectViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.cardSelectView.selectView.alpha = 1
            self.cardSelectView.cardMenuBtnView.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func minimizeCardSelectView() {
        cardSelectViewBottomConstraint?.constant = 340
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.cardSelectView.selectView.alpha = 0
            self.cardSelectView.cardMenuBtnView.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

