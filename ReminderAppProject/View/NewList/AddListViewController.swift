//
//  AddListViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/20/24.
//

import SnapKit
import RealmSwift
import UIKit

class AddListViewController: BaseViewController {

    let tableView = UITableView()
    let realm = try! Realm()
    var list: Results<Folder>!
    
    var titleText: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .buttonGray
        
        list = realm.objects(Folder.self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextFieldUpdate(notification:)), name: NotificationNames.listTitleUpdated, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureHeirarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectedListTableViewCell.self, forCellReuseIdentifier: "SelectedListTableViewCell")
        tableView.register(ListsTableViewCell.self, forCellReuseIdentifier: "ListsTableViewCell")
        tableView.backgroundColor = .buttonGray
        
        let leftItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = leftItem
        leftItem.tintColor = .systemBlue
        
        let rightItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = rightItem
        rightItem.tintColor = .systemBlue
        
        navigationItem.title = "새로운 목록"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func handleTextFieldUpdate(notification: Notification) {
        if let userInfo = notification.userInfo,
           let listTitle = userInfo["listTitle"] as? String {
            self.titleText = listTitle
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func saveButtonTapped() {
        // TODO: 수정사항 저장
        
        guard !titleText.isEmpty else {
            print("Folder name is empty.")
            return
        }
        
        let newFolder = Folder()
        newFolder.folderName = titleText
        newFolder.registrationDate = Date()
        
        do {
            try realm.write {
                realm.add(newFolder)
            }
            dismiss(animated: true)
        } catch let error {
            print("Error saving folder: \(error.localizedDescription)")
        }
//
//        tableView.reloadData()
//        self.dismiss(animated: true)
    }
}

extension AddListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  "
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedListTableViewCell", for: indexPath) as! SelectedListTableViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListsTableViewCell", for: indexPath) as! ListsTableViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

//#Preview {
//    AddListViewController()
//}
