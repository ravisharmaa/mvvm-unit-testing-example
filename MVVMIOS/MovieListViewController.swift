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
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()

    fileprivate lazy var testLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.addSubview(testLabel)
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 20)
        ])
    }

    func fetchData() {
        self.viewModel.resultPresentable = self
        viewModel.getDataFromApi()
    }
}

extension MovieListViewController: MovieViewModelResultPresentable {
    func setupViewState(_ with: MovieViewState) {

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch with {
            case .error(let movieErrorViewState):
                self.testLabel.textColor = .brown
                self.testLabel.text = movieErrorViewState.errorText
            case .loading(let movieLoadingViewState):
                self.testLabel.textColor = .red
                self.testLabel.text = movieLoadingViewState.loadingText
            case .loaded(let movieLoadedViewState):
                self.activitIndicator.stopAnimating()
                self.testLabel.textColor = .blue
                self.testLabel.text = movieLoadedViewState.name
            }

        }
    }

    func presentResult(_ result: Result<[MovieResult], Error>?) {
    }

}
