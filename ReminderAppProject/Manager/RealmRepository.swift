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
    
    // UPDATE
    func updateItem(id: ObjectId, money: Int, category: String) {
        do {
            try realm.write {
                realm.create(ReminderTable.self,
                             value: ["id": id, "money": money, "favorite": true],
                             update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
