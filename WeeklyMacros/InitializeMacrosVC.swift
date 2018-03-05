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
    
    @IBOutlet weak var carbohydratesTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
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
        let passedEmptyChecks = Utilities.performEmptyChecks(caloriesTextField: caloriesTextField, carbohydratesTextField: carbohydratesTextField, proteinTextField: proteinTextField, fatTextField: fatTextField, errorLabel: errorLabel)
        if (!passedEmptyChecks) {
            return
        }
        print("passed all checks for empty input")
        let passedNumberChecks = Utilities.performNumberChecks(caloriesTextField: caloriesTextField, carbohydratesTextField: carbohydratesTextField, proteinTextField: proteinTextField, fatTextField: fatTextField, errorLabel: errorLabel)
        if (!passedNumberChecks) {
            return
        }
        print("passed all checks for number input")
        
    }
    
}

