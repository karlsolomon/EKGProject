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

    let emergencySymptomsList = [String]()
    let symptomsList = [String]()

    let symptomsToAbbreviations = [String:String]()
    for String i in symptoms {
    	symptomsToAbbreviations[i,""]
    }
    for (word,abbrev) i in symptomsToAbbreviations.keys {
    	symptomsToAbbreviations[i] = generateKey(i)
    }



    private generateKey(word: String) -> String {
    	for(var i = 0;i<count(word);++i){

    	}
    	var abbreviation = word.substring(to: word.index(word.startIndex,offsetBy:))
    	if(let keyExists = symptomsToAbbreviations[])

    }

