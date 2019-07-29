//
//  CollectionViewController.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit


class MainPageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let defaultSize = CGSize(width: 300, height: 200)
    private let reusableIdentifier = "ProjectCollectionViewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return defaultSize
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        #warning("Número de celdas por mostrar, hay que poner el número de proyectos guardados una vez que logremos guardar cosas xddd")
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! ProjectCollectionViewCell
        
        //CELL Configurations like size usw. (cell.imageView.image = blablabla; cell.label.text = blabalba)
        
        return cell
    }
    
}
