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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.retrieveMacros()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func retrieveMacros() {
        guard let currentMacros = CoreDataHelper.getMacros() else { return }
        let numberToDivideBy = 7.0
        
        
        
        let calories = (currentMacros.value(forKey: "calories") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let carbohydrates = (currentMacros.value(forKey: "carbohydrates") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let protein = (currentMacros.value(forKey: "protein") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let fat = (currentMacros.value(forKey: "fat") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        
        let caloriesString = String(calories)
        let carbohydratesString = String(carbohydrates) + "g"
        let proteinString = String(protein) + "g"
        let fatString = String(fat) + "g"
        
        caloriesLabel.text = caloriesString
        carbohydratesLabel.text = carbohydratesString
        proteinLabel.text = proteinString
        fatLabel.text = fatString
    }
    
    //MARK: - Unwind Segue
    
    @IBAction func unwindToMacroInfoVC(segue: UIStoryboardSegue) {
        
    }
    
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
