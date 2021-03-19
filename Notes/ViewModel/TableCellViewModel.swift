//
//  TableCellViewModel.swift
//  Notes
//
//  Created by Екатерина Григорьева on 11.03.2021.
//

import Foundation
import UIKit

class TableCellViewModel: TableCellModelType{
    
    private var note: Note
    
    var title: String {
        return note.title
    }
    
    var dateCreated: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY HH:mm"
        let date = dateFormatter.string(from: note.dateCreated!)
        return date
    }
    
    init(note: Note) {
        self.note = note
    }
}
