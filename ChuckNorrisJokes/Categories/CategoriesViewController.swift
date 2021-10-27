//
//  CategoriesViewController.swift
//  ChuckNorrisJokes
//
//  Created Vladislav on 4.10.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol CategoriesViewProtocol: AnyObject {
    func reloadData()
}

class CategoriesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
	var presenter: CategoriesPresenterProtocol = CategoriesPresenter()

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.category(for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let jokeVC = UIStoryboard(name: "Joke", bundle: Bundle.main).instantiateViewController(withIdentifier: "JokeViewController") as? JokeViewController else {
            return
        }
        jokeVC.presenter = JokePresenter(
            category: presenter.category(for: indexPath) ?? ""
        )
        navigationController?.pushViewController(jokeVC, animated: true)
    }
}

extension CategoriesViewController: CategoriesViewProtocol {
    func reloadData() {
        activityIndicator.isHidden = true
        tableView.reloadData()
    }
}
