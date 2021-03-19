//
//  TableViewModelType.swift
//  Notes
//
//  Created by Екатерина Григорьева on 11.03.2021.
//

import Foundation

protocol TableViewModelType {
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableCellModelType?
    
    var numberOfRow: Int {get}
    
    func setFirstNote()
    
    func didSelectRow(at index: Int) -> DetailPageModel

//    func updateNotes(with: String)
    
//    func shareNote(at index: Int) -> Any
    
    func deleteNote(at index: Int)
    
    func createNewNote()-> DetailPageModel
    
}
