//
//  SectionType.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import Foundation

enum SectionType {
    case titleMemo
    case deadline
    case tag
    case priority
    case imageAdd
       
    var cellIdentifier: String {
        switch self {
        case .titleMemo:
            "AddTextFieldTableViewCell"
        case .deadline:
            "deadlineCell"
        case .tag:
            "tagCell"
        case .priority:
            "priorityCell"
        case .imageAdd:
            "imageCell"
        }
    }
}

  
