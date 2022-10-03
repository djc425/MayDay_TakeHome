//
//  UserCell.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {

    //Cell Identifer
    static let identifier = "userCell"

    //Pass this infrom our Tableview delegate methods
     var userInfo: ParsedUser? {
        didSet{
            userName.text = "\(userInfo?.title ?? "title") \(userInfo?.name ?? "full name")"
            emailLabel.text = userInfo?.email
            userImage.image = userInfo?.userImageForCell
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
        setUpConstraints()
        layoutBasedOnTrait(traitCollection: UIScreen.main.traitCollection)
        self.accessoryType = .disclosureIndicator
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutBasedOnTrait(traitCollection: traitCollection)
    }

    //MARK: Cell's 3 UI properties
    private let userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 30
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = .systemMint
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()

    private let userName: UILabel = {
        let userName = UILabel()
        userName.textColor = .label
        userName.font = UIFont.preferredFont(forTextStyle: .body)
        userName.adjustsFontForContentSizeCategory = true
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()

    private let emailLabel: UILabel = {
        let email = UILabel()
        email.textColor = .secondaryLabel
        email.font = UIFont.preferredFont(forTextStyle: .footnote)
        email.adjustsFontForContentSizeCategory = true
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()


    //MARK: Configure the layout of the cell
    private func configureUI(){
        self.backgroundColor = .clear
        self.selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.1)
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(emailLabel)
    }

    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []

    private func setUpConstraints(){
        //For iPad
        regularConstraints.append(contentsOf: [
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            userImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),

            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            userName.centerXAnchor.constraint(equalTo: userImage.centerXAnchor),

            emailLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: userImage.centerXAnchor),
        ])
        // for iPhone
        compactConstraints.append(contentsOf: [
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            userImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            userImage.heightAnchor.constraint(equalTo: userImage.heightAnchor),

            userName.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 10),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 25),

            emailLabel.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func layoutBasedOnTrait(traitCollection: UITraitCollection) {

        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)

        } else if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
        }
    }
}
