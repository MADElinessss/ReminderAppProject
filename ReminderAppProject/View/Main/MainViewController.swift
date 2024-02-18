//
//  MainViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import RealmSwift
import SnapKit
import UIKit


class MainViewController: BaseViewController {
    
    // 전체 할 일
    var taskList: Results<ReminderTable>!
    // 오늘 할 일
    var todayList: [ReminderTable] = []
    // 예정된 할 일
    var scheduledCount: Int = 0
    let repository = RealmRepository()
    
    let moreButton = UIButton()
    let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = false
        
        fetchDataAndUpdateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // AddViewController에서 추가 버튼 누를 때 실행
        NotificationCenter.default.addObserver(self, selector: #selector(taskAddedNotificationReceived), name: NSNotification.Name(rawValue: "TaskAdded"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func taskAddedNotificationReceived() {
        // count reload
        fetchDataAndUpdateUI()
    }
    
    private func fetchDataAndUpdateUI() {
        
        // READ
        taskList = repository.fetchItem("deadline")
        let allTasks = repository.fetchItem("deadline")
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        todayList = Array(allTasks.filter { calendar.startOfDay(for: $0.deadline) == today })
        scheduledCount = allTasks.filter { calendar.startOfDay(for: $0.deadline) >= today }.count
        collectionView.reloadData()
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreButtonTapped))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.backgroundColor = .black
        
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = .gray
        
        self.navigationController?.toolbar.barTintColor = .systemBlue
        let newTaskButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(newTaskButtonTapped))
        
        let newTaskLabel = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(newTaskButtonTapped))
        
        newTaskButton.tintColor = .systemBlue
        
        let addListButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.toolbarItems = [newTaskButton, newTaskLabel, flexibleSpace, addListButton]
    }
    
    @objc func moreButtonTapped() {
        
    }
    
    @objc func newTaskButtonTapped() {
        let addVC = AddViewController()
        let navController = UINavigationController(rootViewController: addVC)
        self.present(navController, animated: true, completion: nil)
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
        return CollectionViewItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell,
              let item = CollectionViewItem(rawValue: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 15
        cell.titleLabel.text = item.title
        cell.iconImageView.image = UIImage(systemName: item.iconName)
        cell.iconImageView.backgroundColor = item.backgroundColor
        
        // 오늘과 전체 태스크 카운트 설정
        switch item {
        case .today:
            cell.taskCount.text = "\(todayList.count)"
        case .all:
            cell.taskCount.text = "\(taskList.count)"
        case .scheduled:
            cell.taskCount.text = "\(scheduledCount)"
        default:
            cell.taskCount.text = ""
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = CollectionViewItem(rawValue: indexPath.item) else { return }
        
        switch item {
        case .today:
            let vc = TodayTasksViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .all:
            let vc = AllTasksListViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .scheduled:
            let vc = SchduledTasksViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

#Preview {
    MainViewController()
}
