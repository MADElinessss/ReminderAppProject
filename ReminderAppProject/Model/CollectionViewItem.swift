//
//  CollectionViewItem.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import Foundation
import UIKit

enum CollectionViewItem: Int, CaseIterable {
    case today
    case scheduled
    case all
    case flagged
    case completed
    
    var title: String {
        switch self {
        case .today: return "오늘"
        case .scheduled: return "예정"
        case .all: return "전체"
        case .flagged: return "깃발 표시"
        case .completed: return "완료됨"
        }
    }
    
    var iconName: String {
        switch self {
        case .today: return "calendar.badge.checkmark"
        case .scheduled: return "calendar"
        case .all: return "tray.fill"
        case .flagged: return "flag.fill"
        case .completed: return "checkmark"
        }
    }
    var backgroundColor: UIColor {
        switch self {
        case .today: return .systemBlue
        case .scheduled: return .systemRed
        case .all, .completed: return .gray
        case .flagged: return .orange
        }
    }
}
