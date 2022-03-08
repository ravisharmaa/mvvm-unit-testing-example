//
//  MovieListViewController.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 3/6/22.
//

import Foundation
import UIKit

class MovieListViewController: UITableViewController {

    fileprivate lazy var activitIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()

    let viewModel: MovieViewModel

    init(_ viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }

    func setupView() {
        view.addSubview(activitIndicator)
        NSLayoutConstraint.activate([
            activitIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activitIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    func fetchData() {
        self.viewModel.resultPresentable = self
        viewModel.fetchDataFromApi()
    }
}

extension MovieListViewController: MovieViewModelResultPresentable {
    func setupViewState(_ with: MovieViewState) {

    }

    func presentResult(_ result: Result<[MovieResult], Error>?) {

        DispatchQueue.main.async { [weak self] in
            if let result = result {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let result):
                    DispatchQueue.main.async { [weak self] in
                        self?.activitIndicator.stopAnimating()
                        print(result)
                    }
                }
            }
        }
    }

}
