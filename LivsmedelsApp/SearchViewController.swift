//
//  ViewController.swift
//  LivsmedelsApp
//
//  Created by Hristijan Bocevski on 2017-02-22.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewController = segue.destination as! TableViewController
        
        tableViewController.searchWord = searchField.text!
    }

    @IBAction func search(_ sender: Any) {
        NSLog("Searching")
    }
}

