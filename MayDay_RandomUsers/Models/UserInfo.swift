//
//  UserInfo.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation

//Main object which we'll use to pull data in from the network call
struct UserInfo: Codable {
    var results: [Results]
}

//Results object which has the following properties
struct Results: Codable {
    var gender: String
    var name: UserName
    var email: String
    var picture: UserPictures
}

//Unpacking the name properties
struct UserName: Codable {
    var title: String
    var first: String
    var last: String
}

//Unpacking the image properties
struct UserPictures: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}


