

import UIKit

class tableViewCellForPhone: UITableViewCell, UITextFieldDelegate{

   
    @IBOutlet weak var addContactCell: tableViewCellForPhone!
    
  
    @IBOutlet weak var text1: UITextField!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //text1.delegate = self
        //addContactsCell.addSubview(text1)
        didTransition(to: .showingEditControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didTransition(to state: UITableViewCell.StateMask) {
        text1.isEnabled = true
        super.didTransition(to: state)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    
  
        
        
    
    
}
