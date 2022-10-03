//
//  DetailViewController.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/29/22.
//

import UIKit

class DetailViewController: UIViewController {

    let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension DetailViewController {
    override func loadView() {
        view = UIView()
        view.addSubview(detailView)
        view.backgroundColor = .systemPurple

        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
