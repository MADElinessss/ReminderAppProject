//
//  RealmModel.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/15/24.
//

import Foundation
import RealmSwift

// 💐 MARK: Realm 테이블 여러개 관리
class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var folderName: String
    @Persisted var registrationDate: Date
    @Persisted var folderColor: String
    // 💐 테이블을 추가해보자!
    @Persisted var accountBookList: List<ReminderTable>
    
    convenience init(folderName: String, registrationDate: Date) {
        self.init()
        self.folderName = folderName
        self.registrationDate = registrationDate
    }
}

class ReminderTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var deadline: Date?
    @Persisted var tag: String
    @Persisted var priority: String
    @Persisted var isDone: Bool
    
    convenience init(title: String, memo: String, deadline: Date?, tag: String, priority: String, isDone: Bool) {
        self.init()
        self.title = title
        self.content = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.isDone = isDone
    }
}
