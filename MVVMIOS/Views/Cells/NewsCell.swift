//
//  NewsCell.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 3/1/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseId: String {
        String(describing: self)
    }
}

class NewsCell: UITableViewCell {

    fileprivate lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        addSubview(newsLabel)
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            newsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    func configurCell(withViewModel: NewsListViewModel) {
        newsLabel.text = withViewModel.newsDescription
    }
}
