//
//  FirstVC.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import Alamofire

class FirstVC: UIViewController {
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    
    let parameters: [String: [String]] = [
        "x": ["127.06283102249932"],
        "y": ["37.514322572335935"],
        "query": ["강남 맛집"]
    ]
    
    let headers: HTTPHeaders = [
        "Authorization": "KakaoAK 98b807749ed5ea240799ffe5ae51b1b4"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
            .validate()
            .responseString { response in
                
                
                switch response.result {
                case .success:
                    print("success")
                    print(response)
                case let .failure(error):
                    print(error)
                }
        }
    }
}


extension FirstVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath)
            return headerView
        default:
            assert(false, "놉")
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        let width: CGFloat = collectionView.frame.width
//        let height: CGFloat = 100
//
//
//        return CGSize(width: width, height: height)
//
//    }

    
}

extension FirstVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width / 2 - 15
        let height = width * 1.5
        
        let size = CGSize(width: width, height: height)
        
        return size
    }
}
