//
//  ViewController.swift
//  BirthdayWithCoreData
//
//  Created by yurik on 7/13/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
/* удаляем за ненадобностью
protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(_ addbirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday)
}*/

class AddBirthdayViewController: UIViewController {

    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet weak var birthDayPicker: UIDatePicker!
    
   // var delegate: AddBirthdayViewControllerDelegate? //делегат для сообщения контроллеру BirthDayTableView о добавлении нового дня рождения контроллером AddBirthDayView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthDayPicker.maximumDate = Date()
        
    }
    
    @IBAction func saveTaped(_sender: UIBarButtonItem){
        
        let firstName = firstNameTF.text ?? ""
        let lastName = lastNameTF.text ?? ""
        let birthDayDate = birthDayPicker.date
        
        //доступ к контексту
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //используем context  для создания Birthday(сущность) и заполняем атрибуты сущности(поля таблицы)
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdayDate = birthDayDate
        newBirthday.birthdayId = UUID().uuidString
        
        //сохранение введенных значений в сущность из contexta в базуДанных
        do {
            try context.save()
            let message = "Сегодня Днюха у \(firstName) \(lastName)!!!" //переменная-уведомление
            //уведомление которое будет отправленно в нужный день
            let content = UNMutableNotificationContent() //содержит данные для уведомления
            content.body = message //сообщение
            content.sound = UNNotificationSound.default //звук по умолчанию
            
            //создание триггера для включения уведомления
            var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthDayDate) //получаем месяц и день в формате dateComponents из birthDayDate(тип Date)
            dateComponents.hour = 14 //чтоб триггер срабатывал в 8 утра
            dateComponents.minute = 03
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) //true - для повторения триггера
            
            //идентификатор уведомления
            if let identifier = newBirthday.birthdayId{
               
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)//создаем UNNotificationRequest с помощью identifier, content, trigger
                let center = UNUserNotificationCenter.current()// добавляем значение request в UNUserNotificationCenter с помощью метода add
                center.add(request, withCompletionHandler: nil)
            }
                       
            
        } catch let error {
            print("Не удалось сохранить из-за ошибки - \(error)")
        }
        
        
        if let uniqeID = newBirthday.birthdayId {
            print("ID - \(uniqeID)")
        }
        
        
     //   let newBirtDay = Birthday(firstname: firstName, lastName: lastName, date: birthDayDate)
      
//        print("Имя: \(newBirtDay.firstName) ")
//        print("Фамилия: \(newBirtDay.lastName) ")
//        print("Дата рождения: \(newBirtDay.birthDate) ")
     //   delegate?.addBirthdayViewController(self, didAddBirthday: newBirtDay) передавать с помощью делегата информацию не нужно
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}

