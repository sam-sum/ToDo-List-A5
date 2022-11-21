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
//  DetailViewController.swift
//  ToDo List
//  Date: Nov 27, 2022
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    private var toDoList: ToDoList!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var editingItem: ToDoItem?
    let placeHolderText = "Description"

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoList = ToDoList.sharedToDoList
        
        //Style of task name text field
        nameTextField.delegate = self
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderColor = UIColor.systemGray5.cgColor
        
        //Style of notes text view
        notesTextView.delegate = self
        notesTextView.text = "Description"
        notesTextView.textColor = UIColor.systemGray3
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.borderColor = UIColor.systemGray5.cgColor
        notesTextView.layer.cornerRadius = 10
        
        dueDatePicker.addTarget(self, action: #selector(self.handler(sender:)), for: UIControl.Event.valueChanged)
        
        //prepare initial values passed from the selected cell
        if let currentItem = editingItem {
            let todayDate = Date()
            nameTextField.text = currentItem.name
            notesTextView.text = currentItem.notes
            dateSwitch.setOn(currentItem.hasDueDate, animated: true)
            statusSwitch.setOn(currentItem.isCompleted, animated: true)
            if currentItem.hasDueDate {
                dueDatePicker.date = currentItem.dueDate ?? todayDate
                dueDatePicker.isEnabled = true
            } else {
                dueDatePicker.isEnabled = false
            }
        }
        
        //Dismiss the keyboard if the user tap outside the text field
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // *****
    // Setting placeholder inside the text view
    // *****
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = UIColor.black
        if textView == notesTextView {
            if textView.text == placeHolderText {
                textView.text = ""
            }
        }
    }
    
    // *****
    // Incoperate defaults settings for the notes text view
    // *****
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == notesTextView {
            if textView.text == "" {
                textView.text = placeHolderText
                textView.textColor = UIColor.lightGray
            }
        }
    }

    // *****
    // A handler function to get the date value upon the datepicker selection
    // *****
    @objc func handler(sender: UIDatePicker) {
        editingItem?.dueDate = dueDatePicker.date
    }

    // *****
    // Action function to toggle the hasDueDate switch
    // *****
    @IBAction func DidChangedValueDueDateSwitch(_ sender: UISwitch) {
        if sender.isOn {
            dueDatePicker.isEnabled = true
        } else {
            dueDatePicker.isEnabled = false
        }
        editingItem?.hasDueDate = sender.isOn
    }
    
    // *****
    // Action function to toggle the isCompleted switch
    // *****
    @IBAction func DidChangedValueStatusSwitch(_ sender: UISwitch) {
        editingItem?.isCompleted = sender.isOn
    }
    
    // *****
    // Action function to update the ToDo item with an alert diaglog
    // *****
    @IBAction func DidPressedSaveButton(_ sender: UIButton) {
        let updateAlert = UIAlertController(title: "Update", message: "Confirm to update the Todo?", preferredStyle: UIAlertController.Style.alert)

        updateAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Update alert OK pressed")
            self.toDoList.replaceItem(self.editingItem!)
            self.navigationController?.popToRootViewController(animated: true)
        }))

        updateAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Update alert CANCEL pressed")
        }))

        present(updateAlert, animated: true, completion: nil)
    }
    
    // *****
    // Dismiss the keyboard when return key is clicked
    // *****
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.view.endEditing(true)
        return true
    }
}
