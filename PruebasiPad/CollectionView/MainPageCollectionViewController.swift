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
    let openStorySegueId = "loadStory"
    let defaultSize = CGSize(width: 320, height: 510)
    private let reusableIdentifier = "ProjectCollectionViewCell"

    var stories: [Story] = [] //We load the stories to this list and display on each cell whatever we have inside this variable.
    var storiesIds: [UUID] = [] //We have to load the uuids, then load the stories from documents that have this IDs.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCreateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadUUIDList()
        loadStories(from: storiesIds)
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) { //We save the uuid list before changing views.
        self.save(uuid: storiesIds)
    }
    
    //MARK: - Setup Functions
    
    func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        mainBackgroundImageView.image = UIImage(named: backgroundImageName)
        mainBackgroundImageView.alpha = 0.8
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Library"
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
    
    // MARK: - NSCoding Protocol
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(storiesIds, forKey: "uuids")
    }
    
    //MARK: - Class Functions
    
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: openStorySegueId, sender: self)
    }
    
    // MARK: - Utility Functions
    
    func loadUUIDList(){
        print("Found \(self.storiesIds.count) items on uuid list")
        for uuid in self.storiesIds{
            print(uuid.uuid)
        }
        
        do {
            let fm = FileManager.default
            let documentsDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let sourceURL = documentsDirectory.appendingPathComponent("storyList")
            let uuidData = try Data(contentsOf: sourceURL, options: .mappedIfSafe)
            let listOfUUID = NSKeyedUnarchiver.unarchiveObject(with: uuidData) as! [UUID]
            print("Before loading \(self.stories)")
            self.storiesIds = listOfUUID
            print("After loading \(self.storiesIds)")
        } catch {
            print("Unable to read Stories UUID List from Documents")
        }
    }
    
    func loadStories(from uuidList: [UUID]){
        for uuid in uuidList {
            loadSingleStory(uuid: uuid)
        }
    }
    
    func loadSingleStory(uuid: UUID){
        do {
            let documentsDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let sourceURL = documentsDirectoryURL.appendingPathComponent("\(uuid)")
            let storyReadData = try Data(contentsOf: sourceURL, options: .mappedIfSafe)
            if let readStory = try NSKeyedUnarchiver.unarchivedObject(ofClass: Story.self, from: storyReadData) {
                self.stories.append(readStory)
            } else {
                
            }
        } catch {
            print(error)
        }
    }
   
    func save(uuid list: [UUID]){
        do {
            let fm = FileManager.default
            let documentsDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let saveFile = documentsDirectory.appendingPathComponent("storyList")
            let uuidData = try NSKeyedArchiver.archivedData(withRootObject: list, requiringSecureCoding: false)
            try uuidData.write(to: saveFile)
        } catch {
            print("Unable to save Stories UUID List to Documents")
        }
            print("Saved uuid list successfully.")
    }
    
    func save(a story: Story){
        do {
            let documentsDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let saveFile = documentsDirectoryURL.appendingPathComponent("\(story.uuid)")
            let storyData = try NSKeyedArchiver.archivedData(withRootObject: story, requiringSecureCoding: false)
            try storyData.write(to: saveFile)
        } catch {
            print("Unable to save Story to Documents")
        }
    }

    
    // MARK: - Actions
    
    @IBAction  func createProjectPressed(sender: UIButton){
        performSegue(withIdentifier: createSegueIdentifier, sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case openStorySegueId: #warning("Queda pendiente, primero hay que conseguir cargar info al SpriteKite, que genere nodos a partir de la data")
//            let cell = sender as! ProjectCollectionViewCell
//            let indexPath = self.collectionView.indexPath(for: cell)
//              ESTO DE ABAJO ES DEL OTRO PROYECTO, PARA REFERENCIA
//            let productView = segue.destination as? ProductDetailViewController
//            productView?.product = products[indexPath!.row]
//            productView?.productListCartControl = self //Referencia de éste view p/inyección
        
        case createSegueIdentifier:
            let createView = segue.destination as? CreateStoryModalViewController
            createView?.mainPageCollectionViewReference = self //Code injection
        default:
            print("¡Oh, Neptuno!")
        }
    }
    
}
