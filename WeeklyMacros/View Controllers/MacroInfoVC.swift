//
//  MacroInfoVC.swift
//  WeeklyMacros
//
//  Created by Ege Tanboga on 3/7/18.
//  Copyright © 2018 Tanbooz. All rights reserved.
//

import UIKit

class MacroInfoVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveMacros()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func retrieveMacros() {
        guard let currentMacros = CoreDataHelper.getMacros() else { return }
        for macro in currentMacros {
            print(macro)
        }
//        let calories = currentMacros.value(forKey: "calories") as! Double
//        let carbohydrates = currentMacros.value(forKey: "carbohydrates") as! Double
//        let protein = currentMacros.value(forKey: "protein") as! Double
//        let fat = currentMacros.value(forKey: "fat")as! Double
    }
}
