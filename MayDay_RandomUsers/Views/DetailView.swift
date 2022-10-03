//
//  DetailView.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/29/22.
//

import Foundation
import UIKit

class DetailView: UIView {

    var detailInfo: ParsedUser? {
        didSet {
            heroImage.image = detailInfo?.largeImage
            nameLabel.text = detailInfo?.name
            address.text = detailInfo?.streetAddress
            emailAddress.text = detailInfo?.email
        }
    }


    let heroImage: UIImageView = {
        let heroImage = UIImageView()
        heroImage.contentMode = .scaleAspectFit
        heroImage.layer.cornerRadius = 40
        heroImage.layer.masksToBounds = true

        heroImage.translatesAutoresizingMaskIntoConstraints = false
        return heroImage
    }()

    let nameLabel: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.textColor = .label
        name.font = UIFont.preferredFont(forTextStyle: .title1)

        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    let address: UILabel = {
        let address = UILabel()
        address.textAlignment = .left
        address.textColor = .secondaryLabel
        address.font = UIFont.preferredFont(forTextStyle: .title2)
        address.numberOfLines = 3

        address.translatesAutoresizingMaskIntoConstraints = false
        return address
    }()

    let emailAddress: UILabel = {
        let email = UILabel()
        email.textAlignment = .left
        email.textColor = .secondaryLabel
        email.font = UIFont.preferredFont(forTextStyle: .title3)
        email.isUserInteractionEnabled = true
        email.textColor = .systemBlue
        

        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureDetails()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureDetails(){
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(heroImage)
        self.addSubview(nameLabel)
        self.addSubview(address)

        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            NSLayoutConstraint.activate([
                // iPhone constraints
                heroImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                heroImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                heroImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
                heroImage.widthAnchor.constraint(equalTo: heroImage.heightAnchor),

                nameLabel.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 20),
                nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),

                address.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                address.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
            ])
            // iPad Constraints
        } else if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            nameLabel.textAlignment = .center
            address.textAlignment = .center
            self.addSubview(emailAddress)

            NSLayoutConstraint.activate([
                heroImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),

                heroImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                heroImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
                heroImage.widthAnchor.constraint(equalTo: heroImage.heightAnchor),

                nameLabel.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 20),
                nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

                address.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                address.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),

                emailAddress.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 20),
                emailAddress.centerXAnchor.constraint(equalTo: address.centerXAnchor),
            ])

        }
    }
}
