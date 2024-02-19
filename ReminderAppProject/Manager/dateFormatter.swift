//
//  dateFormatter.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import Foundation
import UIKit

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter
}()
