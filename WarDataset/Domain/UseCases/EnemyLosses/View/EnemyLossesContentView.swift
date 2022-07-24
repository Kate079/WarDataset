//
//  EnemyLossesContentView.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation
import UIKit

final class EnemyLossesContentView: UIView {
    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell.reuseIdentifier)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var calendar: HorizontalCalendarView = {
        let calendarView = HorizontalCalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.dateSelectedCompletion = { [weak self] date in
            self?.configureCalendarSelectionHandler?(date)
        }
        return calendarView
    }()

    // MARK: - Public properties

    var configureCalendarSelectionHandler: ((Date?) -> Void)?
    var collectionItemSelectionHandler: (((String, String)) -> Void)?

    // MARK: - Private properties

    private var equipmentViewModel: EnemyLossesModel.LoadData.EquipmentViewModel?
    private var personnelViewModel: EnemyLossesModel.LoadData.PersonnelViewModel?

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Private methods

    private func configureUI() {
        backgroundColor = .systemGray6

        addSubview(calendar)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: topAnchor),
            calendar.heightAnchor.constraint(equalToConstant: Constants.calendarHeight),
            calendar.leadingAnchor.constraint(equalTo: leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: calendar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - Public methods

    func displayEquipment(viewModel: EnemyLossesModel.LoadData.EquipmentViewModel) {
        self.equipmentViewModel = viewModel
        collectionView.reloadData()
        calendar.configureCalendar(with: DateFormatter.convertStringToDate(dateTime: equipmentViewModel?.equipment.date))
    }

    func displayPersonnel(viewModel: EnemyLossesModel.LoadData.PersonnelViewModel) {
        self.personnelViewModel = viewModel
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension EnemyLossesContentView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.personnelItems
        default:
            return Constants.equipmentItems
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.reuseIdentifier, for: indexPath) as? InfoCollectionViewCell,
              let equipmentViewModel = equipmentViewModel,
              let personnelViewModel = personnelViewModel
        else {
            return UICollectionViewCell()
        }

        switch indexPath.section {
        case 0:
            switch indexPath.item {
            case 0:
                cell.configure(personnelViewModel.personnel[0])
            case 1:
                cell.configure(personnelViewModel.personnel[1])
            default:
                break
            }
        case 1:
            switch indexPath.item {
            case 0:
                cell.configure(equipmentViewModel.equipment[0])
            case 1:
                cell.configure(equipmentViewModel.equipment[1])
            case 2:
                cell.configure(equipmentViewModel.equipment[2])
            case 3:
                cell.configure(equipmentViewModel.equipment[3])
            case 4:
                cell.configure(equipmentViewModel.equipment[4])
            case 5:
                cell.configure(equipmentViewModel.equipment[5])
            case 6:
                cell.configure(equipmentViewModel.equipment[6])
            case 7:
                cell.configure(equipmentViewModel.equipment[7])
            case 8:
                cell.configure(equipmentViewModel.equipment[8])
            case 9:
                cell.configure(equipmentViewModel.equipment[9])
            case 10:
                cell.configure(equipmentViewModel.equipment[10])
            case 11:
                cell.configure(equipmentViewModel.equipment[11])
            case 12:
                cell.configure(equipmentViewModel.equipment[12])
            case 13:
                cell.configure(equipmentViewModel.equipment[13])
            case 14:
                cell.configure(equipmentViewModel.equipment[14])
            case 15:
                cell.configure(equipmentViewModel.equipment[15])
            default:
                break
            }
        default:
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.reuseIdentifier, for: indexPath) as? CollectionViewHeader else {
            return UICollectionReusableView()
        }
        switch indexPath.section {
        case 0:
            header.configure(with: "Personnel")
        case 1:
            header.configure(with: "Equipment")
        default:
            break
        }
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension EnemyLossesContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let equipmentViewModel = equipmentViewModel,
              let personnelViewModel = personnelViewModel
        else {
            return
        }
        let selectedItem: (String, String)

        switch indexPath.section {
        case 0:
            selectedItem = personnelViewModel.personnel[indexPath.item]
        default:
            selectedItem = equipmentViewModel.equipment[indexPath.item]
        }
        collectionItemSelectionHandler?(selectedItem)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EnemyLossesContentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = bounds.width / 2.4
        let itemHeight = itemWidth * 0.7
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.edgeInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: Constants.edgeInset, bottom: 0.0, right: Constants.edgeInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: Constants.headerHeight)
    }
}

// MARK: - Layout constants

extension EnemyLossesContentView {
    private struct Constants {
        static let headerHeight: CGFloat = 60
        static let edgeInset: CGFloat = 20
        static let personnelItems: Int = 2
        static let equipmentItems: Int = 16
        static let numberOfSections: Int = 2
        static let calendarHeight: CGFloat = 150
    }
}
