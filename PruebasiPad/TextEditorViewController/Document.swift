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
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: textToSave, requiringSecureCoding: true)
            return archivedData
        } catch {
            print("Something went wrong with the contents to save")
        }
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let data = contents as? Data else { return }
        let filecontent = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSAttributedString
        text = filecontent
    }
}
