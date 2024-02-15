//
//  DeadlineViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import SnapKit
import UIKit

class DetailViewController: BaseViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureConstraints() {
        view.addSubview(tableView)
    }
    
    override func configureHeirarchy() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DateTableViewCell.self, forCellReuseIdentifier: "DateTableViewCell")
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
        
        
        
        
        return cell
    }
    
    
}
