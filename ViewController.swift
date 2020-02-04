//
//  ViewController.swift
//  Demo
//
//  Created by Brijesh Kumar on 27/11/19.
//  Copyright © 2019 Brijesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Mark {
        var mark:Int
        init(mark:Int) {
            self.mark = mark
        }
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        let reslt = Mark(mark: 12)
        print(reslt.mark)
        // Do any additional setup after loading the view.
    }


}

