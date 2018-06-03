//
//  Hero'sViewController.swift
//  jsonParse3.6
//
//  Created by moran levi on 3.6.2018.
//  Copyright © 2018 LeviMoran. All rights reserved.
//

import UIKit

class Hero_sViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var attrackLabel: UILabel!
    @IBOutlet var attributeLabel: UILabel!
    
    var hero: HeroStars?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = hero?.localized_name
        attrackLabel.text = hero?.attack_type
        attributeLabel.text = hero?.primary_attr
        
        let urlString = "https://api.opendota.com"+(hero?.img)!
        let url = URL(string: urlString)
        imageView.downloadedFrom(url: url!)
        
    }

}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
