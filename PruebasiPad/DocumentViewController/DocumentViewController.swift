//
//  DocumentViewController.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/30/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var chapterNameLabel: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.delegate = self //Si no ponemos el delegado, no podemos revisar cambios en él
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.textView.attributedText = self.document?.text
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    func textViewDidChange(_ textView: UITextView) { //Monitor de cambio en el texto, aqui autoguardamos
        document?.text = textView.attributedText
        document?.updateChangeCount(.done)
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            //self.textViewDidChange(self.textView)
            self.document?.close(completionHandler: nil)
        }
    }

    func setupView(){
        textView.backgroundColor = .clear
        textView.textColor = .black
    }
}
