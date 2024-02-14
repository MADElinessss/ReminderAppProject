//
//  MainViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import SnapKit
import UIKit

class MainViewController: BaseViewController {
    
    let moreButton = UIButton()
    let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
    var leftToolBarButton = UIBarButtonItem()
    var rightToolBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHeirarchy() {
        view.addSubview(moreButton)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    override func configureConstraints() {
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.width.height.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(48)
        }
    }
    
    override func configureView() {
        moreButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        moreButton.contentMode = .scaleToFill
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.backgroundColor = .black
        
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 40, weight: .semibold)
        titleLabel.textColor = .gray
        
        self.navigationController?.isToolbarHidden = false
        leftToolBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(leftToolBarButtonTapped))
        rightToolBarButton = UIBarButtonItem(title: "최신순", style: .plain, target: self, action: #selector(rightToolBarButtonTapped))

    }
    
    @objc func leftToolBarButtonTapped() {
        
    }
    
    @objc func rightToolBarButtonTapped() {
        
    }
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.1)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.layer.cornerRadius = 15
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }

}

#Preview {
    MainViewController()
}
