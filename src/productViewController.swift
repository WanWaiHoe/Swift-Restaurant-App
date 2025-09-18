import UIKit
import CoreData

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mcChickenImage: UIImageView!
    @IBOutlet weak var prosperityImage: UIImageView!
    @IBOutlet weak var bigMacImage: UIImageView!
    @IBOutlet weak var cartTable: UITableView!
    var array: [NSManagedObject] = []
    var total : Double = 0
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageObject = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
        do {
            let result = try manageObject.fetch(request)
            array = result as! [NSManagedObject]
            cartTable.reloadData()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let product : Product = array[indexPath.row] as! Product
        cell?.textLabel?.text = "Name: \(product.productName!)  Remark: \(product.remark!)"
        cell?.detailTextLabel?.text = "Price: \(product.productPrice!)"
        cell?.imageView?.image = UIImage(data: product.productImage!)
        return cell!
    }
    
    
    @IBAction func buyMcChicken(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: manageContext)
        let product = NSManagedObject(entity: entity!, insertInto: manageContext) as! Product
        product.productName = "Mc Chicken"
        product.productPrice = "RM 10.00"
        product.productImage = UIImage.pngData(mcChickenImage.image!)()
        product.remark = ""
        total += 10
        do {
            try manageContext.save()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageObject = appDelegate.persistentContainer.viewContext
            let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
            do {
                let result = try manageObject.fetch(request)
                array = result as! [NSManagedObject]
                cartTable.reloadData()
            }catch let error as NSError{
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func buyProsperity(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: manageContext)
        let product = NSManagedObject(entity: entity!, insertInto: manageContext) as! Product
        product.productName = "Prosperity Set"
        product.productPrice = "RM 12.00"
        product.productImage = UIImage.pngData(prosperityImage.image!)()
        product.remark = ""
        total += 12
        do {
            try manageContext.save()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageObject = appDelegate.persistentContainer.viewContext
            let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
            do {
                let result = try manageObject.fetch(request)
                array = result as! [NSManagedObject]
                cartTable.reloadData()
            }catch let error as NSError{
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func buyBigMac(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: manageContext)
        let product = NSManagedObject(entity: entity!, insertInto: manageContext) as! Product
        product.productName = "Big Mac"
        product.productPrice = "RM 15.00"
        product.productImage = UIImage.pngData(bigMacImage.image!)()
        product.remark = ""
        total += 15
        do {
            try manageContext.save()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageObject = appDelegate.persistentContainer.viewContext
            let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
            do {
                let result = try manageObject.fetch(request)
                array = result as! [NSManagedObject]
                cartTable.reloadData()
            }catch let error as NSError{
                print(error)
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let destination = segue.destination as! DetailViewController
            let product = array[cartTable.indexPathForSelectedRow!.row] as! Product
            destination.product = product
        } else if (segue.identifier == "checkOut") {
            let destination = segue.destination as! CheckOutViewController
            destination.total = total
        }
    }
}
