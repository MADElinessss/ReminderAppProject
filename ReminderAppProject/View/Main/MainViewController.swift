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
    
    // 폴더 리스트
    var folderList: Results<Folder>!
    
    let repository = RealmRepository()
    
    let moreButton = UIButton()
    let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = false
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(folderAddedNotificationReceived),
            name: NotificationNames.folderAdded,
            object: nil
        )

        fetchDataAndUpdateUI()
    }

    @objc func folderAddedNotificationReceived(_ notification: Notification) {
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
        
        todayList = repository.fetchTodayTasks()
        scheduledCount = repository.countScheduledTasks()
        
        
        folderList = repository.fetchFolders()
        
        collectionView.reloadData()
    }
    
    override func configureHeirarchy() {
        view.addSubview(moreButton)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
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
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "calendar.circle"), style: .plain, target: self, action: #selector(calendarButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreButtonTapped))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.backgroundColor = .black
        
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = .gray
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
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
    
    @objc func calendarButtonTapped() {
        // TODO: 캘린더 뷰 띄우기
        let addVC = CalendarViewController()
        let navController = UINavigationController(rootViewController: addVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func newTaskButtonTapped() {
        let addVC = AddViewController()
        let navController = UINavigationController(rootViewController: addVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func addListButtonTapped() {
        let addVC = AddListViewController()
        let navController = UINavigationController(rootViewController: addVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func handleListTitleUpdate(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let listTitle = userInfo["listTitle"] as? String else { return }
    
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell {
            cell.titleLabel.text = listTitle
            
            folderList[indexPath.row].folderName = listTitle
            tableView.reloadData()
        }
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let folder = folderList[indexPath.row]
        cell.configureWith(folder: folder)
        return cell
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
        case .completed:
            cell.taskCount.text = "\(repository.countDoneTasks())"
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
