//
//  UserViewModel.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation

protocol UserViewModelDelegate: AnyObject {
    func updateUser()

    func handleError(error: UserError)
}


class UserViewModel {

    var networkManager: NetworkManager

    var parsedUsers = [ParsedUser]()

    init(networkManager: NetworkManager){
        self.networkManager = networkManager
    }

    weak var delegate: UserViewModelDelegate?


    func loadUsers(){
        networkManager.fetchUsers { result in

            switch result {
            case .failure(let error):
                self.delegate?.handleError(error: error)
            case.success(let user):
                self.parsedUsers = self.networkManager.parseUsers(from: user)
                self.delegate?.updateUser()
            }
        }
    }


}
