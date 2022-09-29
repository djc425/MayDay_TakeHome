//
//  TableView.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation
import UIKit

class TableView: UIView {

    let loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.color = UIColor.systemTeal
        spinner.hidesWhenStopped = true
        spinner.layer.zPosition = 1
        spinner.translatesAutoresizingMaskIntoConstraints = false

        return spinner
    }()

    //TableView which we'll make the entire size of this UIView
    let tableView: UITableView = {
        let tbView = UITableView()
        tbView.allowsSelection = true
        tbView.backgroundColor = .clear
        tbView.separatorStyle = .singleLine
        tbView.showsVerticalScrollIndicator = false

        tbView.translatesAutoresizingMaskIntoConstraints = false
        return tbView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView(){
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        self.addSubview(loadingSpinner)
        self.layer.cornerRadius = 35
        self.layer.masksToBounds = true

        NSLayoutConstraint.activate([

            loadingSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
    }
}
