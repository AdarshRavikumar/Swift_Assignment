
import UIKit

class DisplayOptions: UIViewController ,UITableViewDelegate, UITableViewDataSource{
  

    @IBOutlet weak var optionsTableView: UITableView!
    var options = ["home","work","school","iPhone","mobile","main","home fax","work fax","pager","other"]
    
    var OptionsDelegate : DisplayContacts?
    var OptionsDelegateContacts : AddContactViewController?
    var tableViewClass: String?
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        optionsTableView.allowsMultipleSelection = false
        optionsTableView.allowsSelectionDuringEditing = false
        
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell = optionsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
        
      }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.accessoryType = .checkmark
        if (tableViewClass == "AddContactViewController") {
            OptionsDelegateContacts?.clickedValue(valueName: options[indexPath.row])
            print("here in the add Contacts")
        }
        else if (tableViewClass == "DisplayContacts") {
            OptionsDelegate?.clickedValue(valueName: options[indexPath.row])
              print("here in the Display Contacts")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
