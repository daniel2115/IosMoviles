//
//  SourcesViewController.swift
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

class SourceCell: UICollectionViewCell {
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var isFavorite: Bool = false
    
    func updateView(from source: Source) {
        nameLabel.text = source.name
        if let url = URL(string: source.urlToLogo) {
            logoImageView.af_setImage(withURL: url)
        }
        isFavorite = source.isFavorite()
        setupFavoriteImage()
    }
    func setupFavoriteImage() {
        favoriteImageView.image =
            UIImage(named: (isFavorite ? "heart-black" : "heart-border-black"))
    }
}
class SourcesViewController: UICollectionViewController {
    var sources: [Source] = []
    var currentItemIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sources.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
            for: indexPath) as! SourceCell
    
        // Configure the cell
        cell.updateView(from: sources[indexPath.row])
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSource" {
            let sourceViewController = (segue.destination as! UINavigationController).viewControllers.first as! SourceViewController
            sourceViewController.source = sources[currentItemIndex]
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentItemIndex = indexPath.row
        self.performSegue(withIdentifier: "showSource", sender: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let collectionView = collectionView {
            if collectionView.numberOfItems(inSection: 0) > 0 {
                collectionView.reloadItems(
                    at: [IndexPath(row: currentItemIndex, section: 0)])
            }
        }
    }
    
    func updateData() {
        let parameters = ["apiKey" : NewsApi.key]
        Alamofire.request(NewsApi.sourcesUrl, parameters: parameters)
        .validate()
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"]
                if status == "error" {
                    print("Response Error: \(json["message"].stringValue)")
                    return
                }
                self.sources = Source.buildAll(from: json["sources"].arrayValue)
                self.collectionView!.reloadData()
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        })
    }
}
