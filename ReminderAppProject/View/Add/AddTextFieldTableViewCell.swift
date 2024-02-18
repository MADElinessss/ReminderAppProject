//
//  AddTextFieldTableViewCell.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import SnapKit
import UIKit

class AddTextFieldTableViewCell: UITableViewCell {

    var textFieldDidChangeHandler: ((String?) -> Void)?

    var titleSender: ((String) -> Void)?
    var memoSender: ((String) -> Void)?
    
    let titleTextField = UITextField()
    let memoTextField = UITextField()
    
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
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.15)
            make.bottom.equalTo(contentView)
        }
        
        titleTextField.backgroundColor = .listGray
        titleTextField.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor])
        titleTextField.addTarget(self, action: #selector(titleTextFieldEndEditing), for: .editingDidEnd)
        titleTextField.addTarget(self, action: #selector(titleTextDidChanged), for: .editingChanged)
        
        memoTextField.backgroundColor = .listGray
        memoTextField.attributedPlaceholder = NSAttributedString(string: "메모", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor])
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

#Preview {
    AddTextFieldTableViewCell()
}
