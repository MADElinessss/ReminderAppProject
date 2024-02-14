//
//  AddViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import SnapKit
import UIKit

class AddViewController: UIViewController {

    let tableView = UITableView()
    
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
        dismiss(animated: true, completion: nil)
    }

    @objc func saveButtonTapped() {
        // TODO: 값 전달
    }
    
    func configureView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell0")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
    }

}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath)
            cell.backgroundColor = .white
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            
            cell.textLabel?.text = "마감일"
            cell.textLabel?.textColor = .white
            
            cell.backgroundColor = .gray
            
            return cell
        }
    }
}

#Preview {
    AddViewController()
}
