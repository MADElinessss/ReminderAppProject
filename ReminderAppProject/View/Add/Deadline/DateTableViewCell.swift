//
//  DateTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import SnapKit
import UIKit

class DateTableViewCell: UITableViewCell {
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let toggleSwitch = UISwitch()
    let calendar = UICalendarView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .buttonGray
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(toggleSwitch)
        contentView.addSubview(calendar)
    }
    
    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.centerY.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalTo(contentView)
        }
        toggleSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.centerY.equalTo(contentView)
        }
        calendar.snp.makeConstraints { make in
            make.top.equalTo(toggleSwitch.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        iconImageView.image = UIImage(systemName: "calendar")
        iconImageView.tintColor = .white
        iconImageView.backgroundColor = .systemRed
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 4
        
        titleLabel.text = "날짜"
        titleLabel.textColor = .white
        
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchChanged), for: .valueChanged)
        
        calendar.isHidden = !toggleSwitch.isOn
    }
    
    @objc func toggleSwitchChanged(_ sender: UISwitch) {
        calendar.isHidden = !sender.isOn
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        print("Selected date is \(dateFormatter.string(from: datePicker.date))")
    }
}

#Preview {
    DateTableViewCell()
}
