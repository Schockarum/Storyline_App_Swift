//
//  File.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import RealmSwift

class Chapter: Object {


    var chapterTitle: String?
    var contentsOfChapter: String?

}


/*Chapter class is in charge of storing the information that each SpriteKitNode will store, that way, we create nodes with the content already inside them*/
