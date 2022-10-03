//
//  NetworkManager.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation
import UIKit

typealias UserResult = Result<UserInfo, UserError>

protocol NetworkManagerProtocol {
    func fetchUsers(completion: @escaping (UserResult) -> Void)
    func parseUsers(from user: UserInfo) -> [ParsedUser]
}


enum UserError: String, Error {
    case invalidURL =  "URL not valid"
    case unableToComplete = "unable to complete request, please check internet connection"
    case noData = "Unable to get data"
    case unableToParse = "Unable to translate data"
}


class NetworkManager {
    let randomUserURL = "https://randomuser.me/api/?results=20"

    func fetchUsers(completion: @escaping (UserResult) -> Void) {
        guard let url = URL(string: randomUserURL) else {
            completion(.failure(.invalidURL))
            return
        }

        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, _, error in
            if error != nil {
                completion(.failure(.unableToComplete))
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let userData = try jsonDecoder.decode(UserInfo.self, from: data)
                dump(userData)
                completion(.success(userData))
            } catch {
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
    }

    func parseUsers(from user: UserInfo) -> [ParsedUser] {
        var allUsers = [ParsedUser]()

        for user in user.results {
            let userName = "\(user.name.title) \(user.name.first) \(user.name.last)"
            let userEmail = user.email
            let userImageMedium = createImage(from: user.picture.medium)
            let userImageLarge = createImage(from: user.picture.large)
            let userAddress = "\(user.location.street.number) \(user.location.street.name)\n\(user.location.city), \(user.location.state)\n\(user.location.country)"

            let newUser = ParsedUser(name: userName, email: userEmail, userImageForCell: userImageMedium, largeImage: userImageLarge, streetAddress: userAddress)

            allUsers.append(newUser)
        }
        return allUsers
    }

    func createImage(from: String) -> UIImage {
        
        let image = UIImage()

            if let url = URL(string: from) {

                if let data = try? Data(contentsOf: url) {
                    guard let image = UIImage(data: data) else {
                        return UIImage(systemName: "person")!
                    }
                    return image
                } else {
                    return UIImage(systemName: "person")!
                }
            }
        return image
    }
}

