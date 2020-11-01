//
//  HomeWorldVC.swift
//  starwars
//
//  Created by Gustavo Cortez on 01/11/2020.
//

import UIKit

class HomeWorldVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rotationLbl: UILabel!
    @IBOutlet weak var orbitalLbl: UILabel!
    @IBOutlet weak var diameterLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var gravityLbl: UILabel!
    @IBOutlet weak var terrainLbl: UILabel!
    @IBOutlet weak var surfaceLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    
    var url: String! = ""
    
    var homeWorld: World!

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(url ?? "Nada")
        getWorld()
 
        
    }
    
    func getWorld() {
        StarWarsServices.shared.getWorld(url: url, onSuccess: { (world) in
            debugPrint(world)
            self.homeWorld = world as World
            self.set()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func set() {
        DispatchQueue.main.async {
            self.nameLbl.text = self.homeWorld.name
            self.rotationLbl.text = self.homeWorld.rotation_period
            self.orbitalLbl.text = self.homeWorld.orbital_period
            self.diameterLbl.text = self.homeWorld.diameter
            self.climateLbl.text = self.homeWorld.climate
            self.gravityLbl.text = self.homeWorld.gravity
            self.terrainLbl.text = self.homeWorld.terrain
            self.surfaceLbl.text = self.homeWorld.surface_water
            self.populationLbl.text = self.homeWorld.population
        }
    }
    
    @IBAction func closeModal(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
