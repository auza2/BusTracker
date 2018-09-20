//
//  MenuBar.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/11/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    let names = ["TIMES","MAP"]
    
    var horizontalbarLeftAnchorContstraint: NSLayoutConstraint?
    var mainViewDelegate: OneStop?
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.register(MenuCell.self, forCellWithReuseIdentifier: "cell")
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.Blue
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        addContstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        
        setUpHorizontalBar()
    }
    
    func setUpHorizontalBar(){
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor.Purple
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBar)
        
        horizontalbarLeftAnchorContstraint = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalbarLeftAnchorContstraint?.isActive = true
        horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuCell
        cell.menuLabel.text = names[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainViewDelegate?.scrollToMenuIndex(indexPath.item)
    }
}

class MenuCell: BaseCollectionViewCell{
    let menuLabel: UILabel = {
        let ml = UILabel()
        ml.textAlignment = .center
        ml.textColor = UIColor.white
        return ml
    }()
    
    override var isHighlighted: Bool{
        didSet{
            menuLabel.textColor = isHighlighted ?  UIColor.Purple : UIColor.white
        }
    }
    
    override var isSelected: Bool{
        didSet{
            menuLabel.textColor = isSelected ?  UIColor.Purple : UIColor.white
        }
    }
    
    override func setUpView() {
        addSubview(menuLabel)
        
        addContstraintsWithFormat(format: "H:|[v0]|", views: menuLabel)
        addContstraintsWithFormat(format: "V:[v0(50)]", views: menuLabel)
        addConstraint(NSLayoutConstraint(item: menuLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: menuLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}

