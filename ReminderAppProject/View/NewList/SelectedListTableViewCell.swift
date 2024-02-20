//
//  SelectedListTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/20/24.
//

import SnapKit
import RealmSwift
import UIKit

class SelectedListTableViewCell: UITableViewCell {
    
    let listImage = UIImageView()
    let textField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .listGray
        
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(listImage)
        contentView.addSubview(textField)
        
        listImage.snp.makeConstraints { make in
            make.top.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.width.height.equalTo(100)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(listImage.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(60)
        }
        
        listImage.image = UIImage(systemName: "list.bullet")
        listImage.contentMode = .scaleAspectFit
        listImage.tintColor = .white
        listImage.backgroundColor = .systemRed
        listImage.clipsToBounds = true
        listImage.layer.cornerRadius = 50
        
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "목록 이름",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textAlignment = .center
        textField.backgroundColor = .darkGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 15
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    @objc func textFieldEditingChanged() {
        let data = ["listTitle": textField.text ?? ""]
        
        NotificationCenter.default.post(name: NotificationNames.listTitleUpdated, object: nil, userInfo: data)
        
        
    }
}

#Preview {
    SelectedListTableViewCell()
}
