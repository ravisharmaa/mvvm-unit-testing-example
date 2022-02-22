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
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    let viewModel: UserViewModel

    init(withVM: UserViewModel) {
        self.viewModel = withVM
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        fetchDataFromViewModel()

    }

    func setupActivityIndicator() {

    }

    func fetchDataFromViewModel() {
        guard let url = URL(string: "https://google.com") else { return }
        viewModel.fetchFromNetwork(from: url)
        viewModel.fetchCompleted = { _, errorText in
            print(errorText)
        }
    }
}

extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
    }
}
