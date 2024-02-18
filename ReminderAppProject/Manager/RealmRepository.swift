//
//  RealmRepository.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/18/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    
    let realm = try! Realm()
    
    // CRUD
    // CREATE
    func createItem(_ item: ReminderTable) {
        do {
            try realm.write {
                realm.add(item)
                print("CREATED")
            }
        } catch {
            print(error)
        }
    }
    
    // READ
    func fetchItem(_ category: String) -> Results<ReminderTable> {
        return realm.objects(ReminderTable.self)
    }
    
    func fetchTodayTasks() -> [ReminderTable] {
        let allTasks = fetchItem("deadline")
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return Array(allTasks.filter {
            guard let deadline = $0.deadline else { return false }
            return calendar.startOfDay(for: deadline) == today
        })
    }
    
    func countScheduledTasks() -> Int {
        let today = Calendar.current.startOfDay(for: Date())
        return realm.objects(ReminderTable.self).filter("deadline >= %@", today).count
    }
    
    // UPDATE
//    func updateItem(id: ObjectId, money: Int, category: String) {
//        do {
//            try realm.write {
//                realm.create(ReminderTable.self,
//                             value: ["id": id, "money": money, "favorite": true],
//                             update: .modified)
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    func deleteItem(_ item: ReminderTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
