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
    var seq: Int        // sequence number in the multiple of 10
    var name: String
    var notes: String
    var isCompleted: Bool
    var hasDueDate: Bool
    var dueDate: Date?
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
            seq: toDoItems.count * 10,
            name: title,
            notes: "",
            isCompleted: false,
            hasDueDate: false,
            dueDate: nil
        )
        toDoItems[newItem.id] = newItem
        saveToDoList()
    }
    
    func removeItem(_ inItem: ToDoItem) {
        toDoItems[inItem.id] = nil
        saveToDoList()
    }
    
    func insertItemAt(index: Int, item: ToDoItem) {
        var newItem = item
        newItem.seq = index * 10 - 5
        toDoItems[newItem.id] = newItem
        saveToDoList()
    }
    
    func removeItemAt(_ index: Int) {
        let itemArray = getAllItems()
        for (idx, item) in itemArray.enumerated() {
            if idx == index {
                toDoItems[item.id] = nil
            }
        }
        saveToDoList()
    }

    func replaceItem(_ inItem: ToDoItem) {
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
        //gives the results in ascending order of the seq field
        return Array(toDoItems.values).sorted(by: { $0.seq < $1.seq })
    }
    
    func getItems(withKey: String ) -> ToDoItem? {
        return toDoItems[withKey]
    }
    
    private func reorgSeq() {
        let itemArray = getAllItems()
        for (index, var item) in itemArray.enumerated() {
            item.seq = index * 10
            toDoItems[item.id] = item
        }
    }
    
    private func saveToDoList() {
        reorgSeq()
        if let encoded = try? JSONEncoder().encode(toDoItems) {
            let defaults = UserDefaults.standard
            defaults.setValue(encoded, forKey: "toDoItems")
            defaults.synchronize()
        }
    }
}
