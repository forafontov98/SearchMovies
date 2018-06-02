//
//  ViewController.swift
//  TestApp
//
//  Created by Владислав Форафонтов on 11.05.2018.
//  Copyright © 2018 Владислав Форафонтов. All rights reserved.
//

import UIKit

// controller of search screen
class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultsSegue" {
            let dvc = segue.destination as! ResultsViewController
            dvc.searchText = textField.text
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        vc.searchText = textField.text
        navigationController?.pushViewController(vc, animated: true)
        return true
    }
}
