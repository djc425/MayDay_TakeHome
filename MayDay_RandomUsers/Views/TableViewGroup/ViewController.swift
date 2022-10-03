//
//  ViewController.swift
//  MayDay_RandomUsers
//
//  Created by David Chester on 9/28/22.
//

import UIKit

class ViewController: UIViewController {

    // Instance of our TableView View
    let tableViewLayout = TableView()

    // Instance of our ViewModel
    var userViewModel: ParsedUserViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the delegate and datasource to be the ViewController
        tableViewLayout.tableView.delegate = self
        tableViewLayout.tableView.dataSource = self
        tableViewLayout.loadingSpinner.startAnimating()

        // Register the custom cell which is used in an extension below
        tableViewLayout.tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)

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
        tableViewLayout.loadingSpinner.startAnimating()
    }

    // An alert which we'll use to display errors to the user based on where the error occured
    func errorAlert(error: String) {
        let alert = UIAlertController(title: "Error has occured", message: error, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

// MARK: TableView Delegate and DataSource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // Number of rows within the single section will be based on the 20 users that are returned, but in case we get more we'll return the full count of the parsedUsers array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return userViewModel.parsedUsers.count
    }

    // Instantiating our custom UserCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        // Pulling out a single user from the parsedUsers array based on the row selected and setting that to our userInfo property on the cell which will populate the cell's properties
        let displayedUser = userViewModel.parsedUsers[indexPath.row]
        cell.userInfo = displayedUser

        return cell
    }

    // Fade in animation to be called on each cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.1
        UIView.animate( withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                cell.alpha = 1
        })
    }

    // Setting the row height based on device
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            return view.frame.height * 0.2
        } else {
            return view.frame.height * 0.1
        }
    }

    // When a user selects a row we send that row's info to populate the UI on the DetailViewController by populate our detailInfo properties
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
    // Our ViewModel Delegate methods are called here, first we reload the table view and then stop the loading spinner animating.
    func updateTable() {
        DispatchQueue.main.async {
            self.tableViewLayout.tableView.reloadData()
            self.tableViewLayout.loadingSpinner.stopAnimating()
        }
    }
    // Passing any errors returned from the ViewModel to our errorAlert method
    func handleError(error: UserError) {
        DispatchQueue.main.async {
            self.errorAlert(error: error.rawValue)
        }
    }
}

//MARK: LoadView extension for UI
extension ViewController {
    override func loadView() {
        view = UIView()
        view.addSubview(tableViewLayout)
        view.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 127/255, alpha: 1.0)

        //decided to put this here because originally I had it in viewWillAppear, but when I navigate back to this view I noticed it kept getting called and refreshing the table.
        userViewModel.loadUsers()

        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            // If the device being used is an iPad we'll narrow the width of the tableViewLayout View
            NSLayoutConstraint.activate([
                tableViewLayout.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
                tableViewLayout.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
                tableViewLayout.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                tableViewLayout.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            ])
        } else {
            // If the device is an iPhone we'll use the full width of the layoutMargins
            NSLayoutConstraint.activate([
                tableViewLayout.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
                tableViewLayout.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                tableViewLayout.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                tableViewLayout.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            ])
        }
    }
}
