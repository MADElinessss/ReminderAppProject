//
//  DetailSectionType.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import Foundation

enum DetailSectionType {
    case memo
    case deadline
    case repetition
    case priority
    
    var cellIdentifier: String {
        switch self {
        case .memo:
            "memo"
        case .deadline:
            "deadline"
        case .repetition:
            "repetition"
        case .priority:
            "priority"
        }
    }
}

  
