//
//  UserCell.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation
import UIKit

protocol UserCellDelegate: AnyObject {

}

class UserCell: UITableViewCell {

    //Cell Identifer
    static let identifier = "userCell"

    weak var delegate: UserCellDelegate?

    //Pass this infrom our Tableview delegate methods
     var userInfo: ParsedUser? {
        didSet{
            userName.text = userInfo?.name
            emailLabel.text = userInfo?.email
            userImage.image = userInfo?.thumbnailImage
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
        self.accessoryType = .disclosureIndicator
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Cell's 3 UI properties
    private let userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.contentMode = .scaleAspectFit
        userImage.layer.cornerRadius = 35
        userImage.layer.masksToBounds = true
       // userImage.clipsToBounds = true
        userImage.frame.size.width = 50
        userImage.frame.size.height = 50

        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()

    private let userName: UILabel = {
        let userName = UILabel()
        userName.textColor = .label
        userName.font = UIFont.preferredFont(forTextStyle: .body)

        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()

    private let emailLabel: UILabel = {
        let email = UILabel()
        email.textColor = .secondaryLabel
        email.font = UIFont.preferredFont(forTextStyle: .caption1)

        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()


    //MARK: Configure the layout of the cell
    private func configureLayout(){
        self.backgroundColor = .clear
        self.selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.1)
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
       // self.frame.size.height = 120
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(emailLabel)

        NSLayoutConstraint.activate([

            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            userImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
         //   userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),

            userName.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 10),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 25),

            emailLabel.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

    }
}
