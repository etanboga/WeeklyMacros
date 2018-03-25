//
//  MacroInfoVC.swift
//  WeeklyMacros
//
//  Created by Ege Tanboga on 3/7/18.
//  Copyright © 2018 Tanbooz. All rights reserved.
//

import UIKit

class MacroInfoVC : UIViewController {
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveMacros()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func retrieveMacros() {
        guard let currentMacros = CoreDataHelper.getMacros() else { return }
        let caloriesString = String(currentMacros.value(forKey: "calories") as! Double / Constants.daysInWeek) + "g"
        let carbohydratesString = String(currentMacros.value(forKey: "carbohydrates") as! Double / Constants.daysInWeek) + "g"
        let proteinString = String(currentMacros.value(forKey: "protein") as! Double / Constants.daysInWeek) + "g"
        let fatString = String(currentMacros.value(forKey: "fat") as! Double / Constants.daysInWeek) + "g"
        
        caloriesLabel.text = caloriesString
        carbohydratesLabel.text = carbohydratesString
        proteinLabel.text = proteinString
        fatLabel.text = fatString
    }
}
