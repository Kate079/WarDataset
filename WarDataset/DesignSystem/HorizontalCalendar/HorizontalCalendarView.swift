//
//  HorizontalCalendarView.swift
//  WarDataset
//
//  Created by Kate on 20.07.2022.
//

import Foundation
import UIKit

final class HorizontalCalendarView: UIView {
    // MARK: - Subviews
    
    private lazy var monthAndYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getPreviousMonth), for: .touchUpInside)
        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getNextMonth), for: .touchUpInside)
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [leftButton, monthAndYearLabel, rightButton])
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Public properties

    var dateSelectedCompletion: ((Date?) -> Void)?

    // MARK: - Private properties

    private var calendarArray: [Date] = [Date]()
    private var currentDate: Date?
    private var currentMonth: Int = 0
    private var currentYear: Int = 0
    private let calendar = Calendar.current

    private(set) var selectedDate: Date? {
        didSet {
            dateSelectedCompletion?(selectedDate)
        }
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        configureCalendar(with: Date())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func configureUI() {
        backgroundColor = .systemGray6

        addSubview(buttonsStackView)
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.edgeInset),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edgeInset)),

            collectionView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureDateLabel(monthIndex: Int, year: Int) {
        let dateComponents = DateComponents(year: year, month: monthIndex)
        guard let date = calendar.date(from: dateComponents) else { return }
        monthAndYearLabel.text = "\(date.monthName) \(date.year)"
        calendarArray = date.currentMonthDates

        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }

    private func selectCurrentDay() {
        guard let currentDate = currentDate else { return }
        let index = Int(currentDate.convertDateToString()) ?? 0
        let indexPath = IndexPath(row: index - 1, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc private func getPreviousMonth() {
        currentMonth -= 1
        if currentMonth < 0 {
            currentMonth = 11
            currentYear -= 1
        }
        configureDateLabel(monthIndex: currentMonth, year: currentYear)
    }

    @objc private func getNextMonth() {
        currentMonth += 1
        if currentMonth > 11 {
            currentMonth = 0
            currentYear += 1
        }
        configureDateLabel(monthIndex: currentMonth, year: currentYear)
    }

    // MARK: - Public methods

    func configureCalendar(with date: Date) {
        currentDate = date
        currentMonth = calendar.component(.month, from: currentDate ?? Date())
        currentYear = calendar.component(.year, from: currentDate ?? Date())

        configureDateLabel(monthIndex: currentMonth, year: currentYear)
        selectCurrentDay()
    }
}

// MARK: - UICollectionViewDataSource

extension HorizontalCalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as? DateCell else {
            return UICollectionViewCell()
        }
        let date = calendarArray[indexPath.item]
        cell.configure(with: date)

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HorizontalCalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as? DateCell else { return }
        cell.isSelected = true
        currentDate = calendarArray[indexPath.item]
        selectedDate = currentDate
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as? DateCell else { return }
        cell.isSelected = false
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HorizontalCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = 50
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
}

// MARK: - Layout constants

extension HorizontalCalendarView {
    private struct Constants {
        static let edgeInset: CGFloat = 32
    }
}
