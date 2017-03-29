//: Playground - noun: a place where people can play

import UIKit
var str = "Hello, playground"

class Symptoms {
    
    
    static let coronaryArteryDisease : [String] = ["Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                                   "Heartburn or Indigestion",
                                                   "Shortness of Breath",
                                                   "Palpitations",
                                                   "Weakness or Fatigue",
                                                   "Nausea",
                                                   "Sweating"]
    static let heartAttack : [String] = ["Heartburn or Indigestion",
                                         "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                         "Discomfort in Back/Jaw/Throat/Arm",
                                         "Sweating",
                                         "Nausea",
                                         "Vomiting",
                                         "Dizziness",
                                         "Weakness or Fatigue",
                                         "Anxiety",
                                         "Shortness of Breath",
                                         "Rapid Heartbeat",
                                         "Irregular Heartbeat"]
    
    static let arrhythmia : [String] = [ "Dizziness",
                                         "Weakness or Fatigue",
                                         "Light-Headedness",
                                         "Palpitations",
                                         "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                         "Shortness of Breath",
                                         "Pounding In Chest"]
    static let atrialFibrillation : [String] = [ "Dizziness",
                                                 "Weakness or Fatigue",
                                                 "Light-Headedness",
                                                 "Palpitations",
                                                 "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                                 "Shortness of Breath"]
    static let heartValveDisease : [String] = ["Shortness of Breath",
                                               "Dizziness",
                                               "Weakness or Fatigue",
                                               "Palpitations",
                                               "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                               "Swelling of Ankles/Feet"]
    static let heartFailure : [String] = ["Cough with white sputum",
                                          "Shortness of Breath",
                                          "Bloated",
                                          "Rapid Weight Gain ( 2+ lbs in one day)",
                                          "Dizziness",
                                          "Weakness or Fatigue",
                                          "Palpitations",
                                          "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                          "Swelling of Ankles/Feet",
                                          "Rapid Heartbeat",
                                          "Irregular Heartbeat",
                                          "Nausea"]
    
    static let cardiomyopathy : [String] = ["Fainting",
                                            "Palpitations",
                                            "Weakness or Fatigue",
                                            "Swelling of Ankles/Feet",
                                            "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing"]
    static let pericarditis : [String] = ["Rapid Heartbeat",
                                          "Low-grade Fever",
                                          "Sharp Central Chest Pain"]
    
    let emergencySymptomsList = heartAttack + heartFailure
    
    let symptomsList = heartAttack + coronaryArteryDisease + arrhythmia + atrialFibrillation + heartValveDisease + heartFailure + cardiomyopathy + pericarditis
    var symptomsToAbbreviations = [String: String]()
    var symptomsLegend = [String]()
    
    init (){
        let symptoms = symptomsList.sorted()
        for i in symptoms{
            symptomsToAbbreviations.updateValue("", forKey: i)
        }
        
        
        for (word,abbrev) in symptomsToAbbreviations {
            symptomsToAbbreviations.updateValue(generateKey(word: abbrev), forKey: word)
        }
        for x in symptomsToAbbreviations.keys{
            symptomsLegend.append(symptomsToAbbreviations[x]! + " - " + x)
        }
        
    }

    
    
    private func generateKey(word: String) -> String {
        for index in 0 ... word.characters.count {
    
            if symptomsToAbbreviations.values.contains(word){
                let abbreviation = word.substring(to: word.index(word.startIndex,offsetBy:index))
                return abbreviation
            }
            
        }
         return "Failed Key Generation"
    }
    
    public func getAllSymptoms(list: [String]) -> [String]{
        return symptomsList.sorted()
    }
    
    public func getSymptomsAbbreviations(selected: [String]) -> [String]{
        var abbreviations = [String]() 
        
        for i in selected {
            abbreviations.append(symptomsToAbbreviations[i]!)
        }
        return abbreviations
    }
    public func dangerousSymptoms(selected: [String]) -> Bool{
        var dangerousCounter = 0
        
        for x in selected{
            if emergencySymptomsList.contains(x) {
                dangerousCounter += 1
            }
        }
        if dangerousCounter > 3 {
            return true
        }
        else{
            return false
        }
        
        
    }
    
    
    
    
}

let test = Symptoms()
var array = test.getAllSymptoms
for i in array{
    print(i)
}
