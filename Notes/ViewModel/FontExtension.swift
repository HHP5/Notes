//
//  FontSizeExtension.swift
//  Notes
//
//  Created by Екатерина Григорьева on 17.03.2021.
//

import Foundation
import UIKit

extension  UITextView {
//MARK: - get text info
    func getFontAlignment() -> FontAlignment{
        
        var result: FontAlignment = .center
        let alignment = self.textAlignment
        
        switch alignment {
        case .center:
            result = .center
        case .justified:
            result = .justify
        default:
            print("Another alignment")
        }
        return result
    }
    
    func getTextAttributes() -> [NSAttributedString.Key: Any]{
        
        let alignment = NSMutableParagraphStyle()
        alignment.alignment = self.getFontAlignment() == .justify ? NSTextAlignment.justified : NSTextAlignment.center
        let style = self.determineFontStyleAndName()
        let size = self.font!.pointSize
        var fontStyle: UIFont!
        
        switch style {
        case (.bold,.montserrat):
            fontStyle = UIFont(name: FontStyle.Bold.montserrat.rawValue, size: size)
        case (.bold,.ubuntu):
            fontStyle = UIFont(name: FontStyle.Bold.ubuntu.rawValue, size: size)
        case (.regular,.montserrat):
            fontStyle = UIFont(name: FontStyle.Regular.montserrat.rawValue, size: size)
        case (.regular,.ubuntu):
            fontStyle = UIFont(name: FontStyle.Regular.ubuntu.rawValue, size: size)
        case(.italic,.montserrat):
            fontStyle = UIFont(name: FontStyle.Italic.montserrat.rawValue, size: size)
        case(.italic,.ubuntu):
            fontStyle = UIFont(name: FontStyle.Italic.ubuntu.rawValue, size: size)
        }
        
        let attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: alignment, .font: fontStyle!]
        
        return attributes
    }
    
    func determineFontStyleAndName() -> (style: FontStyle, fontName: FontName){
        
        let style = self.font?.fontName
        var result: (FontStyle,FontName)!
        switch style{
        case "Montserrat-Italic":
            result = (.regular,.montserrat)
        case "Montserrat-SemiBold":
            result = (.bold,.montserrat)
        case "Montserrat-ExtraLight":
            result = (.regular,.montserrat)
        case "Ubuntu-Light":
            result = (.regular,.ubuntu)
        case "Ubuntu-LightItalic":
            result = (.italic,.ubuntu)
        case "Ubuntu-Regular":
            result = (.bold,.ubuntu)
        default:
            print("Error:")
        }
        return result
    }
    //MARK: - Change text attribute
    
    func changeFontSize(for size: FontSize, in range: NSRange){
        let textAttributes: [NSAttributedString.Key:Any] = getTextAttributes()
        var font: UIFont
        let fontSize = self.font!.pointSize
        switch size {
        case .decrease:
            font = UIFont(name: self.font!.fontName, size: fontSize - 1)!
        case .increase:
            font = UIFont(name: self.font!.fontName, size: fontSize + 1)!
        }
        
    
        
        let newAttributes: [NSAttributedString.Key:Any] = [.font : font]
        let string = NSMutableAttributedString(attributedString: self.attributedText)
        string.addAttributes(newAttributes, range: range)
        self.attributedText = string
        self.selectedRange = range
    }
    
    
    func changeAlignment(for alignment: FontAlignment, in range: NSRange){
        let style = NSMutableParagraphStyle()
        
        switch alignment {
        case .center:
            style.alignment = NSTextAlignment.center
        case .justify:
            style.alignment = NSTextAlignment.justified
        }
        
        let textAttributes: [NSAttributedString.Key:Any] = getTextAttributes()
        let font = textAttributes[.font]
        
        let newAttributes: [NSAttributedString.Key:Any] = [.font : font!, .paragraphStyle : style]
        let string = NSMutableAttributedString(attributedString: self.attributedText)
        string.addAttributes(newAttributes, range: range)
        self.attributedText = string
        self.selectedRange = range
    }
    
    func changeFontStyle(for style: FontStyle, in range: NSRange){
        
        var font: UIFont

        let fontSize = self.font!.pointSize
        let fontName = self.determineFontStyleAndName().fontName
        
        switch fontName {
        case .montserrat:
            
            switch style {
            case .bold:
                font = UIFont(name: FontStyle.Bold.montserrat.rawValue, size: fontSize)!
            case .italic:
                font = UIFont(name: FontStyle.Italic.montserrat.rawValue, size: fontSize)!
            case .regular:
                font = UIFont(name: FontStyle.Regular.montserrat.rawValue, size: fontSize)!
            }

        case .ubuntu:
            
            switch style {
            case .bold:
                font = UIFont(name: FontStyle.Bold.ubuntu.rawValue, size: fontSize)!
            case .italic:
                font = UIFont(name: FontStyle.Italic.ubuntu.rawValue, size: fontSize)!
            case .regular:
                font = UIFont(name: FontStyle.Regular.ubuntu.rawValue, size: fontSize)!
            }
        }
        
        let attr: [NSAttributedString.Key:Any] = getTextAttributes()
        let attributes: [NSAttributedString.Key:Any] = [.font : font, .paragraphStyle : attr[.paragraphStyle] as Any]
        let string = NSMutableAttributedString(attributedString: self.attributedText)
        string.addAttributes(attributes, range: range)
        self.attributedText = string
        self.selectedRange = range
        
    }
    
    func changeFont(for font: FontName, in range: NSRange){
    
        var newFont: UIFont

        let fontSize = self.font!.pointSize
        let fontStyle = self.determineFontStyleAndName().style
        
        switch fontStyle {
        case .bold:
            
            switch font {
            case .montserrat:
                newFont = UIFont(name: FontStyle.Bold.montserrat.rawValue, size: fontSize)!
            case .ubuntu:
                newFont = UIFont(name: FontStyle.Bold.ubuntu.rawValue, size: fontSize)!
            }
            
        case .italic:
            
            switch font {
            case .montserrat:
                newFont = UIFont(name: FontStyle.Italic.montserrat.rawValue, size: fontSize)!
            case .ubuntu:
                newFont = UIFont(name: FontStyle.Italic.ubuntu.rawValue, size: fontSize)!
            }
            
        case .regular:
            
            switch font {
            case .montserrat:
                newFont = UIFont(name: FontStyle.Regular.montserrat.rawValue, size: fontSize)!
            case .ubuntu:
                newFont = UIFont(name: FontStyle.Regular.ubuntu.rawValue, size: fontSize)!
            }
        
        }
        
        let textAttribute: [NSAttributedString.Key:Any] = getTextAttributes()
        let newAttributes: [NSAttributedString.Key:Any] = [.font : newFont, .paragraphStyle : textAttribute[.paragraphStyle] as Any]
        let string = NSMutableAttributedString(attributedString: self.attributedText)
        string.addAttributes(newAttributes, range: range)
        self.attributedText = string
        self.selectedRange = range
    }

}
