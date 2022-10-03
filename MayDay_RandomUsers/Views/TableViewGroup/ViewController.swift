//
//  ViewController.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import UIKit

class ViewController: UIViewController {

    // Instance of our TableView View
    let tableView = TableView()

    // Instance of our ViewModel
    var userViewModel: ParsedUserViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the delegate and datasource to be the ViewController
        tableView.tableView.delegate = self
        tableView.tableView.dataSource = self
        tableView.loadingSpinner.startAnimating()

        // Register the custom cell which is used in an extension below
        tableView.tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)

        // Styling the navBar
        title = "20 Random Users"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Refresh bar button to get a new set of 20 users
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshUsers))
    }

    init(model: ParsedUserViewModel) {
        self.userViewModel = model
        super.init(nibName: nil, bundle: nil)
        self.userViewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func refreshUsers(){
        userViewModel.loadUsers()
        tableView.loadingSpinner.startAnimating()
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.1
        UIView.animate( withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                cell.alpha = 1
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let userDetail = userViewModel.parsedUsers[indexPath.row]

        detailVC.detailView.detailInfo = userDetail
        detailVC.title = userDetail.name

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: ViewModel Delegate methods
extension ViewController: ParsedUserViewModelDelegate {
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.tableView.reloadData()
            self.tableView.loadingSpinner.stopAnimating()
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
        view.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 127/255, alpha: 1.0)

        //decided to put this here because originally I had it in viewWillAppear, but when I navigate back to this view I noticed it kept getting called and refreshing the table.
        userViewModel.loadUsers()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
