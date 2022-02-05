//
//  ViewController.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import UIKit

class ViewController: UITableViewController {

    fileprivate lazy var viewModel: UserViewModel = {
        let viewModel = UserViewModel()
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchFromNetwork()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
    }

}
