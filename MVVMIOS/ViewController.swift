//
//  ViewController.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import UIKit

class ViewController: UITableViewController {

    // MARK: Views
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    let viewModel: NewsViewModel

    var dataSource: UITableViewDiffableDataSource<NewsViewModel.NewVCSection, NewsListViewModel>!

    init(_ usingViewModel: NewsViewModel) {
        self.viewModel = usingViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActivityIndicator()
        fetchDataFromViewModel()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseId)
    }

    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    func fetchDataFromViewModel() {
        viewModel.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.setupDataSource()
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func setupDataSource() {
        dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId,
                                                           for: indexPath) as? NewsCell else {
                preconditionFailure()
            }
            cell.configurCell(withViewModel: itemIdentifier)
            return cell
        })

        var snapshot: NSDiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<NewsViewModel.NewVCSection,
                                                                                    NewsListViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.newsListViewModel)
        dataSource.apply(snapshot)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
