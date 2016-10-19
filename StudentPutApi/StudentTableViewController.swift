//
//  StudentTableViewController.swift
//  StudentPutApi
//
//  Created by Nathan Hopkins on 10/19/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {

    //============================
    //  Mark: - Properties
    //============================
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var student = [Student]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudents()
    }

    //============================
    //  Mark: - General
    //============================
    
    private func fetchStudents() {
        StudentController.fetchStudents { (students) in
            
            self.student = students
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return student.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)

        let student = self.student[indexPath.row]
        
        cell.textLabel?.text = student.name
        // Configure the cell...

        return cell
    }
    
        //============================
        //  Mark: - Actions
        //============================
        
        @IBAction func addButtonTapped(_ sender: UIButton) {
            
            guard let name = nameTextField.text, name.characters.count > 0 else { return }
            
            StudentController.send(studentWithName: name) { (success) in
                
                guard success else { return }
                
                DispatchQueue.main.async {
                    self.nameTextField.text = ""
                    self.nameTextField.resignFirstResponder()
                    
                    self.fetchStudents()
                }
            }
            
        }
}
