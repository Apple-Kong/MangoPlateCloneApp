//
//  FirstVC+DataSource.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2022/01/05.
//

import UIKit
import Kingfisher


extension FirstVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restInfos.count
    }
    
    
    //KingFisher 사용해서 이미지 캐싱 및 다운로드 해보기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! FirstCollectionViewCell
        
        if indexPath.row < restInfos.count {
            let restInfo = restInfos[indexPath.row]
            
            //🚨 옵셔널값 대응 필요.
            let url = URL(string: restInfo.urlString!)
            cell.imageView1.kf.setImage(with: url)
            let name = restInfo.detail.place_name
            cell.titleLabel.text = name
            cell.distanceLabel.text = restInfo.distance(latitude: Double(y)!, longitude: Double(x)!) + "km"
        }
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath) as! FirstCollectionViewHeader
            
            headerView.slideShow.setImageInputs(images)
          
            return headerView
        default:
            assert(false, "놉")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.firstCollectionView.contentOffset.y > firstCollectionView.contentSize.height - firstCollectionView.bounds.size.height {
            
            if isAvailable {
                isAvailable = false
                self.page = self.page + 1
                
                print("현재 페이지 \(page)")
                kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: self.page, delegate: self)
            }

        }
    }
}
