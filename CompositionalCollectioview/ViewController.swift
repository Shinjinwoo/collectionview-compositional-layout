//
//  ViewController.swift
//  CompositionalCollectioview
//
//  Created by 신진우 on 11/16/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section: Int,CaseIterable{
        case firstLine
        case secondLine
        case thirdLine
        
        var columnCount: Int {
            switch self { // self represents the instance of the enum
            case .firstLine:
                return 1
            case .secondLine:
                return 1
            case .thirdLine:
                return 1
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AppleFramework>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let list: [AppleFramework] = AppleFramework.list
    let list2: [AppleFramework] = AppleFramework.list2
    let list3: [AppleFramework] = AppleFramework.list3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationCollectionView()
    }
    
    private func configurationCollectionView() {
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        
        // 프레젠테이션
        dataSource = UICollectionViewDiffableDataSource<Section, AppleFramework>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleCell", for: indexPath) as? SampleCell else {
                return UICollectionViewCell()
            }
            cell.configure(data:item )
            return cell
        })
        
        
        //헤더 설정
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
                fatalError("HeaderView를 찾을수 없습니다.")
            }
            headerView.textLabel.text = "\(indexPath.section + 1)번째 섹션"
            return headerView
        }
        
        // 레이어
        collectionView.collectionViewLayout = layout()
        
        // 데이터
        var snapshot = NSDiffableDataSourceSnapshot<Section, AppleFramework>()
        snapshot.appendSections([.firstLine,.secondLine,.thirdLine])
        
        // 스냅샷에는 중복된 데이터가 추가 되지 않는다 헤셔블 해야하는데
        // 그 이유는 reloadData()처럼 모든 Cell을 다시 그리는것이 아닌 추가 된 데이터만 다시 그리게 해야 하기 때문 !
        snapshot.appendItems(list, toSection: .firstLine)
        snapshot.appendItems(list2, toSection: .secondLine)
        snapshot.appendItems(list3, toSection: .thirdLine)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
        
            //어떠한 섹션의 타입인지 Enum으로 찾는다.
            guard let sectionType = Section(rawValue: sectionIndex) else {
                return nil
            }
            
            // 표시할 그룹의 행의 갯수... 이 경우 요구사항이 1개의 행이였다.
            let columns = sectionType.columnCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            // .absolute로 절대값, .fractional으로 비율별로 상대적으로 값을 줄수 있다
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(220))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            
            // 재사용 되는 헤더뷰에 대한 설정이다.
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            //스크롤링 Behavior를 설정한다... 이 경우 horizental로 그룹별로 가운데 정렬로 보여주는 방법도 있고
            //요구사항대로 continuous 하게 개발하는 방법도 있었다.
            
            
            switch sectionType {
            case .firstLine : section.orthogonalScrollingBehavior = .groupPagingCentered
            case .secondLine : section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            case .thirdLine :
                section.orthogonalScrollingBehavior = .paging
            }
            //section.orthogonalScrollingBehavior = .groupPagingCentered
            //section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
        
        return layout
    }
}

