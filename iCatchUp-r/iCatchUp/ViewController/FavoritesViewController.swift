//
//  FavoritesViewController.swift
//  iCatchUp
//
//  Created by Developer User on 5/31/18.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

private let reuseIdentifier = "Cell"

class ArticleCell: UICollectionViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func updateView(from article: Article) {
        titleLabel.text = article.title
        if let url = URL(string: article.urlToImage) {
            pictureImageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "notavailable"))
        }
    }
}

class FavoritesViewController: UICollectionViewController {
    var articles: [Article] = []
    var currentItemIndex: Int = 0
    
    @IBOutlet weak var noFavoriteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        updateData()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return articles.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return articles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArticleCell
    
        // Configure the cell
        cell.updateView(from: articles[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        updateData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            let articleViewController = (segue.destination as! UINavigationController).viewControllers.first as! ArticleViewController
            articleViewController.article = articles[currentItemIndex]
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentItemIndex = indexPath.row
        performSegue(withIdentifier: "showArticle", sender: self)
    }
    
    func updateData() {
        let store = CatchUpStore()
        
        let favoriteSource = store.favoriteSourceIdsAsString()
        if favoriteSource.isEmpty{
            articles = []
            currentItemIndex = 0
            collectionView?.reloadData()
            noFavoriteLabel.isHidden = false
            return
        }
        noFavoriteLabel.isHidden = true
        let parameters = ["apiKey" : NewsApi.key, "sources" : store.favoriteSourceIdsAsString()]
        Alamofire.request(NewsApi.everythingUrl, parameters: parameters )
        .validate()
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].stringValue
                if status == "error" {
                    print("Error: \(json["message"].stringValue)")
                    return
                }
                let jsonArticles = json["articles"].arrayValue
                self.articles = Article.buildAll(from: jsonArticles)
                self.collectionView!.reloadData()
            case .failure(let error):
                print("Response Error: \(error.localizedDescription)")
            }
        })
    }

}
