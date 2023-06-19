//
//  ContinentsViewController.swift
//  COVID-19
//
//  Created by Denis on 2023/05/21.
//

import UIKit

final class ContinentCell: UICollectionViewCell {
        
    // MARK: - Static Properties
    static let cellIdentifireForContinent = "CellForContinents"
    
    // MARK: Public Properties
    var viewModel: ContinentViewModelProtocol! {
        didSet {
            labelContinent.text = viewModel.continent
        }
    }
    
    // MARK: - Private Properties
    private var visualView = VisualEffect()
    private var blurView: UIVisualEffectView!
    private var labelContinent: UILabel!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    func didTap() {
        blurView.layer.borderWidth = 2
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        blurView = visualView.setBlurView()
        blurView.layer.cornerRadius = 15
        
        labelContinent = UILabel()

        TAMIC()
        addSubviews()
        setupConstraints()
    }
    
    private func TAMIC() {
        labelContinent.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(blurView)
        blurView.contentView.addSubview(labelContinent)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            labelContinent.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            labelContinent.centerXAnchor.constraint(equalTo: blurView.centerXAnchor)
        ])
    }
}

// MARK: - Override Preferred Layout Attributes Fitting
extension ContinentCell {
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        
        let label = labelContinent.bounds.size
        let size = contentView.systemLayoutSizeFitting(label)
        var frame = layoutAttributes.frame
        
        frame.size.width = ceil(size.width + 30)
        frame.size.height = ceil(size.height + 10)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

// MARK: - Collection View Flow Layout
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superArray = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superArray, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }
            guard layoutAttribute.indexPath.section == 0 else {
                return
            }
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + ((self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAt: 0) ?? 10 )
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}
