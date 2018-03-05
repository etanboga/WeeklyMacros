//
//  ViewController.swift
//  WeeklyMacros
//
//  Created by Ege Tanboga on 3/4/18.
//  Copyright © 2018 Tanbooz. All rights reserved.
//

import UIKit

class InitializeMacrosVC: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var carboydratesTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        errorLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions

    @IBAction func doneButtonClicked(_ sender: UIButton) {
        if (!performEmptyChecks()) {
            return
        }
        print("passed all checks for empty input")
        if (!performNumberChecks()) {
            return
        }
        print("passed all checks for number input")
        
    }
    
    //MARK: Checkers
    
    private func performEmptyChecks() -> Bool {
        if (caloriesTextField?.text?.isEmpty)! {
            errorLabel.text = "Please enter your calories"
            return false
        } else if (carboydratesTextField?.text?.isEmpty)! {
            errorLabel.text = "Please enter your carbohydrates goal"
            return false
        } else if (proteinTextField?.text?.isEmpty)! {
            errorLabel.text = "Please enter your protein goal"
            return false
        } else if (fatTextField?.text?.isEmpty)! {
            errorLabel?.text = "Please enter your fat goal"
            return false
        }
        errorLabel?.text = ""
        return true
    }
    private func performNumberChecks() -> Bool {
        if let calories = caloriesTextField?.text, let carbohydrates = carboydratesTextField?.text,
            let protein = proteinTextField?.text, let fat = fatTextField?.text {
            if let caloriesAsDouble = Double(calories), let carbohydratesAsDouble = Double(carbohydrates),
                let proteinAsDouble = Double(protein), let fatAsDouble = Double(fat) {
                
            } else {
                errorLabel?.text = "Please enter all values as numbers"
                return false
            }
        }
        return true
    }
    
}

