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
        let emailTapGesture = UITapGestureRecognizer(target: self, action: #selector(emailTap(_:)))
        detailView.emailAddress.addGestureRecognizer(emailTapGesture)
    }


    @objc func emailTap(_ sender: UITapGestureRecognizer){
        let emailAlert = UIAlertController(title: "Send Email", message: "Would you like to send an email to \(detailView.emailAddress.text ?? "this user")?", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(emailAlert, animated: true)
    }
}


extension DetailViewController {
    override func loadView() {
        view = UIView()
        view.addSubview(detailView)


        view.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 127/255, alpha: 1.0)

        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
