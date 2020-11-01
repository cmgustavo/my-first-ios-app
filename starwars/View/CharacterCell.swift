//
//  CharacterCell.swift
//  starwars
//
//  Created by Gustavo Cortez on 31/10/2020.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var itemLbl: UILabel!
    
    func updateCell(character: Character) {
        itemLbl.text = character.name
    }
}
