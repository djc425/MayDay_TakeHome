//
//  ViewController.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import UIKit

class ViewController: UIViewController {

    //instance of our TableView View
    let tableView = TableView()

    // instance of our ViewModel
    var userViewModel: UserViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // set the delegate and datasource to be the ViewController
        tableView.tableView.delegate = self
        tableView.tableView.dataSource = self

        //register the custom cell which is used in an extension below
        tableView.tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)

        title = "20 Random Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //Before the view appears we'll load in our users to the ViewModel
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userViewModel.loadUsers()
    }

    init(model: UserViewModel) {
        self.userViewModel = model
        super.init(nibName: nil, bundle: nil)
        self.userViewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

// MARK: TableView Delegate and DataSource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return userViewModel.parsedUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }

        let displayedUser = userViewModel.parsedUsers[indexPath.row]
        cell.userInfo = displayedUser

        return cell
    }
}

// MARK: ViewModel Delegate methods
extension ViewController: UserViewModelDelegate {
    func updateUser() {
        DispatchQueue.main.async {
            self.tableView.tableView.reloadData()
        }
    }

    func handleError(error: UserError) {
        DispatchQueue.main.async {
            self.errorAlert(error: error.rawValue)
        }
    }

    func errorAlert(error: String) {
        let alert = UIAlertController(title: "Error has occured", message: error, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

//MARK: LoadView extension for UI
extension ViewController {
    override func loadView() {
        view = UIView()
        view.addSubview(tableView)
        view.backgroundColor = .white

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
