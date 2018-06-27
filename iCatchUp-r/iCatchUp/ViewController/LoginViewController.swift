import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    var specialist: Specialist?
    var errorMessage: Bool = false
    var acces: Bool = false
    
    @IBOutlet var UserNameText: UITextField?
    @IBOutlet var PasswordText: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        getSpecialist(val1: UserNameText?.text,val2: PasswordText?.text)
        if(acces){
            performSegue(withIdentifier: "showNavigation", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpecialist" {
            let articleViewController = (segue.destination as! UINavigationController).viewControllers.first as! AgendViewController
            articleViewController.specialist = self.specialist
        }
    }
    */
    
    func getSpecialist(val1: String?, val2: String?){
        let url = TratoHechoApi.GetAuthentication
        let parameteresJson = ["login":val1,"password":val2]
        Alamofire.request(url, method: .post, parameters: parameteresJson, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { response in
                switch (response.result) {
                case .success(let value):
                    let json = JSON(value)
                    self.specialist = Specialist.build(from: json)
                    self.errorMessage = false
                    self.acces = true
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self.errorMessage = true
                    self.acces = false
                    break
                }
            })
    }

}
