//
//  NetworkManager.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import Foundation
import UIKit

// TypeAlias which we'll use in the NetworManager methods and Protocol
typealias UserResult = Result<UserInfo, UserError>

// NetworkManager Protocol which we'll initialize the ViewModel with.
protocol NetworkManagerProtocol {
    func fetchUsers(completion: @escaping (UserResult) -> ())
    func parseUsers(from user: UserInfo) -> [ParsedUser]
}

// Enum to handle erros based 4 different points of failure
enum UserError: String, Error {
    case invalidURL =  "URL not valid"
    case unableToComplete = "unable to complete request, please check internet connection"
    case noData = "Unable to get data"
    case unableToParse = "Unable to translate data"
}

// NetworkManager class
class NetworkManager {
    // URL that will return 20 users from randomUser.me
    let randomUserURL = "https://randomuser.me/api/?results=20"

    // Method that will be called in the ViewModel to fetch the users
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

    // Method where we parse users from the UserInfo object into a ParsedUser which will later be used to populate the UI
    func parseUsers(from user: UserInfo) -> [ParsedUser] {
        var allUsers = [ParsedUser]()

        // Go through the Results array from our UserInfo object and save the properties into that of a Parse User
        for user in user.results {
            let userTitle = user.name.title
            let userName = "\(user.name.first) \(user.name.last)"
            let userEmail = user.email
            let userImageMedium = createImage(from: user.picture.medium)
            let userImageLarge = createImage(from: user.picture.large)
            let userAddress = "\(user.location.street.number) \(user.location.street.name)\n\(user.location.city), \(user.location.state)\n\(user.location.country)"

            // Create a new ParsedUser object to be appended into our array
            let newUser = ParsedUser(title: userTitle, name: userName, email: userEmail, userImageForCell: userImageMedium, largeImage: userImageLarge, streetAddress: userAddress)

            allUsers.append(newUser)
        }
        return allUsers
    }

   private func createImage(from: String) -> UIImage? {
        let image = UIImage()

            if let url = URL(string: from) {
                if let data = try? Data(contentsOf: url) {
                    guard let image = UIImage(data: data) else {
                        return UIImage(systemName: "person")
                    }
                    return image
                } else {
                    return UIImage(systemName: "person")
                }
            }
        return image
    }
}

