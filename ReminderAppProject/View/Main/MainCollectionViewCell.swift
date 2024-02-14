//
//  MainCollectionViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import SnapKit
import UIKit

class MainCollectionViewCell: BaseCollectionViewCell {
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let taskCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(taskCount)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(titleLabel.snp.top)
            make.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        taskCount.snp.makeConstraints { make in
            make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
    }
    
    override func configureView() {
        iconImageView.image = UIImage(systemName: "calendar")
        iconImageView.tintColor = .white
        iconImageView.backgroundColor = .systemBlue
        iconImageView.clipsToBounds = true
        
        iconImageView.layer.cornerRadius = 15
        
        titleLabel.text = "오늘"
        titleLabel.textColor = .lightGray
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
}

#Preview {
    MainCollectionViewCell()
}