import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class AgendCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var extraView: UIView!
    
    func updateView(from quotation: Quotation) {
        self.extraView.layer.cornerRadius = 12.0
        self.extraView.layer.borderWidth = 1.0
        
        titleLabel.text = quotation.description
    }
}

class AgendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var quotations: [Quotation] = []
    var specialist: Specialist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quotations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! AgendCell
        
        // Configure the cell
        cell.updateView(from: quotations[indexPath.row])
        return cell
    }
    
    func updateData() {
        let url = TratoHechoApi.GetQuotations
        Alamofire.request(url)
            .responseJSON(completionHandler: { response in
                switch (response.result) {
                case .success(let value):
                    let json = JSON(value)
                    self.quotations = Quotation.buildAll(from:
                        json["quotations"].arrayValue)
                    self.collectionView!.reloadData()
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    break
                }
            })
    }
}









