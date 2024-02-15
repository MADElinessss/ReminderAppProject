//
//  AddViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import SnapKit
import UIKit

let list = ["마감일", "태그", "우선 순위", "이미지 추가"]

class AddViewController: UIViewController {
    
    let tableView = UITableView()
    
    var deadlineLabel : String? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tagLabel : String? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .buttonGray
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
        
        
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func saveButtonTapped() {
        // TODO: 값 전달
        
        dismiss(animated: true)
    }
    
    func configureView() {
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
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddTextFieldTableViewCell", for: indexPath) as! AddTextFieldTableViewCell
            
            cell.layer.cornerRadius = 10
            cell.backgroundColor = .listGray
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "deadlineCell", for: indexPath)
            
            cell.layer.cornerRadius = 10
            if let deadline = deadlineLabel {
                cell.textLabel?.text = deadline
            } else {
                cell.textLabel?.text = list[indexPath.section - 1]
            }
            
            cell.textLabel?.textColor = .white
            
            cell.accessoryType = .disclosureIndicator
            
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)
            
            cell.layer.cornerRadius = 10
            if let tag = tagLabel {
                cell.textLabel?.text = tag
            } else {
                cell.textLabel?.text = list[indexPath.section - 1]
            }
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
            
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "priorityCell", for: indexPath)
            
            cell.layer.cornerRadius = 10
            cell.textLabel?.text = list[indexPath.section - 1]
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
            
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
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            
            
        } else if indexPath.section == 1 {
            
            let vc = AddDeadlineViewController()
            
            vc.deadlineSender = { newValue in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                self.deadlineLabel = dateFormatter.string(from: newValue)
                vc.date = newValue
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 2 {
            
            let vc = TagViewController()
            
            vc.tagSender = { newValue in
                self.tagLabel = newValue
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 3 {
            
            
            
        } else {
            
        }
    }
}

#Preview {
    AddViewController()
}
