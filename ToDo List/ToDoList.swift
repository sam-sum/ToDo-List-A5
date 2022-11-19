//
//  MAPD714 F2022
//  Assignment 5
//  ToDo List App
//  Part 2 - Code the app functions
//  Group 9
//  Member: Suen, Chun Fung (Alan) 301277969
//          Sum, Chi Hung (Samuel) 300858503
//          Wong, Po Lam (Lizolet) 301258847
//
//  ToDoList.swift
//  ToDo List
//  Date: Nov 27, 2022
//

import Foundation
import UIKit

struct ToDoItem: Codable {
    var id: String
    var title: String
    var desc: String
    var dueDate: Date?
    var isCompleted: Bool
}

class ToDoList {
    static let sharedToDoList = ToDoList()
    // The do to list items are saved in a dictionary using the id as the key
    private var toDoItems: [String: ToDoItem]
    
    init() {
        toDoItems = [:]
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "toDoItems") as?  Data,
           let storedToDoItems = try? JSONDecoder().decode([String: ToDoItem].self, from: data) {
            toDoItems = storedToDoItems
        }
    }
    
    func addBlankItem(_ title: String = "New Task") {
        // create a new item with an unique id
        let newItem = ToDoItem(
            id: UUID().uuidString,
            title: title,
            desc: "",
            dueDate: nil,
            isCompleted: false
        )
        toDoItems[newItem.id] = newItem
        saveToDoList()
    }
    
    func removeItem(inItem: ToDoItem) {
        toDoItems[inItem.id] = nil
        saveToDoList()
    }

    func replaceItem(inItem: ToDoItem) {
        if !inItem.id.isEmpty {
            if toDoItems[inItem.id] != nil {
                toDoItems[inItem.id] = inItem
                saveToDoList()
            }
        }
    }
    
    func count() -> Int {
        return toDoItems.count
    }
    
    func getAllItems() -> [ToDoItem] {
        return Array(toDoItems.values)
    }
    
    private func saveToDoList() {
        if let encoded = try? JSONEncoder().encode(toDoItems) {
            let defaults = UserDefaults.standard
            defaults.setValue(encoded, forKey: "toDoItems")
            defaults.synchronize()
        }
    }
}
