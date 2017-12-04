//
//  DocumentsTableViewCell.swift
//  ViperDemo
//
//  Created by Thinh Nguyen on 12/3/17.
//  Copyright © 2017 Prospertin. All rights reserved.
//

import UIKit
import AlamofireImage
import ReactiveCocoa
import ReactiveSwift

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var inputTextField: UITextField!
    @IBAction func onTextChange(_ sender: Any) {
        model?.displayTitle.value = inputTextField!.text!
    }
    
    @IBInspectable var BgColor: UIColor = UIColor(red: (234/255.0), green: (234/255), blue: (234/255.0), alpha: 1.0)
    @IBInspectable var Theme: String = "DarkTheme"
    
    @IBOutlet weak var displayUrl: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openingText: UITextView!
    
    var model:DocumentUIModel?
    
    func set(forModel model: DocumentUIModel) {
        self.selectionStyle = .none
        // Binding
        titleLabel.reactive.text <~ model.displayTitle
        openingText.reactive.text <~ model.displayMatchSentence
        // Regular SET to piss Tim off
        displayUrl.text = model.displayUrl
        
        self.model = model
        //setStyles()
        self.backgroundColor = BgColor
    }
}
    
//extension DocumentTableViewCell {
//    fileprivate func setStyles() {
//        self.backgroundColor = BgColor
//    }
//}

