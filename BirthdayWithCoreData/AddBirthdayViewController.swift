//
//  ViewController.swift
//  BirthdayWithCoreData
//
//  Created by yurik on 7/13/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit
protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(_ addbirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday)
}

class AddBirthdayViewController: UIViewController {

    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet weak var birthDayPicker: UIDatePicker!
    
    var delegate: AddBirthdayViewControllerDelegate? //делегат для сообщения контроллеру BirthDayTableView о добавлении нового дня рождения контроллером AddBirthDayView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthDayPicker.maximumDate = Date()
        
    }
    
    @IBAction func saveTaped(_sender: UIBarButtonItem){
        let firstName = firstNameTF.text ?? ""
        let lastName = lastNameTF.text ?? ""
        let birthDayDate = birthDayPicker.date
        
        let newBirtDay = Birthday(firstname: firstName, lastName: lastName, date: birthDayDate)
      
//        print("Имя: \(newBirtDay.firstName) ")
//        print("Фамилия: \(newBirtDay.lastName) ")
//        print("Дата рождения: \(newBirtDay.birthDate) ")
        delegate?.addBirthdayViewController(self, didAddBirthday: newBirtDay)
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}

