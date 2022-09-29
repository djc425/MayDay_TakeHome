//
//  UserInfo.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation

struct UserInfo: Codable {
    var results: [Results]
}

struct Results: Codable {
    var gender: String
    var name: UserName
    var email: String
    var picture: UserPictures
}

struct UserName: Codable {
    var title: String
    var first: String
    var last: String
}

struct UserPictures: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}


