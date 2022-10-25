//
//  Presenter.swift
//  MVPDesignPattern
//
//  Created by Nuntapat Hirunnattee on 25/10/2565 BE.
//

import Foundation
import UIKit

protocol UserPresenterDelegate{
    func presentUser(users: [User])
    func presentAlert(title: String, message: String)
    func presentError(error: Error)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter{
    
    weak var delegate: PresenterDelegate?
    private let url = "https://jsonplaceholder.typicode.com/users"
    
    func setupViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
    func getUsers(){
        APIService.shared.fatchData(urlString: url) { [weak self] result in
            switch result{
            case .success(let users):
                self?.delegate?.presentUser(users: users)
            case .failure(let error):
                print("\(error) : \(error.localizedDescription)")
                self?.delegate?.presentError(error: error)
            }
        }
    }
    
    func didTapUser(user: User){
        delegate?.presentAlert(title: user.name, message: "\(user.name) has an email of \(user.email) & a username of \(user.username).")
    }
}
