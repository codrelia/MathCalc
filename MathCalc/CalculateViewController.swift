//
//  CalculateViewController.swift
//  MathCalc
//
//  Created by Дарья Шевченко on 28.02.2022.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var labelForHeader = UILabel()
    var arrayOfButtonsOfSubjects = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTheLargeTitleCalculate()
        buttonForSubjects()
    
    }
    
    func editTheLargeTitleCalculate() {
        navigationItem.title = "Calculator"
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    func buttonForSubjects() {
        let button = UIButton(frame: CGRect(x: view.center.x, y: 200, width: 200, height: 75))
        button.titleLabel?.text = "Discrete mathematics"
        button.titleLabel?.textColor = .white
        
        view.addSubview(button)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
