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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = false
    }

    
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
            make.top.equalTo(view).offset(36)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(48)
        }
    }
    
    override func configureView() {
        moreButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        moreButton.contentMode = .scaleAspectFill
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.backgroundColor = .black
        
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 40, weight: .semibold)
        titleLabel.textColor = .gray
        
        
        self.navigationController?.toolbar.barTintColor = .systemBlue
        let newTaskButton = UIBarButtonItem(image: UIImage(systemName: "plus.fill"), style: .plain, target: self, action: #selector(newTaskButtonTapped))
        newTaskButton.title = "새로운 할 일"
        newTaskButton.tintColor = .systemBlue
        let addListButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarItems = [newTaskButton, flexibleSpace, addListButton]
    }
    
    @objc func moreButtonTapped() {
        print("moreButtonTapped")
    }
    
    @objc func newTaskButtonTapped() {
        let vc = AddViewController()
//        navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true)
    }
    
    @objc func addListButtonTapped() {
        
    }
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let width = (UIScreen.main.bounds.width - (16 * 2 + 16)) / 2
        layout.itemSize = CGSize(width: width, height: UIScreen.main.bounds.height * 0.1)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .vertical
        
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
