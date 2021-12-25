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
    
    let naverHeaders: HTTPHeaders = [
        "X-Naver-Client-Id" : "UnEPRBm5dkfZ_8EXRe8I",
        "X-Naver-Client-Secret" : "YlEqSjADOZ"
    ]
    
    
    var Restaurants: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: KakaoData.self) { response in

                switch response.result {
                case .success:
                    print("decoded successful")
                    if let restaurantList = response.value?.documents {
                        self.Restaurants = restaurantList
                        
//                        for restaurant in restaurantList {
//                            
//                        }
                        self.firstCollectionView.reloadData()
                    }
                    
                case let .failure(error):
                    print(error)
                }
                
                
            }
        
        
        
        
    }
}


extension FirstVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! FirstCollectionViewCell
        
        let name = Restaurants[indexPath.row].place_name
        let roadAddressName = Restaurants[indexPath.row].road_address_name
        
        cell.titleLabel.text = name
        
        let params = [
            "query" : "\(roadAddressName) \(name)"
        ]
        
        print(params)
        
        AF.request("https://openapi.naver.com/v1/search/image", method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: naverHeaders)
            .validate()
            .responseDecodable(of: NaverData.self) { response in
                switch response.result {
                case .success:
                    print("decoded naver successful")
                    if let link = response.value?.items[0].link {
                        print("URL 링크는 \(link)")
                        let url = URL(string: link)
                        do {
                            let data = try Data(contentsOf: url!)
                            cell.imageView1.image = UIImage(data: data)
                            print("성공적인 이미지 적용")
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        
                    }

                case let .failure(error):
                    print(error)
                }
                
            }
        
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
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
