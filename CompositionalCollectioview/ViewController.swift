//
//  ViewController.swift
//  CompositionalCollectioview
//
//  Created by 신진우 on 11/16/23.
//

import UIKit

class ViewController: UIViewController {

    typealias Item = AppleFramework
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationCollectionView()
    
    }
    
    private func configurationCollectionView() {
        
        
        
    }
}

