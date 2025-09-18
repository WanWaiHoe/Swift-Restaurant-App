import UIKit
import CoreData

class DetailViewController: UIViewController {

    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRemark: UITextField!
    var product : Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        productName.text = product!.productName!.description
        productPrice.text = product!.productPrice!.description
        productRemark.text = product!.remark!.description
        productImage.image = UIImage(data: product!.productImage!)
    }
    
    @IBAction func updateDetail(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
        request.predicate = NSPredicate(format: "productName = %@", product!.productName!.description)
        do {
            let result = try manageContext.fetch(request)
            if (result.count != 0){
                let object = result[0] as! NSManagedObject
                object.setValue(productRemark.text!.description, forKey: "remark")
                let alert = UIAlertController(title: "Update Successfully!!!", message: "Remark update successfully", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        } catch let error as NSError {
            print(error)
        }
    }

    @IBAction func deleteItem(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
        request.predicate = NSPredicate(format: "productName = %@", productName!.text!.description)
        do {
            let result = try manageContext.fetch(request)
            if (result.count != 0){
                let object = result[0] as! NSManagedObject
                manageContext.delete(object)
                let alert = UIAlertController(title: "Delete Successfully!!!", message: "Item deleted successfully", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
