
import UIKit

class AddContactViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var topViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var addContactsView: UIView!
    @IBOutlet weak var addContactsTableView: UITableView!
    @IBOutlet weak var personHeightContact: NSLayoutConstraint!
    @IBOutlet weak var personHeightConstraint: UIButton!
    
    @IBOutlet weak var addButtonImageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    var flag = false
    var buttonForSectionPhone = UIButton()
    var buttonForSectionEmail = UIButton()
    var personName: String = "clk"
    var personPhone: [[String: String]] = [[:]]
    var personEmail: [[String : String]] = [[:]]
    var sectionsInView : [String] =  ["Details","Contact","Email","BirthDay"]
    var personImage: String?
    var personBirthday: String?
    
    var clickedItemIndex: IndexPath?
    var clickedItem: String?
    var addPerson: Person?
    
    var datePicker: UIDatePicker?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addContactsTableView.delegate = self
        addContactsTableView.dataSource = self
        
        addContactsTableView.register(UINib(nibName: "OptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionsTableViewCell")
        addContactsTableView.register(UINib(nibName: "PhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "PhoneTableViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(SaveButtonClicked))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        topViewHeightConstant.constant = 300
        
        for numOfSections in 0...(sectionsInView.count-1) {
            ViewController.dictionaryForSections[sectionsInView[numOfSections]] = 1
        }
        
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        datePicker?.addTarget(self, action: #selector(AddContactViewController.dateChanged(datePicker:)), for: .valueChanged)
        
    }
    
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let cell = addContactsTableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? PhoneTableViewCell
        cell?.plainText.text = dateFormatter.string(from: datePicker.date)
        personBirthday = cell?.plainText.text
        
        //view.endEditing(true)
        
        
    }
    
    @IBAction func addPhotoClicked(_ sender: Any) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            addButtonImageView.image = image
            personImage = image.toString()
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    
    func setValues ()
    {
        for numOfSection in 0...(sectionsInView.count-1) {
            for numOfRow in 0..<(ViewController.dictionaryForSections[sectionsInView[numOfSection]]!) {
                
                if numOfSection == 0 {
                    let cell = addContactsTableView.cellForRow(at: IndexPath(row: numOfRow, section: numOfSection)) as? PhoneTableViewCell
                    if (cell != nil) {
                        personName = cell!.plainText.text!
                    }
                }
                else if numOfSection == 1{
                    let cell = addContactsTableView.cellForRow(at: IndexPath(row: numOfRow, section: numOfSection)) as? OptionsTableViewCell
                    //print(cell.phoneOrEmailText.text!, "Phone value before reset")
                    
                    let key = cell?.OptionsButton.currentTitle!
                    let value = cell?.phoneOrEmailText.text
                    print("Key value before storing",key,value)
                    
                    if cell != nil {
                        
                        
                        if numOfRow < personPhone.count {
                            print("Setting value in if")
                            personPhone[numOfRow] = [key! : value!]
                        }
                        else {
                            print("Setting value in else")
                            personPhone.append([:])
                            personPhone[numOfRow] = [key! : value!]
                        }
                        
                        
                    }
                }
                else if numOfSection == 2 {
                    let cell = addContactsTableView.cellForRow(at: IndexPath(row: numOfRow, section: numOfSection)) as? OptionsTableViewCell
                    
                    let key = cell?.OptionsButton.currentTitle!
                    let value = cell?.phoneOrEmailText.text
                    
                    
                    if cell != nil {
                        
                        // if  cell!.phoneOrEmailText.text! != "enter Phone" && cell!.phoneOrEmailText.text! != "Enter Email"  {
                        if numOfRow < personEmail.count {
                            personEmail[numOfRow] = [key! : value!]
                        }
                        else {
                            personEmail.append([:])
                            personEmail[numOfRow] = [key! : value!]
                        }
                        // }
                        
                    }
                }
                else if numOfSection == 3 {
                    //            print("Row number \(numOfRow) , section number \(numOfSection)")
                    //            let cell = addContactsTableView.cellForRow(at: IndexPath(row: numOfRow, section: numOfSection)) as? PhoneTableViewCell
                    //            if (cell != nil ) {
                    //            personBirthday = (cell?.plainText.text!)!
                    //}
                }
                
            }
        }
        
        
        addPerson = Person(name: personName, phone: personPhone, company:" ", email: personEmail)
        if personImage != nil {
            addPerson?.image = personImage
            
        }
        
        if personBirthday != nil {
            addPerson?.birthDay = personBirthday
        }
        
    }
    
    
    
    @IBAction func SaveButtonClicked(_ sender:UIButton!) {
        
        
        setValues()
        
        if ViewController.alphabetDictionary[(addPerson?.name.prefix(1).uppercased())!] == nil {
            ViewController.alphabetDictionary[(addPerson?.name.prefix(1).uppercased())!] = []
        }
        print("Done")
        ViewController.alphabetDictionary[(addPerson?.name.prefix(1).uppercased())!]?.append(addPerson!)
        
        navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func buttonAction(_ sender:UIButton!) {
        
        flag = true
        //setValues()
        //addContactsTableView.reloadData()
        
        if sender.tag == 1 {
            
            //flag = true
            if ViewController.dictionaryForSections["Contact"] == nil
            {
                ViewController.dictionaryForSections["Contact"] = 1
            }
            else {
                ViewController.dictionaryForSections["Contact"]! += 1
            }
        }
        else if sender.tag == 2 {
            //flag = true
            if ViewController.dictionaryForSections["Email"] == nil {
                ViewController.dictionaryForSections["Email"] = 1
            }
            else {
                ViewController.dictionaryForSections["Email"]! += 1
            }
        }
        //print("Before Reloading")
        setValues()
        addContactsTableView.reloadData()
        print("After Reloading")
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsInView.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ViewController.dictionaryForSections[sectionsInView[section]] != nil {
            return ViewController.dictionaryForSections[sectionsInView[section]]!
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 1 || indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell" , for: indexPath) as! OptionsTableViewCell
            
            cell.phoneOrEmailText.delegate = self
            cell.newButtonDelegate = self
            cell.index = indexPath
            if flag == true { // it means its reloading
                
                print("HERE WHEN FLAG IS TRUE ", indexPath.section, indexPath.row)
                cell.phoneOrEmailText.text = getValueFromPerson(cell, indexPath)
            }
            else {
                //print("Reload flag value is \(flag) for \(indexPath.section)")
                if indexPath.section == 1 {
                    cell.OptionsButton.setTitle("Phone >", for: .normal)
                    cell.phoneOrEmailText.text = "enter Phone"
                }
                    
                else if indexPath.section == 2 {
                    cell.OptionsButton.setTitle("Email >", for: .normal)
                    cell.phoneOrEmailText.text = "enter Email"
                    
                }
                //print("have come here ")
            }
            
            
            return cell
            
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath) as! PhoneTableViewCell
            cell.plainText.delegate = self
            
            if indexPath.section == 3 {
                cell.plainText.inputView = datePicker
            }
            if flag == true {
                //print("Reload flag value is \(flag) for \(indexPath.section)")
                cell.plainText.text = getValueFromPerson(indexPath)
                //print(22)
            }
                
            else {
                //  print("Reload flag value is \(flag) for \(indexPath.section)")
                cell.plainText.text = "enter Name"
            }
            
            return cell
            
        }
        //print("default also is entered")
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Button for Contacts Adding
        buttonForSectionPhone = UIButton(type: .contactAdd)
        buttonForSectionPhone.frame = CGRect(x: 5, y: 0, width: 20, height: 30)
        buttonForSectionPhone.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonForSectionPhone.tag = 1
        
        
        //Buttons for Email Adding
        buttonForSectionEmail = UIButton(type: .contactAdd)
        buttonForSectionEmail.frame = CGRect(x: 5, y: 0, width: 20, height: 30)
        buttonForSectionEmail.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonForSectionEmail.tag = 2
        
        
        let headerView = UIView()
        //print(sectionsInView)
        
        if sectionsInView[section] != "Details" {
            let label = UILabel(frame: CGRect(x: 30, y: 0, width: 200, height: 30))
            
            label.text = sectionsInView[section]
            headerView.addSubview(label)
        }
        if sectionsInView[section] == "Contact" {
            headerView.addSubview(buttonForSectionPhone)
        }
        else if sectionsInView[section] == "Email" {
            headerView.addSubview(buttonForSectionEmail)
        }
        
        headerView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        return headerView
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let toScroll = scrollView.contentOffset.y
        if scrollView.contentOffset.y < 0 {
            // print("adadad")
            if self.topViewHeightConstant.constant < 175 {
                self.topViewHeightConstant.constant += abs(toScroll/2)
                
            }
        }
        else {
            if topViewHeightConstant.constant >= 90 && personHeightContact.constant >= 60 {
                self.topViewHeightConstant.constant -= toScroll/2
                //self.personHeightContact.constant -= toScroll/2
                //
            }
        }
    }
    
    
    func getValueFromPerson(_ indexPath: IndexPath) -> String {
        
        switch  indexPath.section {
        case 0 :
            if indexPath.row == 0 {
                return personName
            }
        case 1:
            
            if indexPath.row < (personPhone.count) {
                let cell = addContactsTableView.cellForRow(at: indexPath) as? OptionsTableViewCell
                print("Getting value in if")
                cell?.OptionsButton.setTitle([String]((personPhone[indexPath.row].keys))[0], for: .normal)
                
                return [String]((personPhone[indexPath.row].values))[0]
            }
            else {
                print("Getting value in if")
                //cell?.OptionsButton.setTitle("Phone >", for: .normal)
                return "Enter Phone"
            }
        case 2:
            
            if indexPath.row < (personEmail.count) {
                let cell = addContactsTableView.cellForRow(at: indexPath) as? OptionsTableViewCell
                cell?.OptionsButton.setTitle([String]((personEmail[indexPath.row].keys))[0], for: .normal)
                print("trying to access this email ",indexPath.row ,personEmail.count)
                return [String]((personEmail[indexPath.row].values))[0]
            }
                
            else {
                //cell?.OptionsButton.setTitle("Email >", for: .normal)
                return "Enter Email"
            }
        case 3:
            if let personBirthday = personBirthday {
                return personBirthday
            }
            else {
                return "Enter BirthDay"
            }
            
        default:
            return "Hello"
        }
        return "hello"
    }
    
    func getValueFromPerson(_ cell: OptionsTableViewCell, _ indexPath: IndexPath) -> String {
        
        switch  indexPath.section {
        case 0 :
            if indexPath.row == 0 {
                return personName
            }
        case 1:
            
            if indexPath.row < (personPhone.count) {
                //let cell = addContactsTableView.cellForRow(at: indexPath) as? OptionsTableViewCell
                print("Getting value in if")
                cell.OptionsButton.setTitle([String]((personPhone[indexPath.row].keys))[0], for: .normal)
                
                return [String]((personPhone[indexPath.row].values))[0]
            }
            else {
                print("Getting value in if")
                cell.OptionsButton.setTitle("Phone >", for: .normal)
                return "Enter Phone"
            }
        case 2:
            
            if indexPath.row < (personEmail.count) {
                //let cell = addContactsTableView.cellForRow(at: indexPath) as? OptionsTableViewCell
                cell.OptionsButton.setTitle([String]((personEmail[indexPath.row].keys))[0], for: .normal)
                print("trying to access this email ",indexPath.row ,personEmail.count)
                return [String]((personEmail[indexPath.row].values))[0]
            }
                
            else {
                cell.OptionsButton.setTitle("Email >", for: .normal)
                return "Enter Email"
            }
        case 3:
            if let personBirthday = personBirthday {
                return personBirthday
            }
            else {
                return "Enter BirthDay"
            }
            
        default:
            return "Hello"
        }
        return "hello"
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
    
    
    func getIndex(index: IndexPath) {
        
        print("in add View controller's get Index")
        clickedItemIndex = index
        
        let displayOptionsMenu = storyboard?.instantiateViewController(withIdentifier: "DisplayOptions") as? DisplayOptions
        displayOptionsMenu?.OptionsDelegateContacts = self
        displayOptionsMenu?.tableViewClass = "AddContactViewController"
        
        if displayOptionsMenu != nil {
            print("Here i am ")
            self.present(displayOptionsMenu!, animated: true, completion: nil)
            
            //
            //
        }
    }
    
    
    func clickedValue(valueName: String) {
        clickedItem = valueName
        
        print("Comming here ")
        let cell = addContactsTableView.cellForRow(at: clickedItemIndex!) as! OptionsTableViewCell
        if clickedItem != nil {
            cell.OptionsButton.setTitle(clickedItem! + " >", for: .normal)
            //tableViewPhone.reloadData()
            print("Clicked Item is \(clickedItem!)")
        }
    }
    
    
}

// Image to String
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

// String to Image
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
