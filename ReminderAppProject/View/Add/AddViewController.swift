//
//  AddViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import RealmSwift
import SnapKit
import UIKit

let list = ["마감일", "태그", "우선 순위", "이미지 추가"]

class AddViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var sections: [SectionType] = [.titleMemo, .deadline, .tag, .priority, .imageAdd]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    var titleText: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    var memoText: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    var date: Date? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var deadlineLabel : String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tagLabel : String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    var priority: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        
        let leftItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = leftItem
        leftItem.tintColor = .systemBlue
        
        let rightItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = rightItem
        rightItem.tintColor = .systemBlue
        rightItem.isEnabled = false
        
        
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func saveButtonTapped() {
        
        let realm = try! Realm()
        
        // print(realm.configuration.fileURL)
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        let data = ReminderTable(title: titleText, memo: memoText, deadline: date ?? Date(), tag: tagLabel, priority: priority)
        
        try! realm.write {
            realm.add(data)
            self.dismiss(animated: true)
        }
    }
    
    override func configureView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AddTextFieldTableViewCell.self, forCellReuseIdentifier: "AddTextFieldTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "deadlineCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tagCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "priorityCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "imageCell")
        
        tableView.backgroundColor = .buttonGray
        
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height * 0.2
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath)
        
        switch section {
        case .titleMemo:
            if let textFieldCell = cell as? AddTextFieldTableViewCell {
                textFieldCell.layer.cornerRadius = 10
                textFieldCell.backgroundColor = .listGray
                textFieldCell.selectionStyle = .none
                
                textFieldCell.titleSender = { value in
                    self.titleText = value
                }
                textFieldCell.memoSender = { value in
                    self.memoText = value
                }
                
                textFieldCell.textFieldDidChangeHandler = { [weak self] text in
                    self?.navigationItem.rightBarButtonItem?.isEnabled = !(text?.isEmpty ?? true)
                }
                return textFieldCell
            } else {
                return cell
            }
        case .deadline:
            cell.layer.cornerRadius = 10
            if let date = date {
                cell.textLabel?.text = "\(date)"
            } else {
                cell.textLabel?.text = list[indexPath.section - 1]
            }
            cell.textLabel?.textColor = .white
            
            cell.accessoryType = .disclosureIndicator
            
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
            
        case .tag:
            
            cell.layer.cornerRadius = 10
            
            if tagLabel != "" {
                cell.textLabel?.text = tagLabel
            } else {
                cell.textLabel?.text = list[indexPath.section - 1]
            }
            
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
            
        case .priority:
            cell.layer.cornerRadius = 10
            
            if priority != "" {
                cell.textLabel?.text = priority
            } else {
                cell.textLabel?.text = list[indexPath.section - 1]
            }
            
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
            
        case .imageAdd:
            cell.layer.cornerRadius = 10
            cell.textLabel?.text = list[indexPath.section - 1]
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            
            let vc = AddDeadlineViewController()
            
            vc.deadlineSender = { newValue in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                self.deadlineLabel = dateFormatter.string(from: newValue)
                self.date = newValue
                
                vc.date = newValue
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 2 {
            
            let vc = AddTagViewController()
            
            vc.tagSender = { newValue in
                self.tagLabel = newValue
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 3 {
            let vc = AddPriorityViewController()
            
            NotificationCenter.default.addObserver(self, selector: #selector(categoryReceivedNotificationObserved), name: NSNotification.Name("Priority"), object: nil)
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func categoryReceivedNotificationObserved(notification: NSNotification) {
        
        if let value = notification.userInfo?["priority"] as? Int {
            if value == 0 {
                priority = "낮음"
            } else if value == 1 {
                priority = "보통"
            } else {
                priority = "높음"
            }
        }
    }
}

#Preview {
    AddViewController()
}
