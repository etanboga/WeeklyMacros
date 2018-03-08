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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Macros", in: context)
        let newMacro = NSManagedObject(entity: entity!, insertInto: context)
        let caloriesForWeek = calories * Constants.daysInWeek
        newMacro.setValue(caloriesForWeek, forKey: "calories")
        newMacro.setValue(carbohydrates, forKey: "carbohydrates")
        newMacro.setValue(protein, forKey: "protein")
        newMacro.setValue(fat, forKey: "fat")
        do {
            try context.save()
            print("saved to Core Data")
        } catch {
            print("Saving to Core Data Failed")
        }
    }
    
    static func getMacros() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Macros")
        do {
            let macros = try context.fetch(fetchRequest)
            return macros
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
}
