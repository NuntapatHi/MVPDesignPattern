//
//  ViewController.swift
//  MVPDesignPattern
//
//  Created by Nuntapat Hirunnattee on 25/10/2565 BE.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    
    private let presenter = UserPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Users"
        
        tableView.delegate = self
        tableView.dataSource = self
        presenter.setupViewDelegate(delegate: self)
        presenter.getUsers()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapUser(user: users[indexPath.row])
    }
}

extension UserViewController: UserPresenterDelegate{
    func presentError(error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "\(error)", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alert, animated: true)
        }
        
    }
    
    func presentUser(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}
