import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var historyTView: UITableView!
    var array : [NSManagedObject] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "History")
        do {
            let result = try manageContext.fetch(request)
            array = result as! [NSManagedObject]
            historyTView.reloadData()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let history : History = array[indexPath.row] as! History
        cell?.textLabel?.text = "Total Price: \(history.total)"
        cell?.detailTextLabel?.text = "Payment Method: \(history.paymentMethod!)  Ship Addredd: \(history.address!)"
        return cell!
    }
}
