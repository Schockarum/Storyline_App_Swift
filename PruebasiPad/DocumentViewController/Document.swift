//
//  Document.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/29/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    var text: NSAttributedString? = nil
    
    override func contents(forType typeName: String) throws -> Any {
        guard let textToSave = text else { return Data() }
        return NSKeyedArchiver.archivedData(withRootObject: textToSave)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let data = contents as? Data else { return }
        guard let filecontent = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSAttributedString else {return}
        text = filecontent
    }
}
