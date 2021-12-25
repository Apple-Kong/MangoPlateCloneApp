//
//  FirstVC.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import Alamofire

class FirstVC: UIViewController {
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    
    
    let naverHeaders: HTTPHeaders = [
        "X-Naver-Client-Id" : "UnEPRBm5dkfZ_8EXRe8I",
        "X-Naver-Client-Secret" : "YlEqSjADOZ"
    ]
    
    
    var Restaurants: [Restaurant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        networkManager.fetchRestaurants { restaurants in
            self.Restaurants = restaurants
            self.firstCollectionView.reloadData()
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
        
        networkManager.fetchImage(roadAddressName: roadAddressName, place_name: name) { urlString in
            do {
                if let url = URL(string: urlString) {
                    let data = try Data(contentsOf: url)
                    cell.imageView1.image = UIImage(data: data)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
//        let params = [
//            // 검색어를 가게 이름 + 주소로 설정
//            "query" : "\(name) \(roadAddressName)",
//            // 하나의 항목만 필요하니까 1개
//            "display" : "1", // 이부분 정수로 받아야해서 문제 생길 거 같은데 일단 해봐
//            // 유사도 순으로 정렬
//            "sort" : "sim"
//        ]
//
//        print(params)
//
//        AF.request("https://openapi.naver.com/v1/search/image", method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: naverHeaders)
//            .validate()
//            .responseDecodable(of: NaverData.self) { response in
//                switch response.result {
//                case .success:
//                    print("decoded naver successful")
//                    if let link = response.value?.items[0].link {
//                        print("URL 링크는 \(link)")
//                        let url = URL(string: link)
//                        do {
//                            let data = try Data(contentsOf: url!)
//                            cell.imageView1.image = UIImage(data: data)
//                            self.firstCollectionView.reloadData()
//                            print("성공적인 이미지 적용")
//                        } catch {
//                            print(error.localizedDescription)
//                        }
//
//
//                    }
//
//                case let .failure(error):
//                    print(error)
//                }
//
//            }
//
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
