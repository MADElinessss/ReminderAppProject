//
//  RealmModel.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import Foundation
import RealmSwift

class ReminderTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var title: String
    @Persisted var memo: String
    @Persisted var deadline: Date?
    @Persisted var tag: String
    @Persisted var priority: String
    @Persisted var isDone: Bool
    
    convenience init(title: String, memo: String, deadline: Date?, tag: String, priority: String, isDone: Bool) {
        self.init()
        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.isDone = isDone
    }
}
