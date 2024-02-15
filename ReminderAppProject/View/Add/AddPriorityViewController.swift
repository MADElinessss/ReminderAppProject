//
//  AddPriorityViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import UIKit

class AddPriorityViewController: BaseViewController {
    
    var segmentIndex: Int = 0
    
    let segmentControl = UISegmentedControl(items: ["낮음", "보통", "높음"])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .buttonGray

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("Priority"), object: nil, userInfo: ["priority": segmentIndex])
    }
    
    override func configureHeirarchy() {
        view.addSubview(segmentControl)
    }
    
    override func configureConstraints() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        segmentControl.backgroundColor = .listGray
        segmentControl.tintColor = .white
        segmentControl.selectedSegmentIndex = segmentIndex
        segmentControl.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
    }
    
    @objc func segmentControlChanged() {
        segmentIndex = segmentControl.selectedSegmentIndex
    }
}
