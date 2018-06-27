import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class CheckListCell: UICollectionViewCell {
    @IBOutlet weak var extraView: UIView!

    func updateView(from quotation: Quotation) {
        self.extraView.layer.cornerRadius = 12.0
        self.extraView.layer.borderWidth = 1.0
        
        //titleLabel.text = quotation.description
    }
}

class CheckListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var quotations: [Quotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1//quotations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CheckListCell
        
        // Configure the cell
        //cell.updateView(from: quotations[indexPath.row])
        return cell
    }
    
    func updateData() {
      
    }
}









