//
//  InfoCollectionViewCell.swift
//  WarDataset
//
//  Created by Kate on 16.07.2022.
//

import Foundation
import UIKit

final class InfoCollectionViewCell: UICollectionViewCell {
    // MARK: - Static properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.minimumScaleFactor = 0.75
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private properties

    private let cornerRadius: CGFloat = 16.0

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Private methods

    private func configureUI() {
        backgroundColor = .white

        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)

        addSubview(titleLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(Constants.edgeInset)),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.edgeInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edgeInset)),

            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.edgeInset),
            countLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.edgeInset),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edgeInset))
        ])
    }

    // MARK: - Public methods

    func configure(_ item: (String, String)) {
        titleLabel.text = item.0
        countLabel.text = item.1
    }
}

// MARK: - Layout constants

extension InfoCollectionViewCell {
    private struct Constants {
        static let edgeInset: CGFloat = 16
        static let labelHeight: CGFloat = 32
    }
}
