//
//  KeyboardExtension.swift
//  Notes
//
//  Created by Екатерина Григорьева on 15.03.2021.
//

import Foundation
import  UIKit

extension DetailPageController{
    @objc func updateTextView(param: Notification){
        
        let userInfo = param.userInfo
        
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        
        if param.name == UIResponder.keyboardWillHideNotification{
            textField.contentInset = UIEdgeInsets.zero
        }else{
            textField.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            textField.scrollIndicatorInsets = textField.contentInset
        }
        textField.scrollRangeToVisible(textField.selectedRange)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.becomeFirstResponder()
    }
}
