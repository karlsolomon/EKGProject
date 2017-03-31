//
//  Symptoms.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/31/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation

class Symptoms {
    private let chestPain = "Chest Pain/Pressure/Burning/Squeezing"
    private let heartburn = "Heartburn or Indigestion"
    private let discomfort = "Discomfort in Back/Jaw/Throat/Arm"
    private let sweating = "Sweating"
    private let nausea = "Nausea"
    private let vomiting = "Vomiting"
    private let dizziness = "Dizziness"
    private let fatigue = "Weakness or Fatigue"
    private let anxiety = "Anxiety"
    private let outOfBreath = "Shortness of Breath"
    private let tachycardia = "Rapid Heartbeat"
    private let irregular = "Irregular Heartbeat"
    private let lightHeaded = "Light-Headedness"
    private let palpitations = "Palpitations"
    private let pounding = "Pounding In Chest"
    private let swelling = "Swelling of Ankles/Feet"
    private let sputum = "Cough with white sputum"
    private let bloated = "Bloated"
    private let weightGain = "Rapid Weight Gain ( 2+ lbs in one day)"
    private let fainting = "Fainting"
    private let lowFever = "Low-grade Fever"
    private let sharpChestPain = "Sharp Central Chest Pain"
    
    private var coronaryArteryDisease = Set<String>()
    private var heartAttack = Set<String>()
    private var arrhythmia = Set<String>()
    private var atrialFibrillation = Set<String>()
    private var heartValveDisease = Set<String>()
    private var heartFailure = Set<String>()
    private var cardiomyopathy = Set<String>()
    private var pericarditis = Set<String>()
    private var emergencySymptomsList = [String]()
    private var symptomsList = [String]()
    private var symptomsToAbbreviations = [String: String]()
    private var symptomsLegend = [String]()
    
    static let instance = Symptoms()
    
    private init (){
        populateLists()
        emergencySymptomsList = Array(heartAttack.union(heartFailure).union(pericarditis))
        symptomsList = Array(coronaryArteryDisease.union(heartAttack).union(arrhythmia).union(atrialFibrillation).union(heartValveDisease).union(heartFailure).union(cardiomyopathy).union(pericarditis))
        
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
        symptomsLegend.sortInPlace()
        
    }
    
    private func populateLists() {
        heartFailure = [sputum,
                        outOfBreath,
                        bloated,
                        weightGain,
                        dizziness,
                        fatigue,
                        palpitations,
                        chestPain,
                        swelling,
                        tachycardia,
                        irregular,
                        nausea]
        
        cardiomyopathy = [fainting,
                          palpitations,
                          fatigue,
                          swelling,
                          chestPain]
        pericarditis = [tachycardia,
                        lowFever,
                        sharpChestPain]
        
        heartAttack = [heartburn,
                       chestPain,
                       discomfort,
                       sweating,
                       nausea,
                       vomiting,
                       dizziness,
                       fatigue,
                       anxiety,
                       outOfBreath,
                       tachycardia,
                       irregular]
        
        coronaryArteryDisease = [chestPain,
                                                        heartburn,
                                                        outOfBreath,
                                                        palpitations,
                                                        fatigue,
                                                        nausea,
                                                        sweating]
        
        arrhythmia = [ dizziness,
                                              fatigue,
                                              lightHeaded,
                                              palpitations,
                                              chestPain,
                                              outOfBreath,
                                              pounding]
        
        atrialFibrillation = [ dizziness,
                                                      fatigue,
                                                      lightHeaded,
                                                      palpitations,
                                                      chestPain,
                                                      outOfBreath]
        heartValveDisease = [outOfBreath,
                                                    dizziness,
                                                    fatigue,
                                                    palpitations,
                                                    chestPain,
                                                    swelling]
      
        
        
    }
    
    private func generateKey(word: String) -> String {
        for index in 1 ... word.characters.count {
            let substring = word[word.startIndex..<word.startIndex.advancedBy(index)]
            
            if symptomsToAbbreviations.values.contains(substring) == false {
                let abbreviation = word[word.startIndex..<word.startIndex.advancedBy(index)]
                return abbreviation
            }
            
        }
        return "Failed Key Generation"
    }
    
    func getSymptomsLegend() -> [String]{
        return symptomsLegend
    }
    
    func getAllSymptoms() -> [String]{
        let sorted = symptomsList.sort()
        return sorted
    }
    
    func getSymptomsAbbreviations(selected: [String]) -> [String]{
        var abbreviations = [String]()
        
        for i in selected {
            abbreviations.append(symptomsToAbbreviations[i]!)
        }
        return abbreviations
    }
    func dangerousSymptoms(selected: [String]) -> Bool{
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
