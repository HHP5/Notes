//
//  FontStyle.swift
//  Notes
//
//  Created by Екатерина Григорьева on 17.03.2021.
//

import Foundation

enum FontStyle{
    
    case regular
    case italic
    case bold
    
    enum Regular: String {
        case montserrat = "Montserrat-ExtraLight"
        case ubuntu = "Ubuntu-Light"
    }
        
    enum Italic: String {
        
        case montserrat = "Montserrat-Italic"
        case ubuntu = "Ubuntu-LightItalic"

    }

    enum Bold: String{
        
        case montserrat = "Montserrat-SemiBold"
        case ubuntu = "Ubuntu-Regular"
        
    }
}
