//
//  TableViewCell.swift
//  Notes
//
//  Created by Екатерина Григорьева on 11.03.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    var cellModel: TableCellModelType?{
        willSet(cellModel) {
            guard let cellModel = cellModel else { return }
            
            titleLabel.textColor = cellModel.title == "empty" ? .gray : .black
            titleLabel.text = cellModel.title
            
            dateLabel.text = cellModel.dateCreated

        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStyle.Bold.ubuntu.rawValue, size: 22)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStyle.Regular.ubuntu.rawValue, size: 15)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraint()
        overrideUserInterfaceStyle = .light
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews(){
        addSubview(titleLabel)
        addSubview(dateLabel)
    }
    
    private func setConstraint(){

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 25).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

    }
}
