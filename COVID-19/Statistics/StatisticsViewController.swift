//
//  StatisticsViewController.swift
//  COVID-19
//
//  Created by Denis on 2023/02/06.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    // MARK: - Private Views
    private lazy var stackViewForCollections = setupStackForCollection()
    
    private lazy var blurView = setupBlurView()
    
    private lazy var collectionViewForContinents = setupCollectionViewForContinents()
    private lazy var collectionViewForStatistics = setupCollectionViewForStatistics()
    private lazy var collectionViewForCountries = setupCollectionViewForCountries()
    
    // MARK: Private Properties
    
    private var selectedCell = 0
    
    private var viewModel: StatisticsViewModelProtocol! {
        didSet {
            viewModel.fetchStatistics { [weak self] in
                self?.collectionViewForContinents.reloadData()
                self?.collectionViewForStatistics.reloadData()
            }
            viewModel.fetchCountries { [weak self] in
                self?.collectionViewForCountries.reloadData()
            }
        }
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavBar()
        setupDelegates()
        
        view.addVerticalGradientLayer()
        title = "COVID-19"
        
        viewModel = StatisticsViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        blurView.layer.cornerRadius = 30
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        stackViewForCollections = setupStackForCollection()
        blurView = setupBlurView()
        collectionViewForContinents = setupCollectionViewForContinents()
        collectionViewForStatistics = setupCollectionViewForStatistics()
        collectionViewForCountries = setupCollectionViewForCountries()
        
        TAMIC()
        addSubviews()
        setupConstraints()
    }
        
    private func TAMIC() {
        stackViewForCollections.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewForContinents.translatesAutoresizingMaskIntoConstraints = false
        collectionViewForStatistics.translatesAutoresizingMaskIntoConstraints = false
        collectionViewForCountries.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        view.addSubview(stackViewForCollections)
        stackViewForCollections.addArrangedSubview(collectionViewForContinents)
        stackViewForCollections.addArrangedSubview(collectionViewForStatistics)
        stackViewForCollections.addArrangedSubview(blurView)
        blurView.contentView.addSubview(collectionViewForCountries)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionViewForContinents.heightAnchor.constraint(greaterThanOrEqualToConstant: 140),
            
            collectionViewForStatistics.heightAnchor.constraint(equalToConstant: 200),
            
            collectionViewForCountries.topAnchor.constraint(equalTo: blurView.topAnchor),
            collectionViewForCountries.bottomAnchor.constraint(equalTo: blurView.bottomAnchor),
            collectionViewForCountries.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            collectionViewForCountries.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            
            stackViewForCollections.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackViewForCollections.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackViewForCollections.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blurView.heightAnchor.constraint(equalToConstant: 200),
            blurView.leadingAnchor.constraint(equalTo: stackViewForCollections.leadingAnchor, constant: 10),
            blurView.trailingAnchor.constraint(equalTo: stackViewForCollections.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Refresh",
            style: .plain,
            target: self,
            action: #selector(reloadCells)
        )
    }
    
    private func setupDelegates() {
        collectionViewForContinents.dataSource = self
        collectionViewForContinents.delegate = self
        
        collectionViewForCountries.dataSource =  self
        collectionViewForCountries.delegate = self
        
        collectionViewForStatistics.dataSource = self
        collectionViewForStatistics.delegate = self
    }
    
    //MARK: Private Methods @objc
    @objc private func reloadCells() {
        collectionViewForStatistics.reloadData()
    }
}

// MARK: - Configure UI
extension StatisticsViewController {
    private func setupStackForCollection() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }
    
    private func setupBlurView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.clipsToBounds = true
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.shadowColor = UIColor.black.cgColor
        blurView.layer.shadowRadius = 7
        blurView.layer.shadowOpacity = 0.4
        blurView.layer.shadowOffset = CGSize(width: 15, height: 15)
        
        return blurView
    }
    
    private func setupCollectionViewForContinents() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        
        let leftAligmet = LeftAlignedCollectionViewFlowLayout()
        leftAligmet.sectionInset = UIEdgeInsets(top: 10,
                                                left: 10,
                                                bottom: 10,
                                                right: 10)
        leftAligmet.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: leftAligmet
        )
        collectionView.isScrollEnabled = false
        collectionView.register(
            ContinentCell.self,
            forCellWithReuseIdentifier: ContinentCell.cellIdentifireForContinent
        )
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }
    
    private func setupCollectionViewForStatistics() -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(
            GeneralStatisticsViewController.self,
            forCellWithReuseIdentifier: GeneralStatisticsViewController.cellIdentifireForStatistics
        )
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }
    
    private func setupCollectionViewForCountries() -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(
            CountryStatisticsViewController.self,
            forCellWithReuseIdentifier: CountryStatisticsViewController.cellIdentifireForStatistics
        )
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }
}

// MARK: - Collection View Data Source
extension StatisticsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewForStatistics {
            return viewModel.numberOfCellsInGeneralCollection()
        } else if collectionView == collectionViewForCountries {
            return viewModel.numberOfCellsInCountriesCollection()
        } else {
            return viewModel.numberOfCellsInGeneralCollection()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewForStatistics {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GeneralStatisticsViewController.cellIdentifireForStatistics,
                for: indexPath
            )
            guard let cell = cell as? GeneralStatisticsViewController else {
                return UICollectionViewCell()
            }
            cell.viewModel = viewModel.getGeneralStatisticsCellViewModel(at: indexPath)
            
            return cell
        } else if collectionView == collectionViewForCountries {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryStatisticsViewController.cellIdentifireForStatistics, for: indexPath)
            
            guard let cell = cell as? CountryStatisticsViewController else {
                return UICollectionViewCell()
            }
            cell.layer.backgroundColor = UIColor.clear.cgColor
            cell.viewModel = viewModel.getCountryStatisticsViewModel(at: indexPath)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContinentCell.cellIdentifireForContinent,
                for: indexPath
            )
            guard let cell = cell as? ContinentCell else {
                return UICollectionViewCell()
            }
            
            cell.viewModel = viewModel.getContenentCellViewModel(at: indexPath)
            if selectedCell == indexPath.row {
                cell.didTap()
            }
            return cell
        }
    }
}
// MARK: - Collection View Delegate
extension StatisticsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewForContinents {

            if selectedCell == indexPath.row { return }
            selectedCell = indexPath.row
            viewModel.setContinent(at: indexPath)
            collectionViewForContinents.reloadData()
            collectionViewForStatistics.reloadData()
        }
    }
}
