
import UIKit

class ViewController: UIViewController {
    
    var labelForHeader = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTheLargeTitleMainPage()
    }
    
    func editTheLargeTitleMainPage() {
        navigationItem.title = "Informative articles"
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    
}

