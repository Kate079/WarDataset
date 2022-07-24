//
//  DateCell.swift
//  WarDataset
//
//  Created by Kate on 20.07.2022.
//

import Foundation
import UIKit

final class DateCell: UICollectionViewCell {
    // MARK: - Static properties

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    enum State {
        case unavailable
        case available
    }

    // MARK: - Subviews

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var selectedDayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Public properties

    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedDayView.backgroundColor = .systemIndigo.withAlphaComponent(0.3)
                selectedDayView.layer.cornerRadius = selectedDayView.frame.width / 2
                selectedDayView.layer.masksToBounds = true
            } else {
                selectedDayView.backgroundColor = .clear
            }
        }
    }

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

        addSubview(dayLabel)
        addSubview(dayOfWeekLabel)
        addSubview(selectedDayView)

        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            dayOfWeekLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            dayOfWeekLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: leadingAnchor),

            selectedDayView.topAnchor.constraint(equalTo: topAnchor),
            selectedDayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectedDayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedDayView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - Public Methods

    func configure(with date: Date) {
        dayLabel.text = date.convertDateToString()
        dayOfWeekLabel.text = date.dayOfWeek()
    }
}

// MARK: - Layout constants

extension DateCell {
    private struct Constants {
        static let edgeInset: CGFloat = 16
        static let viewWidth: CGFloat = 64
        static let viewHeight: CGFloat = 32
    }
}
