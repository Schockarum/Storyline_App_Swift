//
//  File.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class Chapter: NSObject, NSSecureCoding{

    static var supportsSecureCoding: Bool = true

    var chapterTitle: String
    var contentsOfChapter: NSAttributedString
    
    init(withTitle: String = "New Chapter", chapterContents: NSAttributedString = NSAttributedString(string: "")) { //With default values
        self.chapterTitle = withTitle
        self.contentsOfChapter = chapterContents
    }
    
    // MARK: - NSCoding Protocol
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(of: [], forKey: "chapterTitle")
            else { return nil }
        guard let contents = aDecoder.decodeObject(of: NSAttributedString.self, forKey: "contentsOfChapter")
            else { return nil }
        self.init(withTitle: title as! String, chapterContents: contents)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(chapterTitle, forKey: "chapterTitle")
        aCoder.encode(contentsOfChapter, forKey: "contentsOfChapter")
    }
    
}


/*Chapter class is in charge of storing the information that each SpriteKitNode will store, that way, we create nodes with the content already inside them*/
