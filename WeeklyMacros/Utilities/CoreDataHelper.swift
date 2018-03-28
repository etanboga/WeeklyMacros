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
        CoreDataHelper.deleteMacros()
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
        } catch {
            print("Saving to Core Data Failed")
        }
    }
    
    static func updateMacros(calories: Double, carbohydrates: Double, protein: Double, fat: Double) {
        let currentMacros = CoreDataHelper.getMacros()
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
            print("Couldn't fetch. \(error), \(error.userInfo)")
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
            print("Couldn't fetch. \(error), \(error.userInfo)")
            return false
        }
        return false
    }
}
