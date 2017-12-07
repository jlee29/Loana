import UIKit

class TreeController: UIViewController {
    
    @IBOutlet weak var tree: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let treeId = findTreeId()
        print(treeId)
        
        let treeString = "progress_tree_" + String(treeId + 1)
        tree.image = UIImage(named: treeString)
        
        // Do any additional setup after loading the view.
    }
    
    func findTreeId() -> Int {
        let bucket = Session.shared.user.repayment_schedule[Session.shared.currMonth] / 5.0
        
        return Int(Session.shared.user.repayment_balance[Session.shared.currMonth][Session.shared.currDay] / bucket)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
