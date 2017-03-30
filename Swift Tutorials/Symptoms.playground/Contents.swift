//: Playground - noun: a place where people can play

import UIKit
var str = "Hello, playground"

class Symptoms {
    
    
    let coronaryArteryDisease : [String] = ["Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                                   "Heartburn or Indigestion",
                                                   "Shortness of Breath",
                                                   "Palpitations",
                                                   "Weakness or Fatigue",
                                                   "Nausea",
                                                   "Sweating"]
    let heartAttack : [String] = ["Heartburn or Indigestion",
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
    
    let arrhythmia : [String] = [ "Dizziness",
                                         "Weakness or Fatigue",
                                         "Light-Headedness",
                                         "Palpitations",
                                         "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                         "Shortness of Breath",
                                         "Pounding In Chest"]
    let atrialFibrillation : [String] = [ "Dizziness",
                                                 "Weakness or Fatigue",
                                                 "Light-Headedness",
                                                 "Palpitations",
                                                 "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                                 "Shortness of Breath"]
    let heartValveDisease : [String] = ["Shortness of Breath",
                                               "Dizziness",
                                               "Weakness or Fatigue",
                                               "Palpitations",
                                               "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing",
                                               "Swelling of Ankles/Feet"]
    let heartFailure : [String] = ["Cough with white sputum",
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
    
   let cardiomyopathy : [String] = ["Fainting",
                                            "Palpitations",
                                            "Weakness or Fatigue",
                                            "Swelling of Ankles/Feet",
                                            "Chest Pain/Discomfort/Pressure/Heaviness/Burning/Fullness/Squeezing"]
    let pericarditis : [String] = ["Rapid Heartbeat",
                                          "Low-grade Fever",
                                          "Sharp Central Chest Pain"]
    

    var emergencySymptomsList = [String]()
    var symptomsList = [String]()
    var symptomsToAbbreviations = [String: String]()
    var symptomsLegend = [String]()
    
    init (){
        emergencySymptomsList = heartAttack + heartFailure
        symptomsList = heartAttack + coronaryArteryDisease + arrhythmia + atrialFibrillation
        symptomsList += coronaryArteryDisease + arrhythmia + atrialFibrillation
        symptomsList += arrhythmia
        symptomsList += heartValveDisease + heartFailure + cardiomyopathy + pericarditis
        
        let symptoms = symptomsList.sort()
        //print("\(symptoms)")
        for i in symptoms{
            symptomsToAbbreviations.updateValue("", forKey: i)
            
        }
       // print("intial \(symptomsToAbbreviations)")
        
        for (word,abbrev) in symptomsToAbbreviations {
            //print(" generated key is \(generateKey(word))")
            symptomsToAbbreviations.updateValue(generateKey(word), forKey: word)
        }
        //print("keys made \(symptomsToAbbreviations)")
        for x in symptomsToAbbreviations.keys{
            symptomsLegend.append(symptomsToAbbreviations[x]! + " - " + x)
        }
        
    }

    
    
    internal func generateKey(word: String) -> String {
        for index in 1 ... word.characters.count {
           // print(symptomsToAbbreviations[word])
           // print(" word is \(word)")
            let substring = word[word.startIndex..<word.startIndex.advancedBy(index)]
            
            if symptomsToAbbreviations.values.contains(substring) == false {
         //       print(" substring is \(substring)")
                let abbreviation = word[word.startIndex..<word.startIndex.advancedBy(index)]
                return abbreviation
            }
            
        }
         return "Failed Key Generation"
    }
    
    internal func getAllSymptoms() -> [String]{
        let sorted = symptomsList.sort()
        return sorted
    }
    
    internal func getSymptomsAbbreviations(selected: [String]) -> [String]{
        var abbreviations = [String]() 
        
        for i in selected {
            abbreviations.append(symptomsToAbbreviations[i]!)
        }
        return abbreviations
    }
    internal func dangerousSymptoms(selected: [String]) -> Bool{
        var dangerousCounter = 0
        
        for x in selected{
            if emergencySymptomsList.contains(x) {
                dangerousCounter += 1
            }
        }
        print(dangerousCounter)
        if dangerousCounter >= 3 {
            return true
        }
        else{
            return false
        }
        
        
    }

    
}

