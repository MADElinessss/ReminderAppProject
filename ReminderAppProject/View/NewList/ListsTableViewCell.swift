//
//  ListsTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/20/24.
//

import SnapKit
import RealmSwift
import UIKit

let colorList: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPurple, .systemBrown]

class ListsTableViewCell: UITableViewCell {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .buttonGray
        
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        return layout
    }
    
    func configureView() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        collectionView.backgroundColor = .listGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListsCollectionViewCell.self, forCellWithReuseIdentifier: "ListsCollectionViewCell")
        
    }
}

extension ListsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListsCollectionViewCell", for: indexPath) as! ListsCollectionViewCell
        
        cell.iconButton.backgroundColor = colorList[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
}

#Preview {
    ListsTableViewCell()
}
