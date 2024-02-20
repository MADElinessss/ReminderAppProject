//
//  DetailViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import RealmSwift
import SnapKit
import UIKit


class DetailViewController: BaseViewController {

    let titleLabel = UILabel()
    let tableView = UITableView()
    var taskList: Results<ReminderTable>!
    var taskID: ObjectId
    var task: ReminderTable?
    let repository = RealmRepository()
    
    init(taskID: ObjectId) {
        self.taskID = taskID
        super.init(nibName: nil, bundle: nil)
        self.task = repository.fetchItem(by: taskID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sections: [DetailSectionType] = [.memo, .deadline, .repetition, .priority]
    let realm = try! Realm()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        task = repository.fetchItem(by: taskID)
        
        taskList = realm.objects(ReminderTable.self)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
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
        
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.register(DetailDateTableViewCell.self, forCellReuseIdentifier: "DetailDateTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tag")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "priority")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "image")
        
        tableView.backgroundColor = .buttonGray
        
    }
    
    func configureNavigationBar() {
        
        let leftItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = leftItem
        leftItem.tintColor = .systemBlue
        
        let rightItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = rightItem
        rightItem.tintColor = .systemBlue
        
        navigationItem.title = "세부사항"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func saveButtonTapped() {
        // TODO: 수정사항 저장
        
        self.dismiss(animated: true)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        if indexPath.section == 0 || indexPath.section == 1 {
            return 100
        } else if indexPath.section == 4 {
            return 200
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            
            if let task = task {
                cell.titleTextField.text = task.title
                cell.memoTextField.text = task.memo
            }
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDateTableViewCell", for: indexPath) as! DetailDateTableViewCell
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tag", for: indexPath)
            
            if let task = task {
                cell.textLabel?.text = "# " + task.tag
                cell.textLabel?.textColor = UIColor(named: "tagColor")
            } else {
                cell.textLabel?.text = "태그"
                cell.textLabel?.textColor = .gray
            }
            
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .listGray
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
            return cell
            
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "priority", for: indexPath)
            
            if let task = task {
                cell.textLabel?.text = task.priority
                cell.textLabel?.textColor = .white
                cell.textLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            } else {
                cell.textLabel?.text = "우선순위"
                cell.textLabel?.textColor = .gray
            }
            
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .listGray
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath)
            
            if let task = task {
                cell.imageView?.image = loadImageFromDocument(fileName: "\(task.id)")
                
            } else {
                cell.imageView?.image = UIImage(systemName: "photo.fill")
            }
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .listGray
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
            
            return cell
        }
    }
}
