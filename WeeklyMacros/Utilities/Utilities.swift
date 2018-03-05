//
//  Utilities.swift
//  WeeklyMacros
//
//  Created by Ege Tanboga on 3/4/18.
//  Copyright © 2018 Tanbooz. All rights reserved.
//

import UIKit

class Utilities {
    static func performNumberChecks(caloriesTextField: UITextField?, carbohydratesTextField: UITextField?, proteinTextField: UITextField?, fatTextField: UITextField?, errorLabel: UILabel?) -> Bool {
        if let calories = caloriesTextField?.text, let carbohydrates = carbohydratesTextField?.text,
            let protein = proteinTextField?.text, let fat = fatTextField?.text {
            if let caloriesAsDouble = Double(calories), let carbohydratesAsDouble = Double(carbohydrates),
                let proteinAsDouble = Double(protein), let fatAsDouble = Double(fat) {
                print(caloriesAsDouble)
                print(carbohydratesAsDouble)
                print(proteinAsDouble)
                print(fatAsDouble)
            } else {
                errorLabel?.text = "Please enter all values as numbers"
                return false
            }
        }
        return true
    }
    
    static func performEmptyChecks(caloriesTextField: UITextField?, carbohydratesTextField: UITextField?, proteinTextField: UITextField?, fatTextField: UITextField?, errorLabel: UILabel?) -> Bool {
        if (caloriesTextField?.text?.isEmpty)! {
            errorLabel?.text = "Please enter your calories"
            return false
        } else if (carbohydratesTextField?.text?.isEmpty)! {
            errorLabel?.text = "Please enter your carbohydrates goal"
            return false
        } else if (proteinTextField?.text?.isEmpty)! {
            errorLabel?.text = "Please enter your protein goal"
            return false
        } else if (fatTextField?.text?.isEmpty)! {
            errorLabel?.text = "Please enter your fat goal"
            return false
        }
        errorLabel?.text = ""
        return true
    }
    
}
