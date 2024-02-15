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
            make.leading.equalTo(checkBox.snp.trailing).inset(8)
            make.top.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        taskMemo.snp.makeConstraints { make in
            make.top.equalTo(taskTitle.snp.bottom)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
        
        taskTitle.text = "title"
        taskTitle.textColor = .white
        
        taskMemo.text = "memo"
        taskMemo.textColor = .white
    }

}

#Preview {
    AllTasksTableViewCell()
}
