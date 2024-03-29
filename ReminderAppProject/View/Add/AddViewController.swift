//
//  AddViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import RealmSwift
import SnapKit
import UIKit

class AddViewController: BaseViewController {
    
    let tableView = UITableView()
    let repository = RealmRepository()
    var selectedImage = UIImageView()
    
    var sections: [SectionType] = [.titleMemo, .deadline, .tag, .priority, .imageAdd]
    
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
    
    var cellImage: UIImage? = UIImage(systemName: "photo.fill") {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        let data = ReminderTable(title: titleText, memo: memoText, deadline: date, tag: tagLabel, priority: priority, isDone: false)
        
        repository.createItem(data)
        
        if let image = cellImage {
            if cellImage != UIImage(systemName: "photo.fill") {
                saveImageToDocument(image: image, fileName: "\(data.id)")
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TaskAdded"), object: nil)
        
        self.dismiss(animated: true)
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
        } else if indexPath.section == 4 {
            return 200
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
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
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy년 MM월 dd일 hh:mm"
                let dateString = dateFormatter.string(from: date)
                cell.textLabel?.text = dateString
            } else {
                cell.textLabel?.text = AddViewTitleList[indexPath.section - 1]
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
                cell.textLabel?.text = AddViewTitleList[indexPath.section - 1]
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
                cell.textLabel?.text = AddViewTitleList[indexPath.section - 1]
            }
            
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            return cell
            
        case .imageAdd:
            cell.layer.cornerRadius = 10
            cell.textLabel?.text = AddViewTitleList[indexPath.section - 1]
            cell.textLabel?.textColor = .white
            
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .listGray
            cell.selectionStyle = .default
            
            if let cellImage = cellImage {
                cell.imageView?.image = cellImage
                cell.imageView?.clipsToBounds = true
                cell.imageView?.contentMode = .scaleAspectFit
                if cellImage != UIImage(systemName: "photo.fill") {
                    cell.textLabel?.isHidden = true
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            
            let vc = AddDeadlineViewController()
            
            vc.deadlineSender = { newValue in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy년 MM월 dd일"
                self.deadlineLabel = dateFormatter.string(from: newValue)
                print(self.deadlineLabel)
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
            // MARK: 앨범에서 이미지 선택
            let vc = UIImagePickerController()
            
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
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

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            print("Choose")
            cellImage = selectedImage
            tableView.reloadData()
        }
        dismiss(animated: true)
    }
}

#Preview {
    AddViewController()
}
