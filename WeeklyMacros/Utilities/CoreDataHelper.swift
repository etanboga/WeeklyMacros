//
//  CoreDataHelper.swift
//  WeeklyMacros
//
//  Created by Ege Tanboga on 3/4/18.
//  Copyright © 2018 Tanbooz. All rights reserved.
//


import CoreData
import UIKit

class CoreDataHelper {
    static func saveMacros(calories: Double, carbohydrates: Double, protein: Double, fat: Double) {
        //delete current macros before saving new ones
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Macros", in: context)
        let newMacro = NSManagedObject(entity: entity!, insertInto: context)
        let caloriesForWeek = calories * Constants.daysInWeek
        let carbsForWeek = carbohydrates * Constants.daysInWeek
        let proteinForWeek = protein * Constants.daysInWeek
        let fatForWeek = fat * Constants.daysInWeek
        newMacro.setValue(Constants.appUser, forKey: "username")
        newMacro.setValue(caloriesForWeek, forKey: "calories")
        newMacro.setValue(carbsForWeek, forKey: "carbohydrates")
        newMacro.setValue(proteinForWeek, forKey: "protein")
        newMacro.setValue(fatForWeek, forKey: "fat")
        do {
            try context.save()
            print("saved to Core Data")
        } catch let error as NSError {
            print("Saving to Core Data Failed. \(error), \(error.userInfo)")
        }
    }
    
    static func updateMacros(calories: Double, carbohydrates: Double, protein: Double, fat: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Macros")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results {
                    if let username = result.value(forKey: "username") as? String {
                        if (username == Constants.appUser) {
                            //then update macros
                            print("entered macro update")
                            let coreDataHelper = CoreDataHelper()
                            coreDataHelper.updateMacroObject(caloriesEaten: calories, carbohydratesEaten: carbohydrates, proteinEaten: protein, fatEaten: fat, macro: result)
                            print(result)
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Couldn't fetch in updateMacros. \(error), \(error.userInfo)")
        }
    }
    
    static func getMacros() -> NSManagedObject? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Macros")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results {
                    if let username = result.value(forKey: "username") as? String {
                        if (username == Constants.appUser) {
                            return result
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Couldn't fetch in getMacros. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    static func deleteMacros() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Macros")
        do {
            let result = try context.fetch(fetchRequest)
            for object in result {
                context.delete(object)
            }
        }
        catch let error as NSError {
            print("Couldn't delete. \(error), \(error.userInfo)")
        }
    }
    
    static func doesMacroExist() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Macros")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results {
                    if let username = result.value(forKey: "username") as? String {
                        if (username == Constants.appUser) {
                            return true
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Couldn't fetch in doesMacroExist. \(error), \(error.userInfo)")
            return false
        }
        return false
    }
    
    fileprivate func updateMacroObject(caloriesEaten: Double, carbohydratesEaten: Double, proteinEaten: Double, fatEaten: Double, macro: NSObject) {
        let currentCalories  = macro.value(forKey: "calories") as! Double
        let currentCarbohydrates = macro.value(forKey: "carbohydrates") as! Double
        let currentProtein = macro.value(forKey: "protein") as! Double
        let currentFat = macro.value(forKey: "fat") as! Double
        macro.setValue(currentCalories - caloriesEaten, forKey: "calories")
        macro.setValue(currentCarbohydrates - carbohydratesEaten , forKey: "carbohydrates")
        macro.setValue(currentProtein - proteinEaten, forKey: "protein")
        macro.setValue(currentFat - fatEaten, forKey: "fat")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
            print("updated macros saved to core data")
        } catch let error as NSError {
            print("Updating in Core Data Failed. \(error), \(error.userInfo)")
        }
    }
}
