//
//  ViewController.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import UIKit

class ViewController: UITableViewController {

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
