//
//  BirthdaysTableViewController.swift
//  BirthdayWithCoreData
//
//  Created by yurik on 7/14/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit
import CoreData

class BirthdaysTableViewController: UITableViewController /*AddBirthdayViewControllerDelegate */{

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
    //в данном методе отображаем содержимое базыДанных в табличный список
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //доступ к контексту
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //  создаем объект типа NSFetchRequest<Birthday> для извлечения элементов табл Birthday методом fetchRequest()           
        let fetchRequest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
       
        //сортировка по алфавиту
        let sortDescriptor1 = NSSortDescriptor(key: "lastName", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "firstName", ascending: true)
        
        fetchRequest.sortDescriptors = [ sortDescriptor2, sortDescriptor1]
        
        do {
           birthdays = try context.fetch(fetchRequest)//возвращение массива объектов указанного в fetchRequest
        } catch let error {
            print("Не удалось сохранить из-за ошибки - \(error)")
        }
        tableView.reloadData()
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
        cell.textLabel?.text = birthday.firstName! + " " + birthday.lastName!
         
        //отображаем значения объекта массива в строках ячейки (Subtitle)
       
        cell.detailTextLabel?.text = formDate.string(from: birthday.birthdayDate!)
        
         
        return cell
    }
    

    //Для удаления с помощью SWIPE :
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if birthdays.count > indexPath.row {
            let birthday = birthdays [indexPath.row]//присваиваем соответствующий объект из массива birthdays для удаления
            
            //доступ к контексту
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(birthday) //удаляем объект из контекста(базы данных)
            birthdays.remove(at: indexPath.row) //удаляем объект из массива birthdays
           
            //сохранение введенных значений в сущность из contexta в базуДанных
            do {
                try context.save()
            } catch let error {
                print("Не удалось сохранить из-за ошибки - \(error)")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade) //удаление требуемого ряда из табличного представления
        }
    }
    

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

    /*
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
    */
/* удаляем за ненадобностью
    //MARK: AddBirthdayViewControllerDelegate
    
    func addBirthdayViewController(_ addbirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday) {
        birthdays.append(birthday)
        tableView.reloadData()
    }*/
}
