//
//  Note.swift
//  Notes
//
//  Created by Екатерина Григорьева on 11.03.2021.
//

import Foundation
import RealmSwift

class Note: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var textFileName: String = ""
    @objc dynamic var dateCreated: Date?
    @objc dynamic var cgImageData: Data?
    @objc dynamic var scaleImage: Float = 0.0
}
