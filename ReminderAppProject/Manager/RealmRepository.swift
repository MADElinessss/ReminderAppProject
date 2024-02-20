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
            }
        } catch {
            print(error)
        }
    }
    
    // READ
    func fetchItem(_ category: String) -> Results<ReminderTable> {
        return realm.objects(ReminderTable.self)
    }
    
    func fetchItem(by id: ObjectId) -> ReminderTable? {
        return realm.object(ofType: ReminderTable.self, forPrimaryKey: id)
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
    func updateIsDone(id: ObjectId, value: Bool) {
        do {
            try realm.write {
                realm.create(ReminderTable.self, value: ["id": id, "isDone": value], update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    // DELETE
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
