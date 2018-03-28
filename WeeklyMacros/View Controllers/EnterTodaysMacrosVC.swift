//
//  EnterTodaysMacrosVC.swift
//  WeeklyMacros
//
//  Created by Ege Tanboga on 3/24/18.
//  Copyright © 2018 Tanbooz. All rights reserved.
//

import UIKit

class EnterTodaysMacrosVC : UIViewController {
    
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var carbohydratesTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        let passedEmptyChecks = Utilities.performEmptyChecks(caloriesTextField: caloriesTextField, carbohydratesTextField: carbohydratesTextField, proteinTextField: proteinTextField, fatTextField: fatTextField, errorLabel: errorLabel)
        if (!passedEmptyChecks) {
            return
        }
        let passedNumberChecks = Utilities.performNumberChecks(caloriesTextField: caloriesTextField, carbohydratesTextField: carbohydratesTextField, proteinTextField: proteinTextField, fatTextField: fatTextField, errorLabel: errorLabel)
        if (!passedNumberChecks) {
            return
        }
        
        if let calories = caloriesTextField?.text, let carbohydrates = carbohydratesTextField?.text,
            let protein = proteinTextField?.text, let fat = fatTextField?.text {
            if let caloriesAsDouble = Double(calories), let carbohydratesAsDouble = Double(carbohydrates),
                let proteinAsDouble = Double(protein), let fatAsDouble = Double(fat) {
                print(caloriesAsDouble)
                print(carbohydratesAsDouble)
                print(proteinAsDouble)
                print(fatAsDouble)
            }
        }
    }
}
