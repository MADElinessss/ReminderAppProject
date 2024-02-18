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
    var titleLabel = UILabel()
    var taskCount = UILabel()
    
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
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(titleLabel.snp.top)
            make.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
        
        taskCount.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.width.height.equalTo(36)
        }
    }
    
    override func configureView() {
        
        // TODO: 사이즈 조정 
        // 1. symbol scale
        // 2. preferred symbol configuration
        // -> point size를 조정
        // sf symbol
        
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .light)
        self.iconImageView.image = UIImage(systemName: "calendar")
        self.iconImageView.preferredSymbolConfiguration = config
        
//        iconImageView.image = UIImage(systemName: "calendar")
        iconImageView.tintColor = .white
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 15
        iconImageView.contentMode = .scaleToFill
        
        titleLabel.text = "오늘"
        titleLabel.textColor = .lightGray
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        taskCount.text = "0"
        taskCount.textColor = .white
        taskCount.font = .systemFont(ofSize: 24, weight: .bold)
    }
}
