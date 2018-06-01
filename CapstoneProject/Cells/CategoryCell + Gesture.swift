//
//  CategoryCell + Gesture.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 25..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

extension CategoryCell {
    func setupGesture(){
        self.itemsCollectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleRemoveItem)))
    }
    
    @objc func handleRemoveItem(gesture: UILongPressGestureRecognizer){
        guard let keyWindow = UIApplication.shared.keyWindow else {return}
        let location = gesture.location(in: self.itemsCollectionView)
        guard let indexPath = itemsCollectionView.indexPathForItem(at: location) else {return}
        let alert:UIAlertController!
        switch category {
        case .card:
            let item = UserDefaults.standard.loadCards()[indexPath.row]
            alert = UIAlertController(title: nil, message: "Remove \(item.card_name)?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
                UserDefaults.standard.set(try? PropertyListEncoder().encode(UserDefaults.standard.loadCards().filter({$0.card_name != item.card_name})), forKey: Card.key)
                self.cards.remove(at: indexPath.row)
                self.itemsCollectionView.deleteItems(at: [indexPath])
            }))
            alert.addAction(UIAlertAction(title: "Cencel", style: .cancel, handler: nil))
            keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
        case .brand:
            let item = UserDefaults.standard.loadBrands()[indexPath.row]
            alert = UIAlertController(title: nil, message: "Remove \(item.store_name)?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
                UserDefaults.standard.set(try? PropertyListEncoder().encode(UserDefaults.standard.loadBrands().filter({$0.store_name != item.store_name})), forKey: Brand.key)
                self.brands.remove(at: indexPath.row)
                self.itemsCollectionView.deleteItems(at: [indexPath])
            }))
            alert.addAction(UIAlertAction(title: "Cencel", style: .cancel, handler: nil))
            keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
