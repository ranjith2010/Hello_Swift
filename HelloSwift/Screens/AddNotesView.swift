//
//  AddNotesView.swift
//  HelloSwift
//
//  Created by Ranjith Kumar on 28/10/2016.
//  Copyright © 2016 Ranjith Kumar. All rights reserved.
//

import UIKit

protocol AddNotesProtocol: class {
    func didTapSaveButton(_ title: String?, body: String?)
}

class AddNotesView: BaseView {
    
    var titleTextField: UITextField?
    var bodyTextView: UITextView?
    var saveButton: UIButton?
    weak var delegate: AddNotesProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createViews() {
        self.titleTextField = UITextField()
        self.titleTextField?.borderStyle = .roundedRect
        self.titleTextField?.placeholder = "Title"
        self.titleTextField?.font = .appThemeBoldFontWithSize(15)
        self.addSubview(self.titleTextField!)
        
        self.bodyTextView = UITextView()
        self.bodyTextView?.layer.cornerRadius = 4.0
        self.bodyTextView?.clipsToBounds = true
        self.bodyTextView?.font = .appThemeRegularFontWithSize(15)
        self.bodyTextView?.layer.borderColor = UIColor.lightGray.cgColor
        self.bodyTextView?.layer.borderWidth = 0.5
        self.addSubview(self.bodyTextView!)
        
        self.saveButton = UIButton()
        self.saveButton?.setTitle("Save", for: .normal)
        self.saveButton?.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        self.saveButton?.layer.cornerRadius = 4.0
        self.saveButton?.setTitleColor(.white, for: .normal)
        self.saveButton?.backgroundColor = .blue

        self.saveButton?.titleLabel?.font = .appThemeBoldFontWithSize(17)
        self.saveButton?.titleLabel?.textAlignment = .center
        self.addSubview(self.saveButton!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let topInset: CGFloat = 20.0
        let leftInset: CGFloat = 20.0
        let height: CGFloat = 40.0
        let availableWidth = self.bounds.width - (2*leftInset)
        
        self.titleTextField?.frame = CGRect(x:leftInset, y:topInset, width:availableWidth, height:height)
        
        self.bodyTextView?.frame = CGRect(x:leftInset, y:((self.titleTextField?.frame)?.maxY)!+20,width:availableWidth, height:(2*height))
        
        self.saveButton?.frame = CGRect(x:leftInset, y:((self.bodyTextView?.frame)?.maxY)!+20, width:availableWidth, height:height+10)
        
    }
    
    // MARK:: Selectors
    @objc fileprivate func didTapSaveButton() {
        self.delegate?.didTapSaveButton(self.titleTextField?.text, body: self.bodyTextView?.text)
    }

}
