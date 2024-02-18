//
//  SchduledTasksViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import Foundation
import RealmSwift
import SnapKit
import UIKit

enum SortCriterion {
    case deadline, title, priority
}

class SchduledTasksViewController: BaseViewController {

    // MARK: 예정된 할 일
    var taskList: Results<ReminderTable>!
    var scheduledTasks: [ReminderTable] = []
    let repository = RealmRepository()
    
    let titleLabel = UILabel()
    let tableView = UITableView()
    let realm = try! Realm()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchScheduledTasks()
        tableView.reloadData()
    }
    
    func fetchScheduledTasks() {
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        taskList = realm.objects(ReminderTable.self).filter("deadline >= %@", today)
        
        scheduledTasks = Array(taskList)
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
        let deadlineSort = UIAction(title: "마감일 순으로 보기", image: nil) { [weak self] _ in
            self?.sortTasks(by: .deadline)
        }
        
        let titleSort = UIAction(title: "제목 순으로 보기", image: nil) { [weak self] _ in
            self?.sortTasks(by: .title)
        }
        
        let prioritySort = UIAction(title: "우선순위 높음만 보기", image: nil) { [weak self] _ in
            self?.sortTasks(by: .priority)
        }
        
        let pullDownButton = UIMenu(title: "정렬 기준", children: [deadlineSort, titleSort, prioritySort])
        navigationItem.rightBarButtonItem?.menu = pullDownButton
        
        let item = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), primaryAction: nil, menu: pullDownButton)
        
        navigationItem.rightBarButtonItem = item
        
        titleLabel.text = "예정"
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = .systemBlue
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SchduledTasksTableViewCell.self, forCellReuseIdentifier: "SchduledTasksTableViewCell")
        tableView.backgroundColor = .buttonGray
    }
    
    private func sortTasks(by criterion: SortCriterion) {
        
        let today = Calendar.current.startOfDay(for: Date())
        
        switch criterion {
        case .deadline:
            taskList = self.realm.objects(ReminderTable.self).filter("deadline >= %@", today).sorted(byKeyPath: "deadline", ascending: true)
        case .title:
            taskList = self.realm.objects(ReminderTable.self).filter("deadline >= %@", today).sorted(byKeyPath: "title", ascending: true)
        case .priority:
            taskList = self.realm.objects(ReminderTable.self).filter("deadline >= %@", today).sorted(byKeyPath: "priority", ascending: false)
        }
        scheduledTasks = Array(taskList)
        tableView.reloadData()
    }

}

extension SchduledTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduledTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchduledTasksTableViewCell", for: indexPath) as! SchduledTasksTableViewCell
        let task = scheduledTasks[indexPath.row]
        cell.taskTitle.text = task.title
        cell.taskMemo.text = task.memo
        
        cell.checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let detail = UIContextualAction(style: .normal, title: "세부사항") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            success(true)
        }
        
        detail.backgroundColor = .listGray
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.repository.deleteItem(self.taskList[indexPath.row])
            success(true)
            self.fetchScheduledTasks()
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions:[delete, detail])
    }
}
