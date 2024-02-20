//
//  MainTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/20/24.
//

import UIKit
import SnapKit

struct NotificationNames {
    static let folderAdded = Notification.Name("folderAdded")
    static let listTitleUpdated = Notification.Name("listTitleUpdated")
}

class MainTableViewCell: UITableViewCell {
    
    // UI 구성요소 선언
    let iconImageView = UIImageView()
    public let titleLabel = UILabel()
    let countLabel = UILabel()
    let nextImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(systemName: "list.bullet")
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .white
        
        countLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        countLabel.textColor = .white
        
        nextImageView.image = UIImage(systemName: "chevron.right")
        nextImageView.tintColor = .gray
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(nextImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { make in
            make.trailing.equalTo(nextImageView.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        nextImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(8)
            make.height.equalTo(14)
        }
    }
    
    func configureWith(folder: Folder) {
        titleLabel.text = folder.folderName
        countLabel.text = "\(folder.accountBookList.count)"
    }
}

