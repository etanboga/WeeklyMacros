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
        newMacro.setValue(calories, forKey: "calories")
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
}
