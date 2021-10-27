//
//  CategoriesPresenter.swift
//  ChuckNorrisJokes
//
//  Created Vladislav on 4.10.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol CategoriesPresenterProtocol {
	var view: CategoriesViewProtocol? { get set }
    func viewDidLoad()
    func category(for indexPath: IndexPath) -> String?
    func numberOfCategories() -> Int
}

class CategoriesPresenter: CategoriesPresenterProtocol {

    weak var view: CategoriesViewProtocol?

    private var categories: [String] = []
    
    func viewDidLoad() {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/categories") else {
            return
        }
        let request = URLRequest(
            url: url
        )
        
        URLSession.shared.dataTask(
            with: request
        ) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let categories = try? decoder.decode([String].self, from: data)
            self.categories = categories ?? []
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }.resume()
    }
    
    func category(for indexPath: IndexPath) -> String? {
        return categories[indexPath.row]
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
}
