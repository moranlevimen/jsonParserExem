//
//  ViewController.swift
//  jsonParse3.6
//
//  Created by moran levi on 3.6.2018.
//  Copyright © 2018 LeviMoran. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var heros = [HeroStars]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadjSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heros[indexPath.row].localized_name.capitalized
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? Hero_sViewController{
            destination.hero = heros[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

    
    func downloadjSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            
            if error == nil{
                do{
                    self.heros = try JSONDecoder().decode([HeroStars].self, from: data!)
                    DispatchQueue.main.async{
                        completed()
                    }

                }catch{
                    print("Json error")
                }
                
            }
            
        }.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

