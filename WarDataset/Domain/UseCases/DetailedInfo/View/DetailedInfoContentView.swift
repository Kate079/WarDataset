//
//  DetailedInfoContentView.swift
//  WarDataset
//
//  Created by Kate on 23.07.2022.
//

import Foundation
import UIKit

final class DetailedInfoContentView: UIView {
    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 8.0
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.masksToBounds = false
        imageView.layer.shadowRadius = 8.0
        imageView.layer.shadowOpacity = 0.1
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Private properties

    private let cornerRadius: CGFloat = 16.0
    private var viewModel: DetailedInfo.LoadData.ViewModel?
    
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
        backgroundColor = .systemGray6

        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(countLabel)
        backgroundView.addSubview(imageView)

        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.edgeInset),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edgeInset)),

            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: Constants.edgeInset),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constants.edgeInset),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(Constants.edgeInset)),

            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.edgeInset),
            countLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constants.edgeInset),
            countLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(Constants.edgeInset)),

            imageView.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: Constants.edgeInset),
            imageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -(Constants.edgeInset)),
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constants.edgeInset),
            imageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(Constants.edgeInset))
        ])
    }

    // MARK: - Public methods

    func displayDetailedData(viewModel: DetailedInfo.LoadData.ViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.selectedItem.0
        countLabel.text = "Total: \(viewModel.selectedItem.1)"
        imageView.image = UIImage(named: viewModel.imageName)
    }
}

// MARK: - Layout constants

extension DetailedInfoContentView {
    private struct Constants {
        static let edgeInset: CGFloat = 16
    }
}
