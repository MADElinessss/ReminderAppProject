//
//  AddDeadlineViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import SnapKit
import UIKit

class AddDeadlineViewController: BaseViewController {

    var deadlineSender: ((Date) -> Void)?
    var date: Date?
    let datePicker = UIDatePicker()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deadlineSender?(datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "마감일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    override func configureHeirarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        if let date = date {
            datePicker.date = date
        } else {
            datePicker.date = Date()
        }
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = .systemBlue
        datePicker.backgroundColor = .buttonGray
        datePicker.timeZone = TimeZone(identifier: "Asia/Seoul")
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        print("Selected date is \(dateFormatter.string(from: datePicker.date))")
    }
}
