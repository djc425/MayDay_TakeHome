//
//  TableView.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation
import UIKit

class TableView: UIView {

    var tableView: UITableView = {
        let tbView = UITableView()
        tbView.allowsSelection = true
        tbView.backgroundColor = .white
        tbView.separatorStyle = .singleLine

        tbView.translatesAutoresizingMaskIntoConstraints = false
        return tbView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
    }


}
