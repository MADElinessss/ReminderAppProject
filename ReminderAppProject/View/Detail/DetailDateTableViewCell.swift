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

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.height.equalTo(0.5)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
            make.bottom.equalTo(contentView)
        }
        
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        
        separatorLine.backgroundColor = .darkGray
        
        dateLabel.text = "날짜"
        dateLabel.textColor = .white
        timeLabel.text = "시간"
        timeLabel.textColor = .white
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerChanged(picker:)), for: .valueChanged)
    }

    @objc func datePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
//        dateLabel.text = dateFormatter.string(from: picker.date)
    }
    
    @objc func timePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
//        dateLabel.text = dateFormatter.string(from: picker.date)
    }

}

#Preview {
    DetailDateTableViewCell()
}
