//
//  DetailViewController.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/29/22.
//

import UIKit

class DetailViewController: UIViewController {

    let detailView = DetailView()

    let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]


    override func viewDidLoad() {
        super.viewDidLoad()


      //  navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Test"
        view.backgroundColor = .systemTeal
        // Do any additional setup after loading the view.
    }

    

}
