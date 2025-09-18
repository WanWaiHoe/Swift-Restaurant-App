import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var contactTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var cPasswordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerClick(_ sender: Any) {
        if (nameTxt.text != "" && emailTxt.text != "" && contactTxt.text != "" && passwordTxt.text != "" && cPasswordTxt.text != ""){
            if (passwordTxt.text == cPasswordTxt.text){
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let manageContext = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "User", in: manageContext)
                let user = NSManagedObject(entity: entity!, insertInto: manageContext) as! User
                user.username = nameTxt.text!.description
                user.email = emailTxt.text!.description
                user.contact = contactTxt.text!.description
                user.password = passwordTxt.text!.description
                do {
                    try manageContext.save()
                    let alert = UIAlertController(title: "Register Success", message: "Registration successfully", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    present(alert, animated: true, completion: nil)
                    
                    nameTxt.text = ""
                    emailTxt.text = ""
                    contactTxt.text = ""
                    passwordTxt.text = ""
                    cPasswordTxt.text = ""
                } catch let error as NSError {
                    print(error)
                }
            } else {
                let alert = UIAlertController(title: "Register Fail", message: "comfirm password didnt match with password", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
        } else {
            let alert = UIAlertController(title: "Register Fail", message: "Please fill in all the blank", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)        }
    }
}
