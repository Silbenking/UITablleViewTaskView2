//
//  TableViewCell.swift
//  UITableViewTask2
//
//  Created by Сергей Сырбу on 19.09.2023.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let seconNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let numberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initialize() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
            
        }
        contentView.addSubview(seconNameLabel)
        seconNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
        }
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func configure(name: String, secondName: String, number: String) {
        nameLabel.text = name
        seconNameLabel.text = secondName
        numberLabel.text = number
    }
}
