//
//  CollectionViewHeader.swift
//  WarDataset
//
//  Created by Kate on 19.07.2022.
//

import Foundation
import UIKit

final class CollectionViewHeader: UICollectionReusableView {
    // MARK: - Static properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private properties

    private var title: String?

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
        backgroundColor = .clear
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Public methods

    func configure(with title: String) {
        titleLabel.text = title
    }
}
