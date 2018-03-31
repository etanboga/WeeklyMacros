//
//  EnterTodaysMacrosVC.swift
//  WeeklyMacros
//
//  Created by Ege Tanboga on 3/24/18.
//  Copyright © 2018 Tanbooz. All rights reserved.
//

import UIKit

class EnterTodaysMacrosVC : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var carbohydratesTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        caloriesTextField.delegate = self
        carbohydratesTextField.delegate = self
        proteinTextField.delegate = self
        fatTextField.delegate = self
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
                CoreDataHelper.updateMacros(calories: caloriesAsDouble, carbohydrates: carbohydratesAsDouble, protein: proteinAsDouble, fat: fatAsDouble)
                performSegue(withIdentifier: Constants.unwindToMacroInfoVCSegueId, sender: self)
            }
        }
    }
    
    //MARK: - Segue check
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constants.unwindToMacroInfoVCSegueId {
            let passedEmptyChecks = Utilities.performEmptyChecks(caloriesTextField: caloriesTextField, carbohydratesTextField: carbohydratesTextField, proteinTextField: proteinTextField, fatTextField: fatTextField, errorLabel: errorLabel)
            let passedNumberChecks = Utilities.performNumberChecks(caloriesTextField: caloriesTextField, carbohydratesTextField: carbohydratesTextField, proteinTextField: proteinTextField, fatTextField: fatTextField, errorLabel: errorLabel)
            if (!passedNumberChecks || !passedEmptyChecks) {
                return false
            }
        }
        return true
    }
    
    //MARK: - Text Field Delegate Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

