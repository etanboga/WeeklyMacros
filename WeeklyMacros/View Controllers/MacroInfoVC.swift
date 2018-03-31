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
        let numberToDivideBy = Utilities.getDaysRemainingInWeek()
        let calories = (currentMacros.value(forKey: "calories") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let carbohydrates = (currentMacros.value(forKey: "carbohydrates") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let protein = (currentMacros.value(forKey: "protein") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let fat = (currentMacros.value(forKey: "fat") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        
        let caloriesString = String(calories) + " kcal"
        let carbohydratesString = String(carbohydrates) + " g"
        let proteinString = String(protein) +  " g"
        let fatString = String(fat) + " g"
        
        caloriesLabel.text = caloriesString
        let orangeColor = UIColor(hexString: Constants.orangeColorString)
        if calories < 0 {
            caloriesLabel.textColor = orangeColor
        }
        carbohydratesLabel.text = carbohydratesString
        if carbohydrates < 0 {
            carbohydratesLabel.textColor = orangeColor
        }
        proteinLabel.text = proteinString
        if protein < 0 {
            proteinLabel.textColor = orangeColor
        }
        fatLabel.text = fatString
        if fat < 0 {
            fatLabel.textColor = orangeColor
        }
    }
    
    //MARK: - Unwind Segue
    
    @IBAction func unwindToMacroInfoVC(segue: UIStoryboardSegue) {
        
    }
    
    //MARK: - Test / Explanation functions
    
    //prints all days with remaining days (AKA divide value for Macros) to see how the value is calculated
    
    /*
     
     Sunday 1 6 7-6 = 1
     Monday 2 0 7-0 = 7
     Tuesday 3 1 7-1 = 6
     Wednesday 4 2 7-2 = 5
     Thursday 5 3 7-3 = 4
     Friday 6 4 7-4 = 3
     Saturday 7 5 7-5 = 2
     
     */
    
    private func printWeekDaysWithRemainingDays() {
        let daysOfWeek = 7
        for  index in 0..<daysOfWeek {
            let f = DateFormatter()
            var dateComponents = DateComponents()
            dateComponents.setValue(index, for: .weekday)
            var currentDayOfWeek = index - 1
            if (currentDayOfWeek == -1 )  { //if currentDayOfWeekWasSunday
                currentDayOfWeek = 6 //set it to 6 so that it is the last day
            }
            print(f.weekdaySymbols[dateComponents.weekday!] + "     "  + String(daysOfWeek - currentDayOfWeek))
            print(dateComponents.weekday!)
            
        }
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
