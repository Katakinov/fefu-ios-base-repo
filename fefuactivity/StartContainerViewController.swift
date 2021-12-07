//
//  StartContainerViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 06.12.2021.
//

import UIKit

class StartContainerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myMapCellLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyMapActivityCollectionViewCell
        
        cell.myMapCellLabel.text
        
        //Почему то не находит класс MyMapActivityCollectionViewCell он вроде присвоен ячейке
        
        
        
    }
    
    
    var myMapCellLabel:[String] = ["Велосипеж", "Бег", "Прыг", "Лыжи"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
