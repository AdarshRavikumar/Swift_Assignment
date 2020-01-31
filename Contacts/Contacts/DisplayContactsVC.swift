

import UIKit



class DisplayContacts: UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextFieldDelegate, Selection, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var tableViewPhone: UITableView!
    
    @IBOutlet weak var personHeightContact: NSLayoutConstraint!
    
    @IBOutlet weak var topViewHeightConstant: NSLayoutConstraint!

    @IBOutlet weak var changePictureImageView: UIImageView!
    
    @IBOutlet weak var changePicButton: UIButton!
    
    var sectionsInView = ["Details","Contact","Email","BirthDay"]
    var flag = false
    var toggleFlag = false
    var check = false
    var counter = 1
    var clickedItem: String?
    var clickedItemIndex: IndexPath?
    let addPhoneButton = UIButton(type: .contactAdd)
    let labelforSection = UILabel(frame: CGRect(x: 0, y:0, width: 150, height: 100))
    
    let imagePicker = UIImagePickerController()
    let cellReuseIdentifier = "PhoneTableViewCell"
    var buttonForSectionPhone = UIButton()
    var buttonForSectionEmail = UIButton()
    
    var lastContentOffset: CGFloat = 0.0
    let maxHeaderHeight: CGFloat = 80
    

    // View DidLoad
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableViewHeightConstant.constant = 500
        topViewHeightConstant.constant = 300
        
        tableViewPhone.delegate = self
        tableViewPhone.dataSource = self
        self.tableViewPhone.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.tableViewPhone.register(UINib(nibName: "OptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionsTableViewCell")
        addPhoneButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        tableViewPhone.separatorStyle = .none
         let person = ViewController.selectedPerson
        
        
        toggleFlag = false
        flag = false
        ViewController.dictionaryForSections["Details"] = 3

        ViewController.dictionaryForSections["Contact"] = ViewController.selectedPerson.phone.count
       // print("Initial Length of Phone ",ViewController.selectedPerson.phone.count)

        ViewController.dictionaryForSections["Email"] = ViewController.selectedPerson.email.count
        
        //print("Initial Length of Email ",ViewController.selectedPerson.email.count)
        ViewController.dictionaryForSections["BirthDay"] = 1
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonClicked))
        navigationItem.title = " Details "
        
        if ViewController.selectedPerson.image != nil {
            changePictureImageView.image = ViewController.selectedPerson.image?.toImage()
        }
    }
    
    
    
    
    //Edit Button in Navigation Bar Clicked
    @IBAction func editButtonClicked(_ sender: Any) {
        
        toggleFlag = true
        flag = !flag
        print("here ",flag)
       
        buttonForSectionEmail.isEnabled = true
        buttonForSectionPhone.isEnabled = true
        
        
        
        if flag == false{
            
            // before it is Edit
            setValueAfterEditing()
            navigationItem.rightBarButtonItem?.title = "Edit"
        }
        else {
            // before it is Save
            navigationItem.rightBarButtonItem?.title = "Save"
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        
        tableViewPhone.reloadData()
        print("Hello YOYO \(flag)")
        
    }
    

    
    
    // "+" button on contats and email clicked
    @IBAction func buttonAction(_ sender:UIButton!) {
        

        
        if sender.tag == 1 {
            //print("Adding to phone len ")
            ViewController.dictionaryForSections["Contact"]! += 1
        }
        else if sender.tag == 2 {
//            print("Adding to email len")
            ViewController.dictionaryForSections["Email"]! += 1
        }
        setValueAfterEditing()
        tableViewPhone.reloadData()
       // print("came here inside")
  
}
    
    
    
    
   // TableView Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsInView.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.dictionaryForSections[sectionsInView[section]]!
    }
    
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sectionsInView[section]
    //    }
    
    
    // Adding Section Headers
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
        
        if sectionsInView[section] != "Details" {
            let label = UILabel(frame: CGRect(x: 30, y: 0, width: 200, height: 30))
            
            label.text = sectionsInView[section]
            label.textColor = .black
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
    
    
    // Adding Cells to tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if sectionsInView[indexPath.section] == "Contact" || sectionsInView[indexPath.section] == "Email" {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell" ) as! OptionsTableViewCell
            
         
//            cell.OptionsButton.addTarget(self, action: #selector(displayOptions), for: .touchUpInside)
//
            if toggleFlag == true && flag == false{
              setValueAfterEditing()
                print("set value sec \(indexPath.section)")
            }
            
            //print("get value sec \(indexPath.section)")
            cell.phoneOrEmailText.text = getValueFromPerson(_cell: cell,indexPath)
            
            cell.buttonDelegate = self
            cell.index = indexPath
           
            //cell.phoneOrEmailText.delegate = self
            //print("came here ")
            return cell
            
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath) as? PhoneTableViewCell {
                if toggleFlag == false {
                    cell.plainText.isEnabled = false
                }
                else {
                    cell.plainText.isEnabled = true
                }
                
                if toggleFlag == true && flag == false{
                    
                 // print("Entering here for normal cell with both true")
                  setValueAfterEditing()
                    //print("set value for sec \(indexPath.section)")
                   
                  
                }
                
                //print("get value for \(indexPath.section)")
                
                //print("Toggle flag and Flag ", toggleFlag, flag)
                cell.plainText.text = getValueFromPerson(indexPath)
                
                cell.plainText.delegate = self
                //print("Came here")
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
    
    

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 && indexPath.row == 0 {
//            return 220
//        }
        
        return 45
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let toScroll = scrollView.contentOffset.y
           if scrollView.contentOffset.y < 0 {
             // print("adadad")
             if self.topViewHeightConstant.constant < 241 {
               self.topViewHeightConstant.constant += abs(toScroll/2)
               //if abs(toScroll) > 1 {
                 //ButtonInStaticView.alpha += abs(1/toScroll)
               //}
             }
           }
           else {
             if topViewHeightConstant.constant >= 90 && personHeightContact.constant >= 60 {
               self.topViewHeightConstant.constant -= toScroll/2
//               if toScroll > 1 {
//                 ButtonInStaticView.alpha -= 1/toScroll
//               }
             }
           }
    }
        

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ViewController.dictionaryForSections[sectionsInView[indexPath.section]]! -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            switch indexPath.section {
            case 0:
                if indexPath.row == 1 {
                    ViewController.selectedPerson.name = ""
                }
            case 1 :
                ViewController.selectedPerson.phone.remove(at: indexPath.row)
            case 2 :
                ViewController.selectedPerson.email.remove(at: indexPath.row)
            default:
                print("Nothing Deleted")
        }
    }
    }
    
    
    func getValueFromPerson(_ indexPath: IndexPath) -> String {
        switch  indexPath.section {
        case 0 :
            if indexPath.row == 1 {
                return ViewController.selectedPerson.name
            }
            else {
                return "Enter Name"
            }
        case 3:
            if ViewController.selectedPerson.birthDay != nil {
                print("yes i have a Birthday")
            return ViewController.selectedPerson.birthDay!
            }
            else {
                return "Enter BirthDay"
            }
        default:
            return "Hello"
        }
    }
    
    
    func getValueFromPerson(_cell: OptionsTableViewCell, _ indexPath: IndexPath) -> String {
        
        switch  indexPath.section {
        case 1:
            //print("len of phone array " ,ViewController.selectedPerson.phone.count)
            if indexPath.row < ViewController.selectedPerson.phone.count {
        print("Getting value from if")
                _cell.OptionsButton.setTitle([String](ViewController.selectedPerson.phone[indexPath.row].keys)[0], for: .normal)
                return [String](ViewController.selectedPerson.phone[indexPath.row].values)[0]
            }
            else {
                print("Getting value from else")
                _cell.OptionsButton.setTitle("Phone >", for: .normal)
                return "Enter Phone"
            }
            
        case 2:
            //print("len of email array ",ViewController.selectedPerson.email.count)
            if indexPath.row < ViewController.selectedPerson.email.count {
                _cell.OptionsButton.setTitle([String](ViewController.selectedPerson.email[indexPath.row].keys)[0], for: .normal)
                return [String](ViewController.selectedPerson.email[indexPath.row].values)[0]
            }
             else {
                _cell.OptionsButton.setTitle("Email >", for: .normal)
                 return "Enter Email"
             }
        
        default:
            return "Hello"
        }
    }
    
    
    

    
    
        
        func setValueAfterEditing() {
        
            for numOfSection in 1...(sectionsInView.count-1) {
                for numOfRow in 0..<(ViewController.dictionaryForSections[sectionsInView[numOfSection]]!) {
                    
                     if numOfSection == 1{
                        let cell = tableViewPhone.cellForRow(at: IndexPath(row: numOfRow, section: numOfSection)) as? OptionsTableViewCell
                        //print(cell.phoneOrEmailText.text!, "Phone value before reset")
                       
                        let key = cell?.OptionsButton.currentTitle!
                        let value = cell?.phoneOrEmailText.text
                        
                        
                        if cell != nil {
                            
                            if  cell!.phoneOrEmailText.text! != "enter" && cell!.phoneOrEmailText.text! != "Enter Phone"  {
                                if numOfRow < ViewController.selectedPerson.phone.count {
                                    print("Setting value from if")
                                    ViewController.selectedPerson.phone[numOfRow] = [key! : value!]
                                }
                                    
                                else {
                                    print("Setting value from else")
                                ViewController.selectedPerson.phone.append([:])
                                    ViewController.selectedPerson.phone[numOfRow] = [key! : value!]
                            }
                            }
                            
                    }
                    }
                    else if numOfSection == 2 {
                        let cell = tableViewPhone.cellForRow(at: IndexPath(row: numOfRow, section: numOfSection)) as? OptionsTableViewCell
                        
                        let key = cell?.OptionsButton.currentTitle!
                        let value = cell?.phoneOrEmailText.text
                                   
                                   
                       if cell != nil {
                           
                           if  cell!.phoneOrEmailText.text! != "enter" && cell!.phoneOrEmailText.text! != "Enter Email"  {
                               if numOfRow < ViewController.selectedPerson.email.count {
                                  ViewController.selectedPerson.email[numOfRow] = [key! : value!]
                               }
                               else {
                               ViewController.selectedPerson.email.append([:])
                                   ViewController.selectedPerson.email[numOfRow] = [key! : value!]
                           }
                           }
                           
                   }
                    }
                    else if numOfSection == 3 {
                        print("Row number \(numOfRow) , section number \(numOfSection)")
                        let cell = tableViewPhone.cellForRow(at: IndexPath(row: numOfRow, section: numOfSection)) as? PhoneTableViewCell
                        print("Cell here is nil ", cell == nil)
                        if (cell != nil ) {
                            print("Setting here", cell?.plainText.text!)
                            ViewController.selectedPerson.birthDay = (cell?.plainText.text!)!
                    }
                }

            }
                    }

            

            }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickedItemIndex = indexPath
        print(clickedItemIndex?.section, clickedItemIndex?.row)
        
        if ((tableView.cellForRow(at: indexPath) as? OptionsTableViewCell) != nil) {
         let displayOptionsMenu = storyboard?.instantiateViewController(withIdentifier: "DisplayOptions") as? DisplayOptions
         displayOptionsMenu!.OptionsDelegate = self
             
         if displayOptionsMenu != nil {
          self.present(displayOptionsMenu!, animated: true, completion: nil)
         getIndex(index: clickedItemIndex!)
            /** Commented for checking */
            //tableViewPhone.reloadData()
    }
        }
        
    
    }
    
    
    func clickedValue(valueName: String) {
        clickedItem = valueName
        
        let cell = tableViewPhone.cellForRow(at: clickedItemIndex!) as! OptionsTableViewCell
               if clickedItem != nil {
                cell.OptionsButton.setTitle(clickedItem! + " >", for: .normal)
                //tableViewPhone.reloadData()
        print("Clicked Item is \(clickedItem!)")
    }
    }
    
    
    
    func getIndex(index: IndexPath) {
        clickedItemIndex = index
        
        let displayOptionsMenu = storyboard?.instantiateViewController(withIdentifier: "DisplayOptions") as? DisplayOptions
        displayOptionsMenu!.OptionsDelegate = self
        displayOptionsMenu?.tableViewClass = "DisplayContacts"
            
        if displayOptionsMenu != nil {
         self.present(displayOptionsMenu!, animated: true, completion: nil)
            
//
//
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let index = IndexPath(row: 1, section: 0)
        let nameCell = tableViewPhone.cellForRow(at: index) as? PhoneTableViewCell
        
        if let nameCell = nameCell {
            if textField == nameCell.plainText! {
                ViewController.selectedPerson.name = textField.text!
                //print(textField.text!)

            }
        }
            }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
             if indexPath == lastVisibleIndexPath {
                if check == true {
                    flag = true
                    check = false
                }
             }
         }
     }

    
    @IBAction func changePicButtonClicked(_ sender: Any) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            changePictureImageView.image = image
            ViewController.selectedPerson.image = image.toString()
            
        }
        
        dismiss(animated: true, completion: nil)
    
    }
    
}

