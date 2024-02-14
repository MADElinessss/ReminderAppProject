//
//  DueDateViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/14/24.
//

import SnapKit
import UIKit

class DueDateViewController: ViewController {
    
    let dateSwitch = UISwitch()
    let timeSwitch = UISwitch()
    
    let datePicker = UIDatePicker()
    let calendar = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .listGray
    
        navigationItem.title = "마감일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        configureHeirarchy()
        configureConstraints()
        configureView()
    }
    
    func configureHeirarchy() {
        view.addSubview(dateSwitch)
        view.addSubview(timeSwitch)
        view.addSubview(datePicker)
        view.addSubview(calendar)
    }
    
    func configureConstraints() {
        dateSwitch.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        
        timeSwitch.snp.makeConstraints { make in
            make.top.equalTo(dateSwitch.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
        }
    }
    
    func configureView() {
        
        calendar.isHidden = !dateSwitch.isOn
        datePicker.isHidden = !timeSwitch.isOn
        
        calendar.isHidden = true
        datePicker.isHidden = true
        
        
        calendar.tintColor = .white
        calendar.backgroundColor = .lightGray
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.backgroundColor = .gray
        datePicker.timeZone = TimeZone(identifier: "Asia/Seoul")
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
//        dateSwitch.title = "날짜"
        dateSwitch.addTarget(self, action: #selector(dateSwitchChanged(_:)), for: .valueChanged)
        
//        timeSwitch.title = "시간"
        timeSwitch.addTarget(self, action: #selector(timeSwitchChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func dateSwitchChanged(_ sender: UISwitch) {
        calendar.isHidden = !sender.isOn
    }
    
    @objc func timeSwitchChanged(_ sender: UISwitch) {
        datePicker.isHidden = !sender.isOn
    }
    
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        print("Selected date is \(dateFormatter.string(from: datePicker.date))")
    }
}

#Preview {
    DueDateViewController()
}
