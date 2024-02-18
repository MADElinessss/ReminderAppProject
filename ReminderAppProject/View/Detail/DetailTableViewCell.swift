//
//  DetailTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import SnapKit
import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var textFieldDidChangeHandler: ((String?) -> Void)?

    var titleSender: ((String) -> Void)?
    var memoSender: ((String) -> Void)?
    
    let titleTextField = UITextField()
    let memoTextField = UITextField()
    let separatorLine = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(memoTextField)
        contentView.addSubview(separatorLine)
        
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.height.equalTo(0.5)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.15)
            make.bottom.equalTo(contentView)
        }
        
        separatorLine.backgroundColor = .darkGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        titleTextField.backgroundColor = .listGray
        titleTextField.textColor = .white
        titleTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor])
        titleTextField.addTarget(self, action: #selector(titleTextFieldEndEditing), for: .editingDidEnd)
        titleTextField.addTarget(self, action: #selector(titleTextDidChanged), for: .editingChanged)
        
        memoTextField.backgroundColor = .listGray
        memoTextField.textColor = .white
        memoTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor])
        memoTextField.addTarget(self, action: #selector(memoTextFieldEndEditing), for: .editingDidEnd)
    }
    
    @objc func titleTextDidChanged() {
        textFieldDidChangeHandler?(titleTextField.text)
    }
    @objc func titleTextFieldEndEditing() {
        titleSender?(titleTextField.text ?? "")
    }
    
    @objc func memoTextFieldEndEditing() {
        memoSender?(memoTextField.text ?? "")
    }

}
