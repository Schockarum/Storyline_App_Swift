//
//  Stories.swift
//  Storyline
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import RealmSwift

class Story: Object {
    
    @objc dynamic var image: Data?
    @objc dynamic var storyName: String?
    @objc dynamic var root: StoryNode?
    @objc dynamic var uuid: String = UUID().uuidString
    
    // MARK: - Helper Functions
    func compress(image: UIImage) -> Data {
        return (image.jpegData(compressionQuality: 0.95)!)
    }
    
    func buildImageFrom(data: Data) -> UIImage {
        return (UIImage(data: data)!)
    }
}

/*Story is the class responsible of storing the starting data of a story, such as the title, the associed image to it and the root node of it.
 It conforms to the NSCoding Protocol so it can be stored and it can persist.*/
