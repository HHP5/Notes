//
//  DetailPageModel.swift
//  Notes
//
//  Created by Екатерина Григорьева on 11.03.2021.
//

import Foundation
import UIKit
import RealmSwift

class DetailPageModel: DetailPageModelType{
    
    private var note: Note
    let realm = try! Realm()
    
    var title: String {
        return note.title
    }
    
    init(note: Note) {
        self.note = note
    }
    
    var attrText: NSAttributedString?{
        
        if let rtfdData = loadFromDiskWith(fileName: note.textFileName){
            do{
                let attributedString = try NSAttributedString(data: rtfdData, options: [.documentType: NSAttributedString.DocumentType.rtfd], documentAttributes: nil)
                attributedString.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: attributedString.length), options: []) { (value, range, stop) in
                    if (value is NSTextAttachment){
                        let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                        if let textAttachment = attachment{
                            
                            guard let cgImage = note.cgImageData, let image = UIImage(data: cgImage) else { return }
                            
                            textAttachment.image = UIImage(cgImage: image.cgImage!, scale: CGFloat(note.scaleImage), orientation: .up)
                        }
                    }
                }
                return attributedString
                
            }catch let error as NSError {
                NSLog(error.localizedDescription, error)
            }
        }
        return nil
    }
    
    func addCgImageData(_ cgImage: UIImage, to text: UITextView) {
       
        var isAdded = false
        
        attrText!.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: attrText!.length), options: []) { (value, range, stop) in
            if (value is NSTextAttachment){
                let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                if let textAttachment = attachment{
                    
                    if textAttachment.image != nil{  // Если картинка уже есть, то происходит удаление - сохранение новой
                        
                        let mutableAttr = attrText!.mutableCopy() as! NSMutableAttributedString
                        mutableAttr.replaceCharacters(in: range, with: "")
                        text.attributedText = mutableAttr
                        
                        updateNote(with: text)
                        addImageDataAndScale(image: cgImage)
                        isAdded = true
                        textAttachment.image = UIImage(cgImage: cgImage.cgImage!, scale: CGFloat(Float(cgImage.scale)), orientation: .up)
                    }
                }
            }
        }
        //На случай если не было картинок и текста
        if !isAdded{
            addImageDataAndScale(image: cgImage)
        }
    }

    private func addImageDataAndScale(image: UIImage){
        do {
            try self.realm.safeWrite {
                note.scaleImage = Float(image.scale)
                guard let cgImageData = image.jpegData(compressionQuality: 0.5) else {return}
                note.cgImageData = cgImageData
            }
        }catch let error as NSError {
            NSLog(error.localizedDescription, error)
        }
    }
    
    private func attributedStringFile(from newNote: UITextView){
        do {
            var attributedString = NSAttributedString()
            attributedString = newNote.attributedText
            let rtfdData = try attributedString.data(from: NSRange(location: 0, length: attributedString.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtfd])

            updateFile(fileName: note.textFileName, with: rtfdData)
            
        } catch let error as NSError {
            NSLog(error.localizedDescription, error)
        }
    }
    
    func updateNote(with newNote: UITextView) {
        
        DispatchQueue.main.async { [self] in
        
            do {
                
                try self.realm.safeWrite{
                    
                    attributedStringFile(from: newNote)
                    
                    if let text = newNote.text{
                        let entiryText = text.components(separatedBy: .newlines)
                        
                        let title = entiryText[0] == "" ? " " : String(entiryText[0])
                        note.title = title
                        note.dateCreated = Date()
                    }
                }
            } catch let error as NSError {
                NSLog(error.localizedDescription, error)
            }
        }
    }
    
    
    //MARK: - WORK WITH FILE ON DISK
    
    func updateFile(fileName: String, with file: Data){
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return}
        let fileURL = documentsDirectory.appendingPathComponent(fileName).absoluteURL
        
            do {
                try file.write(to: fileURL)
                
            } catch let error as NSError {
                NSLog(error.localizedDescription, error)
            }
    }
    
    func loadFromDiskWith(fileName: String) -> Data?{
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let fileURL = documentsDirectory.appendingPathComponent(fileName).absoluteURL
        
        do {
            
            let data = try Data(contentsOf: fileURL)
            return data
            
        } catch let error as NSError {
            NSLog(error.localizedDescription, error)
        }
        
        return nil
    }
    
    
    //MARK: - TEXT FONT
    
    func changeTextAlignment(for text: UITextView, alignment: FontAlignment, range: NSRange){
        text.changeAlignment(for: alignment, in: range)
    }
    
    func changeFontTextSize(for text: UITextView, size: FontSize, range: NSRange){
        text.changeFontSize(for: size, in: range)
    }
    
    func changeFontStyle(for text: UITextView, style: FontStyle, range: NSRange){
        text.changeFontStyle(for: style, in: range)
    }
    
    func getAttributes(for text: UITextView) -> [NSAttributedString.Key: Any]{
        return text.getTextAttributes()
    }
    
    func changeFont(for text: UITextView, font: FontName, range: NSRange) {
        text.changeFont(for: font, in: range)
    }
}
