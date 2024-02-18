//
//  AllTasksTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import SnapKit
import UIKit

class AllTasksTableViewCell: UITableViewCell {
    
    let checkBox = UIButton()
    let taskTitle = UILabel()
    let taskMemo = UILabel()

    var isChecked: Bool = false {
        didSet {
            checkBox.reloadInputViews()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .buttonGray
        
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(checkBox)
        contentView.addSubview(taskTitle)
        contentView.addSubview(taskMemo)
        
        checkBox.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        taskTitle.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(8)
            make.top.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        taskMemo.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(8)
            make.top.equalTo(taskTitle.snp.bottom)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        
        taskTitle.text = "title"
        taskTitle.textColor = .white
        
        taskMemo.text = ""
        taskMemo.textColor = .gray
        
        checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
    }

    @objc func checkBoxTapped() {
        isChecked.toggle()
        if isChecked {
            checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            checkBox.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            
            // TODO: 완료됨으로 처리 후 뷰 reload
        }
    }
}

#Preview {
    AllTasksTableViewCell()
}
