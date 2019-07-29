//
//  CollectionViewController.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit


class MainPageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let defaultSize = CGSize(width: 300, height: 400)
    private let reusableIdentifier = "ProjectCollectionViewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCreateButton()
    }
    
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
    }
    
    func setupCreateButton(){
        let createButton = UIButton() //CreateButton implements from UIButton so everything should work as normal
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.setBackgroundImage(UIImage(named: "buttonPlaceholder"), for: .normal)
        createButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        createButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        createButton.layer.shadowRadius = 0.0
        createButton.layer.shadowOpacity = 1.0
        createButton.layer.cornerRadius = 8
        createButton.layer.masksToBounds = false
        self.view.addSubview(createButton)
        createButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        createButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
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
