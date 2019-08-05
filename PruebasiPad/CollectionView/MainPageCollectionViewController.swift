//
//  CollectionViewController.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit


class MainPageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    let backgroundImageName = "main background"
    let createSegueIdentifier = "createStory"
    let defaultSize = CGSize(width: 320, height: 510)
    private let reusableIdentifier = "ProjectCollectionViewCell"

    #warning("Como éste valor se inicializa en cero cada que abrimos la app, debemos cargar información para rellenar ésta variable antes de cargar las celdas.")
    var stories: [Story] = [] //We load the stories to this list and display on each cell whatever we have inside this variable.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCreateButton()
        loadStories()
    }
    
    //MARK: Setup Functions
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        mainBackgroundImageView.image = UIImage(named: backgroundImageName)
        mainBackgroundImageView.alpha = 0.8
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupCreateButton(){
        let createButton = UIButton() //CreateButton implements from UIButton so everything should work as normal
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.setBackgroundImage(UIImage(named: "blue node"), for: .normal)
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
        createButton.addTarget(self, action: #selector(MainPageCollectionViewController.createProjectPressed),for: .touchUpInside)
    }
    
    #warning("Hay que cargar las historias que tenemos codificadas y agregarlas a la variable de clase que las contendrá")
    func loadStories(){
        
    }
    
    //MARK: Class Functions
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return defaultSize
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! ProjectCollectionViewCell
        cell.projectNameLabel.text = stories[indexPath.row].storyName
        cell.projectImageView.image = stories[indexPath.row].image
        return cell
    }
    
    //MARK: Actions
    
    @IBAction  func createProjectPressed(sender: UIButton){
        performSegue(withIdentifier: createSegueIdentifier, sender: self)
    }
    
}
