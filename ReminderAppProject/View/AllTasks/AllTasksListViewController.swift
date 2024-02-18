//
//  AllTasksListViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import RealmSwift
import SnapKit
import UIKit

class AllTasksListViewController: BaseViewController {
    
    var taskList: Results<ReminderTable>!

    let titleLabel = UILabel()
    let tableView = UITableView()
    
    let realm = try! Realm()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        taskList = realm.objects(ReminderTable.self)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHeirarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }

    override func configureView() {

        // 마감일 순, 제목 순, 우선순위 높음만 보기
        let deadlineSort = UIAction(title: "마감일 순으로 보기") { _ in
            
            self.taskList = self.realm.objects(ReminderTable.self).sorted(byKeyPath: "deadline", ascending: true)
            self.tableView.reloadData()
        }
        
        let titleSort = UIAction(title: "제목 순으로 보기") { _ in
            
            self.taskList = self.realm.objects(ReminderTable.self).sorted(byKeyPath: "title", ascending: true)
            self.tableView.reloadData()
        }
        
        let prioritySort = UIAction(title: "우선순위 높음만 보기") { _ in
            self.taskList = self.realm.objects(ReminderTable.self).where {
                $0.priority == "2"
            }.sorted(byKeyPath: "deadline", ascending: true)
            self.tableView.reloadData()
        }
        
        let pullDownButton = UIMenu(title: "정렬 기준", children: [deadlineSort, titleSort, prioritySort])
        navigationItem.rightBarButtonItem?.menu = pullDownButton
        
        let item = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), primaryAction: nil, menu: pullDownButton)
        
        navigationItem.rightBarButtonItem = item
        
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = .gray
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllTasksTableViewCell.self, forCellReuseIdentifier: "AllTasksTableViewCell")
        tableView.backgroundColor = .buttonGray
    }
}

extension AllTasksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTasksTableViewCell", for: indexPath) as! AllTasksTableViewCell
        
        cell.taskTitle.text = taskList[indexPath.row].title
        cell.taskMemo.text = taskList[indexPath.row].memo
        
        cell.checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let detail = UIContextualAction(style: .normal, title: "세부사항") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            success(true)
        }
        
        detail.backgroundColor = .listGray
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            try! self.realm.write {
                self.realm.delete(self.taskList[indexPath.row])
            }
            success(true)
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions:[delete, detail])
    }
}
