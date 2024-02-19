//
//  TagViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import SnapKit
import UIKit

class AddTagViewController: BaseViewController {

    var tagSender: ((String) -> Void)?
    let tagTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagTextField.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tagSender?(tagTextField.text!)
        // 💡 TODO: "capture list" 키워드 공부하기
    }
    
    override func configureHeirarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureConstraints() {
        tagTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        
        tagTextField.attributedPlaceholder = NSAttributedString(
            string: "태그를 입력해주세요. 🏷️",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        tagTextField.clipsToBounds = true
        tagTextField.layer.cornerRadius = 5
        tagTextField.backgroundColor = .listGray
        tagTextField.textColor = .white
        tagTextField.borderStyle = .none
    }
}
