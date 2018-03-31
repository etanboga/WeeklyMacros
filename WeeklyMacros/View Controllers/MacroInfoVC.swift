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
        let numberToDivideBy = getDaysRemainingInWeek()
        let calories = (currentMacros.value(forKey: "calories") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let carbohydrates = (currentMacros.value(forKey: "carbohydrates") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let protein = (currentMacros.value(forKey: "protein") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        let fat = (currentMacros.value(forKey: "fat") as! Double / numberToDivideBy).rounded(toPlaces: 2)
        
        let caloriesString = String(calories) + " kcal"
        let carbohydratesString = String(carbohydrates) + " g"
        let proteinString = String(protein) +  " g"
        let fatString = String(fat) + " g"
        
        caloriesLabel.text = caloriesString
        carbohydratesLabel.text = carbohydratesString
        proteinLabel.text = proteinString
        fatLabel.text = fatString
    }
    
    private func getDaysRemainingInWeek() -> Double {
        let currentLocalDate = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
        var currentDayAsInt : Double = Double(Calendar.current.component(.weekday, from: currentLocalDate) - 2) //accommodate for Sunday being the first day
        if currentDayAsInt == -1 { //special case for Sunday
            currentDayAsInt = 6
        }
        let daysRemaining = Constants.daysInWeek - currentDayAsInt
        return daysRemaining
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
