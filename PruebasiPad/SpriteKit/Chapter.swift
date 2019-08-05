//
//  File.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class Chapter: NSObject, NSCoding{

    var chapterTitle: String?
    var contentsOfChapter: NSAttributedString?
    
    init(withTitle: String, chapterContents: NSAttributedString) {
        self.chapterTitle = withTitle
        self.contentsOfChapter = chapterContents
    }
    
    // MARK: - NSCoding Protocol
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "chapterTitle") as? String,
            let contents = aDecoder.decodeObject(forKey: "contentsOfChapter") as? NSAttributedString else
        { return nil }
        self.init(withTitle: title, chapterContents: contents)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(chapterTitle, forKey: "chapterTitle")
        aCoder.encode(contentsOfChapter, forKey: "contentsOfChapter")
    }
}


/*Chapter class is in charge of storing the information that each SpriteKitNode will store, that way, we create nodes with the content already inside them*/
