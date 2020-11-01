//
//  CharacterVC.swift
//  starwars
//
//  Created by Gustavo Cortez on 31/10/2020.
//

import UIKit

class CharacterVC: UIViewController {
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var massLbl: UILabel!
    @IBOutlet weak var hairColorLbl: UILabel!
    @IBOutlet weak var skinColorLbl: UILabel!
    @IBOutlet weak var eyeColorLbl: UILabel!
    @IBOutlet weak var birthYearLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var homeWorldButton: UIButton!
    
    var characterData: Character!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = characterData.name
        heightLbl.text = characterData.height
        massLbl.text = characterData.mass
        hairColorLbl.text = characterData.hair_color
        skinColorLbl.text = characterData.skin_color
        eyeColorLbl.text = characterData.eye_color
        birthYearLbl.text = characterData.birth_year
        genderLbl.text = characterData.gender
        
        if (characterData.homeworld != "") {
            homeWorldButton.isUserInteractionEnabled = true
        } else {
            homeWorldButton.isUserInteractionEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeWorldVC = segue.destination as? HomeWorldVC {
            homeWorldVC.url = characterData.homeworld
        }
    }
    
}
