//
//  CardSelectView.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CardSelectView: UIView {
    //MARK: Outlets
    @IBOutlet weak var selectView: UIView! {
        didSet{
            selectView.backgroundColor = .lightGray
        }
    }
    var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "dismiss_arrow_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @IBOutlet weak var cardMenuBtnView: UIView!
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureDismiss)))
        self.isUserInteractionEnabled = true
        cardMenuBtnView.isUserInteractionEnabled = true
        cardMenuBtnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMaximizeCardSelectView)))
        setupViews()
    }
    static func initFromNib()->CardSelectView {
        let cardSelectView = Bundle.main.loadNibNamed("CardSelectView", owner: self, options: nil)?.first as! CardSelectView
        return cardSelectView
    }
    //MARK: Setup View
    fileprivate func setupViews(){
        selectView.addSubview(dismissButton)
        dismissButton.centerXAnchor.constraint(equalTo: selectView.centerXAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: selectView.bottomAnchor, constant: -8).isActive = true
    }
    //MARK: Target-Action
    @objc func handleMaximizeCardSelectView(){
        let navigationVC = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        let mainVC = navigationVC.topViewController as! MainViewController
        mainVC.maximizeCardSelectView()
    }
    @objc func handlePanGestureDismiss(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        if gesture.state == .changed {
            self.selectView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        }else if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectView.transform = .identity
                if translation.y > 100 {
                    let navigationVC = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                    let mainVC = navigationVC.topViewController as! MainViewController
                    mainVC.minimizeCardSelectView()
                }
            }, completion: nil)
        }
    }
}
