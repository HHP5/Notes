//
//  MainPageViewModel.swift
//  Notes
//
//  Created by Екатерина Григорьева on 11.03.2021.
//

import Foundation
import RealmSwift

class TableViewModel: TableViewModelType{
    
    let realm = try! Realm()
    
    var notes: Results<Note>?
    
    var numberOfRow: Int{
        return notes?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableCellModelType?{
        guard let note = notes?[indexPath.row] else {fatalError("No notes")}
        return TableCellViewModel(note: note)
    }
    
    func setFirstNote(){
        if notes?.count == 0{
            let defaultNote = Note()
            defaultNote.title = "Your First Note"
            defaultNote.dateCreated = Date()
            defaultNote.textFileName = nameFileSavedInDirectory()
            saveNote(defaultNote)
        }
    }
    
    func didSelectRow(at index: Int)-> DetailPageModel{
        guard let selectedNote = notes?[index] else {fatalError("No note")}
        return DetailPageModel(note: selectedNote)
    }
    

    private func saveNote(_ note: Note){
        do{
            try realm.safeWrite{
                realm.add(note)
            }
        }catch let error as NSError {
            NSLog(error.localizedDescription, error)
        }
    }
    
    func loadNotes(){
        notes = realm.objects(Note.self)
    }
    
    func deleteNote(at index: Int){
        if let noteForDelete = notes?[index]{
            deleteFile(noteForDelete.textFileName)
            do{
                try self.realm.safeWrite{
                    self.realm.delete(noteForDelete)
                }
            }catch let error as NSError {
                NSLog(error.localizedDescription, error)
            }
        }
    }
    
    private func deleteFile(_ fileName: String){
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(fileName).absoluteURL
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            
                do {
                    try FileManager.default.removeItem(atPath: fileURL.path)
                    
                }catch let error as NSError {
                    NSLog(error.localizedDescription, error)
                }
            }
        
    }
    
    func createNewNote()-> DetailPageModel{
        let newNote = Note()
        newNote.title = "empty"
        newNote.dateCreated = Date()
        newNote.textFileName = nameFileSavedInDirectory()
        saveNote(newNote)
        return DetailPageModel(note: newNote)
    }
    
    //MARK: - WORK WITH FILE ON DISK
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    private func nameFileSavedInDirectory() -> String{
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return ""}
        let fileName = "\(randomString(length: 10)).rtfd"
        let fileURL = documentsDirectory.appendingPathComponent(fileName).absoluteURL
        
        let attributedString = NSAttributedString()
        
            
            do{
                let rtfdData = try attributedString.data(from: NSRange(location: 0, length: attributedString.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtfd])
                do {
                    try rtfdData.write(to: fileURL)
                } catch let error as NSError {
                    NSLog(error.localizedDescription, error)
                }
            }catch let error as NSError {
                NSLog(error.localizedDescription, error)
            }
        
        
        return fileName
    }
    
}
