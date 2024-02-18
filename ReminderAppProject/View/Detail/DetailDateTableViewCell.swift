//
//  DetailDateTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import SnapKit
import UIKit

class DetailDateTableViewCell: UITableViewCell {

    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let separatorLine = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(separatorLine)
        contentView.addSubview(datePicker)
        contentView.addSubview(timePicker)
        
//        dateLabel.snp.makeConstraints { make in
//            make.leading.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
//        }
        
        
        dateLabel.text = "날짜"
        timeLabel.text = "시간"
        
        // datePicker 설정
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerChanged(picker:)), for: .valueChanged)
        
    }

    @objc func datePickerChanged(picker: UIDatePicker) {
        // 날짜와 시간 레이블 업데이트
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateLabel.text = dateFormatter.string(from: picker.date)
    }
    
    @objc func timePickerChanged(picker: UIDatePicker) {
        // 날짜와 시간 레이블 업데이트
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateLabel.text = dateFormatter.string(from: picker.date)
    }

}
