import UIKit
import CoreData

class CheckOutViewController: UIViewController {

    @IBOutlet weak var totalTxt: UILabel!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var switchCash: UISwitch!
    @IBOutlet weak var switchCredit: UISwitch!
    @IBOutlet weak var creditCardNameTxt: UITextField!
    @IBOutlet weak var cvvTxt: UITextField!
    @IBOutlet weak var validDateTxt: UITextField!
    var total : Double?
    var payMethod : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTxt.text = "Total Price: RM \(total!)0"
        switchCredit.isOn = false
        switchCash.isOn = false
        creditCardNameTxt.isHidden = true
        cvvTxt.isHidden = true
        validDateTxt.isHidden = true
    }
    
    @IBAction func cashClick(_ sender: Any) {
        switchCredit.isOn = false
        payMethod = "Pay on item reach"
        creditCardNameTxt.isHidden = true
        cvvTxt.isHidden = true
        validDateTxt.isHidden = true
    }
    
    @IBAction func creditClick(_ sender: Any) {
        switchCash.isOn = false
        payMethod = "Pay on credit card"
        creditCardNameTxt.isHidden = false
        cvvTxt.isHidden = false
        validDateTxt.isHidden = false
    }
    
    @IBAction func checkOutClick(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "History", in: manageContext)
        let history = NSManagedObject(entity: entity!, insertInto: manageContext) as! History
        if (addressTxt.text != "" && (switchCash.isOn || switchCredit.isOn)){
            history.total = Double(total!)
            history.address = addressTxt.text
            history.paymentMethod = payMethod
            
            do {
                try manageContext.save()
                let alert = UIAlertController(title: "Check Out Successfully", message: "Thanks for your purchase", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            } catch let error as NSError {
                print(error)
            }
        } else {
            let alert = UIAlertController(title: "Check Out Fail", message: "Please fill all the blank before you proceed to checkout", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}
