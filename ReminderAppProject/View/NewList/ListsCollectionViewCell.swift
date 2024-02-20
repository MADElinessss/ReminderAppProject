//
//  ListsCollectionViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/20/24.
//

import UIKit

class ListsCollectionViewCell: BaseCollectionViewCell {
    
    let iconButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .listGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(iconButton)
    }
    
    override func configureLayout() {
        iconButton.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        iconButton.contentMode = .scaleAspectFit
        
        iconButton.clipsToBounds = true
        iconButton.layer.cornerRadius = 20
    }
    
}

#Preview{
    ListsCollectionViewCell()
}
