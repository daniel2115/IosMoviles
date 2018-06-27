//
//  ArticleViewController.swift
//  iCatchUp
//
//  Created by Developer User on 6/5/18.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticleViewController: UIViewController {
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var referenceLabel: UILabel!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = article {
            titleLabel.text = article.title
            descriptionLabel.text = article.description
            if let url = URL(string: article.urlToImage) {
                pictureImageView.af_setImage(withURL: url)
            }
        }
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    @IBAction func browserAction(_ sender: UIButton) {
        if let article = article{
            if let url = URL(string: article.url){
                UIApplication.shared.open(url, options:[:])
            }
        }
    }
    
}
