//
//  BirthdaysTableViewController.swift
//  BirthdayWithCoreData
//
//  Created by yurik on 7/14/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit

class BirthdaysTableViewController: UITableViewController, AddBirthdayViewControllerDelegate {

    var birthdays = [Birthday]()
    let formDate = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formDate.dateFormat = "EEE-MMM-yyyy"
        formDate.dateStyle = .full
        formDate.timeStyle = .none
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return birthdays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //Создание ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCellIdentifier", for: indexPath)

        // с помощью indexPath.row находим нужный объект массива типа Birthday
        let birthday = birthdays[indexPath.row]
        
        //отображаем значения объекта массива в строках ячейки (Title)
        cell.textLabel?.text = birthday.firstName + " " + birthday.lastName
         
        //отображаем значения объекта массива в строках ячейки (Subtitle)
        cell.detailTextLabel?.text = formDate.string(from: birthday.birthDate)
        
         
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // для создания делегатом BirthdayTableViewController в AddbirthdayViewController пишем три строки
        //1. добираемся до NavigationController
        let navigationController = segue.destination as! UINavigationController
        //2. Добираемся до AddBirthdayViewController
        let addBirthdayViewController = navigationController.topViewController as! AddBirthdayViewController
        //3. создания BirthdayTableViewController делегатом 
        addBirthdayViewController.delegate = self
    }
    

    //MARK: AddBirthdayViewControllerDelegate
    
    func addBirthdayViewController(_ addbirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday) {
        birthdays.append(birthday)
        tableView.reloadData()
    }
}
