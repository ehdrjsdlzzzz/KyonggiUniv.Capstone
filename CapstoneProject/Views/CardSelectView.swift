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
    @IBOutlet weak var cardMenuBtnView: UIView!
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureDismiss)))
        self.isUserInteractionEnabled = true
        cardMenuBtnView.isUserInteractionEnabled = true
        cardMenuBtnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMaximizeCardSelectView)))
    }
    
    static func initFromNib()->CardSelectView {
        let cardSelectView = Bundle.main.loadNibNamed("CardSelectView", owner: self, options: nil)?.first as! CardSelectView
        return cardSelectView
    }
    //MARK: Target-Action
    @objc func handleMaximizeCardSelectView(){
        let navigationVC = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        let mainVC = navigationVC.topViewController as! MainViewController
        
        mainVC.isMaximize = mainVC.isMaximize ? false : true
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
