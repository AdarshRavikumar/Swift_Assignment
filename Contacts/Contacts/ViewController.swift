
import UIKit


class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource  {
 
    @IBOutlet weak var tableView: UITableView!
    static var selectedPerson: Person = Person(name: "", phone: [[:]], company: "", email: [[:]])
    
    var flag = true
    var sectionsInView = ["Details","Contact","Email","BirthDay"]
    static var dictionaryForSections : [String: Int] = [:]
    
    static var mapNameAndPerson = [String: Person]()
  
    var person1 = Person(name: "Ada", phone: [["Phone >" : "112"]], company: "Nuclei", email: [["Email >": "asda"], ["Email >": "adda"]])
    var person2 = Person(name: "Aka", phone: [["Phone >" : "112"], ["Phone >" : "232"]], company: "Nuclei", email: [["Email >":"asda"], ["Email >":"adda"]])
 var person3 = Person(name: "lda", phone: [["Phone >" :"112"], ["Phone >" :"512"] ], company: "Nuclei", email: [["Email >":"asda"],["Email >":"adda"]])
    var person4 = Person(name: "nda", phone: [["Phone >" :"112"],["Phone >" :"312"]], company: "Nuclei", email: [["Email >":"asda"],["Email >":"apda"]])
    var person5 = Person(name: "Aaa", phone: [["Phone >" :"112"],["Phone >" :"232"]], company: "Nuclei", email: [["Email >":"asda"],["Email >":"adda"]])
    var people: [Person] = []
    
    static var alphabetDictionary:[String:[Person]] = [:]
    
    var sortedKeys : [String] = []
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
        people.append(person5)
        
        
        
        for names in people {
            if ViewController.alphabetDictionary[names.name.prefix(1).uppercased()] == nil {
                 ViewController.alphabetDictionary[names.name.prefix(1).uppercased()] = []
            }
            ViewController.alphabetDictionary[names.name.prefix(1).uppercased()]?.append(names)
            
        }
         sortedKeys = [String](ViewController.alphabetDictionary.keys).sorted(by: <)
        
        for key in sortedKeys{
           ViewController.alphabetDictionary[key] = ViewController.alphabetDictionary[key]?.sorted(by: { $0.name < $1.name})
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddButtonClicked))
        navigationItem.title = "Contacts"
     
    }
   
    @objc func AddButtonClicked (_ sender : Any) {
        let addContacts = storyboard?.instantiateViewController(withIdentifier: "AddContactViewController") as? AddContactViewController
        if addContacts != nil {
            self.navigationController?.pushViewController(addContacts!, animated: true)
        
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("I have come here after save ")
        sortedKeys = [String](ViewController.alphabetDictionary.keys).sorted(by: <)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ViewController.alphabetDictionary.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sortedKeys[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ViewController.alphabetDictionary[sortedKeys[section]]!.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell! = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier))
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        }
        
        
        cell.textLabel?.text = ViewController.alphabetDictionary[sortedKeys[indexPath.section]]![indexPath.row].name
        cell.selectionStyle = .none
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // Code for OnClick of the tableView Cell
        ViewController.selectedPerson = ViewController.alphabetDictionary[sortedKeys[indexPath.section]]![indexPath.row]
        let displayContacts = storyboard?.instantiateViewController(withIdentifier: "displayContacts") as? DisplayContacts
        if displayContacts != nil {
            self.navigationController?.pushViewController(displayContacts!, animated: true)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //names.remove(at: indexPath.row)
            ViewController.alphabetDictionary[sortedKeys[indexPath.section]]!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if(ViewController.alphabetDictionary[sortedKeys[indexPath.section]]?.count == 0)
            {
                
                ViewController.alphabetDictionary[sortedKeys[indexPath.section]] = nil
                sortedKeys.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .fade)
                
            }
        }
        
        
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedKeys
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let addContactsController =  segue.destination as! AddContactViewController
        addContactsController.sectionsInView = self.sectionsInView
    }

}


