//
//  SourceViewController.swift
//  iCatchUp
//
//  Created by Developer User on 6/5/18.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SourceViewController: UIViewController {
    
    var source: Source?
    var isFavorite: Bool = false
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let source = source {
            nameLabel.text = source.name
            descriptionLabel.text = source.description
            categoryLabel.text = source.category
            languageLabel.text = source.language
            countryLabel.text = source.country
            if let url = URL(string: source.urlToLogo) {
                logoImageView.af_setImage(withURL: url)
            }
            isFavorite = source.isFavorite()
            setupFavoriteImage()
        }
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        // TODO: Favorite / Unfavorite source
        isFavorite = !isFavorite
        if let source = source {
            source.setFavorite(isFavorite: isFavorite)
            let store = CatchUpStore()
            print("Favorites: \(store.favoriteSourceIdsAsString())")
        }
        setupFavoriteImage()
    }
    
    func setupFavoriteImage() {
        favoriteButton.setImage(
            UIImage(named: (
                self.isFavorite ?
                    "heart-black" :
                "heart-border-black")), for: .normal)
    }
    
}















