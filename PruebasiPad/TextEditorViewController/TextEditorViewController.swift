//
//  DocumentViewController.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/30/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class TextEditorViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var chapterNameLabel: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    #warning("Antes usabamos un document, ahora necesitamos guardar lo que se modifique del text view en un Chapter")
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup Functions
    
    func setupTextView(){
        textView.delegate = self //TextView delegate
        textView.backgroundColor = .clear
        textView.textColor = .black
        let font = UIFont(name: "Avenir Next", size: 25)
        textView.font = font
        //Setup scroll and adaptative keyboard scroll
        NotificationCenter.default.addObserver(self, selector: #selector(TextEditorViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TextEditorViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    // MARK: - Override functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //Hide Keyboard
        super.touchesBegan(touches, with: event)
        super.view.endEditing(true)
    }
    
    // MARK: - Helper functions
    
    func textViewDidChange(_ textView: UITextView) { //Does something everytime the text changes
        document?.text = textView.attributedText
        document?.updateChangeCount(.done)
    }
    
    //Get keyboard frame not to interfere with text in textView
    @objc func updateTextView(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardEndFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification
        {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    // MARK: - Actions
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            //self.textViewDidChange(self.textView)
            self.document?.close(completionHandler: nil)
        }
    }
}
