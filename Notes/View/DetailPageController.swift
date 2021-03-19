//
//  NoteDetailPageController.swift
//  Notes
//
//  Created by Екатерина Григорьева on 10.03.2021.
//

import Foundation
import UIKit

class DetailPageController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    
    let textField: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.font = UIFont(name: FontStyle.Regular.montserrat.rawValue, size: 25)
        return field
    }()
    
    var detailModel: DetailPageModelType? {
        willSet(detailModel) {
            guard let detailModel = detailModel else { return }
            
            if let attr = detailModel.attrText{
                textField.attributedText = attr
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        setKeybordSetting()
        setImagePickerSetting()
        setTextViewSetting()
        addSubviewsAndConstraits()
        setPlaceholder()
        setAccessoryView()
        setNewNoteButton()
        
    }
    
    //MARK: - SETTING
    
    private func setKeybordSetting(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    private func setNewNoteButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func setImagePickerSetting() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    private func setTextViewSetting() {
        textField.delegate = self
        textField.isScrollEnabled = true
        textField.isSelectable = true
    }
    
    private func addSubviewsAndConstraits() {
        view.addSubview(textField)
        view.backgroundColor = #colorLiteral(red: 0.905033648, green: 0.9984137416, blue: 0.9576342702, alpha: 1)
        textField.backgroundColor = view.backgroundColor
        
        textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        
        textField.heightAnchor.constraint(equalToConstant: view.frame.height - 200).isActive = true
    }
    
    
    
    private func setPlaceholder()  {
        if let detailModel = detailModel {
            
            if detailModel.title == "empty" {
                textField.text = "Write something"
                textField.textColor = .gray
            }
        }
    }
    
    private func setAccessoryView() {
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        toolBar.barStyle = .black
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhoto))
        cameraButton.tintColor = .white
        
        let boldFont = UIBarButtonItem(image: UIImage(systemName: "bold"), style: .done, target: self, action: #selector(boldFontButtonPressed))
        boldFont.tintColor = .white
        
        let italicFont = UIBarButtonItem(image: UIImage(systemName: "italic"), style: .done, target: self, action: #selector(italicFontButtonPressed))
        italicFont.tintColor = .white
        
        let regularFont = UIBarButtonItem(image: UIImage(systemName: "character"), style: .done, target: self, action: #selector(regularFontButtonPressed))
        regularFont.tintColor = .white
        
        let increaseFontSize = UIBarButtonItem(image: UIImage(systemName: "textformat.size"), style: .done, target: self, action: #selector(increaseFontSizeButtonPressed))
        increaseFontSize.tintColor = .white
        
        let decreaseImage = UIImage(cgImage: (UIImage(systemName: "textformat.size")?.cgImage)!, scale: 1.5, orientation: .upMirrored)
        
        let decreaseFontSize = UIBarButtonItem(image: decreaseImage, style: .done, target: self, action: #selector(decreaseFontSizeButtonPressed))
        decreaseFontSize.tintColor = .white
        
        let textJustify = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .done, target: self, action: #selector(textJustifyButtonPressed))
        textJustify.tintColor = .white
        
        let textAligncenter = UIBarButtonItem(image: UIImage(systemName: "text.aligncenter"), style: .done, target: self, action: #selector(textAligncenterButtonPressed))
        textAligncenter.tintColor = .white
        
        let choseFontButton = UIBarButtonItem(image: UIImage(systemName: "text.redaction"), style: .done, target: self, action: #selector(montserratFontButtonPressed))
        choseFontButton.tintColor = .white
        
        var items = [UIBarButtonItem]()
        items.append(cameraButton)
        items.append(flexSpace)
        items.append(boldFont)
        items.append(flexSpace)
        items.append(italicFont)
        items.append(flexSpace)
        items.append(regularFont)
        items.append(flexSpace)
        items.append(increaseFontSize)
        items.append(flexSpace)
        items.append(decreaseFontSize)
        items.append(flexSpace)
        items.append(textJustify)
        items.append(flexSpace)
        items.append(textAligncenter)
        items.append(flexSpace)
        items.append(choseFontButton)
        
        toolBar.items = items
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK: - Button Logic
    
    @objc private func addPhoto() {
        present(imagePicker, animated: true)
    }
    
    @objc private func boldFontButtonPressed() {
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        if let detailModel = detailModel {
            detailModel.changeFontStyle(for: textField, style: .bold, range: range)
        }
    }
    
    @objc private func italicFontButtonPressed() {
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        if let detailModel = detailModel {
            detailModel.changeFontStyle(for: textField, style: .italic, range: range)
        }
    }
    
    @objc private func regularFontButtonPressed() {
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        if let detailModel = detailModel {
            detailModel.changeFontStyle(for: textField, style: .regular, range: range)
        }
    }
    
    @objc private func increaseFontSizeButtonPressed() {
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        if let detailModel = detailModel {
            detailModel.changeFontTextSize(for: textField, size: .increase, range: range)
        }
    }
    
    @objc private func decreaseFontSizeButtonPressed() {
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        if let detailModel = detailModel {
            detailModel.changeFontTextSize(for: textField, size: .decrease, range: range)
        }
    }
    
    @objc private func textJustifyButtonPressed() {
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        if let detailModel = detailModel {
            detailModel.changeTextAlignment(for: textField, alignment: .justify, range: range)
        }
    }
    
    @objc private func textAligncenterButtonPressed(){
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        if let detailModel = detailModel {
            detailModel.changeTextAlignment(for: textField, alignment: .center, range: range)
        }
    }
    
    @objc private func montserratFontButtonPressed(){
        let range = textField.selectedRange.length == 0 ? NSMakeRange(0, textField.attributedText.length) : textField.selectedRange
        
        let alertController = UIAlertController(title: "Choose Font", message: nil, preferredStyle: .actionSheet)
        
        let montserratFont = UIAlertAction(title: FontName.montserrat.rawValue, style: .default) { [self] _ in
            
            if let detailModel = detailModel {
                detailModel.changeFont(for: textField, font: .montserrat, range: range)
            }
        }
        let ubuntuFont = UIAlertAction(title: FontName.ubuntu.rawValue, style: .default){ [self] _ in
            
            if let detailModel = detailModel {
                detailModel.changeFont(for: textField, font: .ubuntu, range: range)
            }
        }
        
        alertController.addAction(montserratFont)
        alertController.addAction(ubuntuFont)
        alertController.pruneNegativeWidthConstraints()
        alertController.view.layoutIfNeeded()
        
        present(alertController, animated: true)
        
    }

    @objc private func doneButtonPressed(){
        DispatchQueue.main.async { [self] in
            if let detailModel = detailModel {
                detailModel.updateNote(with: textField)
            }
        }
        
    }
    
    private func addImageToScreen(image: UIImage){
        
        let textAttachment = NSTextAttachment()
        let imageWidth = image.size.width;
        let scaleFactor = imageWidth / (textField.frame.size.width - 10);
        let cgImage = UIImage(cgImage: image.cgImage!, scale: scaleFactor, orientation: .up)
        textAttachment.image = cgImage
        
        if let detailModel = detailModel{
            detailModel.updateNote(with: textField)
            detailModel.addCgImageData(cgImage, to: textField)
            
            let imageString = NSAttributedString(attachment: textAttachment)
            
            // для того, чтобы форматирование текста после вставки картинки остался таким же
            let attributes: [NSAttributedString.Key: Any] = detailModel.getAttributes(for: textField)
            
            textField.textStorage.insert(imageString, at: textField.selectedRange.location)
            textField.textStorage.addAttributes(attributes, range: NSRange(location: 0, length: textField.attributedText.length))
            
            //курсор в конец
            let newPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
    
    func throwAlertControllerWith(message: String, alternativeAction: UIAlertAction?){
        let alertController = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if let action = alternativeAction{
            alertController.addAction(action)
        }
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
}
//MARK: - UI TextView Delegate
extension DetailPageController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //Убирает placeholder когда пользователь начинает что-то писать
        if textView.text == "Write something" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
}

//MARK: - ImagePicker
extension DetailPageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            imagePicker.dismiss(animated: true, completion: nil)
            
            let openImagePickerAgain = UIAlertAction(title: "Try again", style: .default) {  [weak self] _ in
                self?.present(self!.imagePicker, animated: true)
            }
            
            DispatchQueue.main.async { [self] in
                
                if let imageData = userPickedImage.jpegData(compressionQuality: 0){
                    if let image = UIImage(data: imageData) {
                        
                        addImageToScreen(image: image)
                        
                    }else{
                        throwAlertControllerWith(message: "Incorrect image format", alternativeAction: openImagePickerAgain)
                    }
                    
                }else{
                    throwAlertControllerWith(message: "An error occurred while saving the image", alternativeAction: openImagePickerAgain)
                }
            }
            
        }
    }
    
}


