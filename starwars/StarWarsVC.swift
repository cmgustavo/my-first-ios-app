//
//  ViewController.swift
//  starwars
//
//  Created by Gustavo Cortez on 31/10/2020.
//

import UIKit

class StarWarsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var characterTable: UITableView!
    
    var loadingView: UIView = UIView()
    var characters = Array<Character>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Star Wars"
        
        characterTable.delegate = self
        characterTable.dataSource = self
        
        getCharacters()
        
    }
    
    func getCharacters() {
        showActivityIndicator()
        StarWarsServices.shared.getCharacters(onSuccess: { (chars) in
            self.characters = chars.results
            self.characterTable.reloadData()
            self.hideActivityIndicator()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterCell {
            cell.updateCell(character: characters[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func showActivityIndicator() {
        self.loadingView = UIView()
        self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        self.loadingView.center = self.view.center
        self.loadingView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.loadingView.alpha = 0.7
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10

        self.spinner.style = UIActivityIndicatorView.Style.large
        self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

        self.loadingView.addSubview(self.spinner)
        self.view.addSubview(self.loadingView)
        self.spinner.startAnimating()
    }

    func hideActivityIndicator() {
        self.spinner.stopAnimating()
        self.loadingView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = self.characters[indexPath.row]
        performSegue(withIdentifier: "CharacterVC", sender: character)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterVC = segue.destination as? CharacterVC {
            assert(sender as? Character != nil)
            characterVC.characterData = sender as? Character
        }
    }
}

