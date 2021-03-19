//
//  DetailPageModelType.swift
//  Notes
//
//  Created by Екатерина Григорьева on 11.03.2021.
//

import Foundation
import UIKit

protocol DetailPageModelType {
    
    var title: String {get}
        
    func updateNote(with newNote: UITextView)

    func addCgImageData(_ cgImage: UIImage, to text: UITextView)
    
    var attrText: NSAttributedString? {get}
    
    func changeFontStyle(for text: UITextView, style: FontStyle, range: NSRange)
    
    func changeTextAlignment(for text: UITextView, alignment: FontAlignment, range: NSRange)
    
    func changeFontTextSize(for text: UITextView, size: FontSize, range: NSRange)
    
    func changeFont(for text: UITextView, font: FontName, range: NSRange)
    
    func getAttributes(for text: UITextView) -> [NSAttributedString.Key: Any]


}
