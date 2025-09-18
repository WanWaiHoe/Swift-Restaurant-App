import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    var array : [NSManagedObject] = []
    var loginIndi : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginClick(_ sender: Any) {
        if (nameTxt.text != "" && passwordTxt.text != ""){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
            do {
                let result = try manageContext.fetch(request)
                array = result as! [NSManagedObject]
            } catch let error as NSError {
                print(error)
            }
            
            for object in array {
                let user : User = object as! User
                if (user.username == nameTxt.text!.description && user.password == passwordTxt.text!.description){
                    loginIndi = true
                }
            }
            
            if (loginIndi == true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabbar = storyboard.instantiateViewController(identifier: "tabbar") as UITabBarController
                present(tabbar, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Login Fail", message: "Invalid username or password", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Login Fail", message: "Please fill in all the blank", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}
