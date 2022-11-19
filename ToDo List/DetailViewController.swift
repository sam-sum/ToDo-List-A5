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
    
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NotesLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var NotesTextView: UITextView!
    @IBOutlet weak var DateSwitch: UISwitch!
    @IBOutlet weak var StatusSwitch: UISwitch!
    
    @IBOutlet weak var UpdateBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var DeleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style of task name text field
        NameTextField.delegate = self
        NameTextField.layer.cornerRadius = 10
        NameTextField.layer.borderColor = UIColor.systemGray5.cgColor
        
        //Style of notes text view
        NotesTextView.delegate = self
        NotesTextView.text = "Description"
        NotesTextView.textColor = UIColor.systemGray3
        NotesTextView.layer.borderWidth = 1
        NotesTextView.layer.borderColor = UIColor.systemGray5.cgColor
        NotesTextView.layer.cornerRadius = 10

    }
    //Setting placeholder inside the text view
    func textViewDidBeginEditing(_ textView: UITextView) {
        if NotesTextView.textColor == UIColor.systemGray3 {
            NotesTextView.text = ""
            NotesTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if NotesTextView.text == "" {
            NotesTextView.text = "Description"
            NotesTextView.textColor = UIColor.lightGray
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
