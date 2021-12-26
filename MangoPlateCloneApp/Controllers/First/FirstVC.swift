//
//  FirstVC.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import Alamofire
import CoreLocation
import ImageSlideshow


class FirstVC: UIViewController {
    var locationManager: CLLocationManager?
    
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    
    
    var restInfos: [RestInfo] = []
    
    
    let naverHeaders: HTTPHeaders = [
        "X-Naver-Client-Id" : "UnEPRBm5dkfZ_8EXRe8I",
        "X-Naver-Client-Secret" : "YlEqSjADOZ"
    ]
    
    var count: Int = 0
    
    
    let images = [ImageSource(image: UIImage(named: "event_0")!),
                  ImageSource(image: UIImage(named: "event_1")!),
                  ImageSource(image: UIImage(named: "event_2")!),
                ]
    
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager?.delegate = self
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        


        networkManager.fetchRestaurants { restaurants in
            //completion handler 내부
            
            //레스토랑 리스트를 restInfos 리스트에 저장.
            for i in restaurants {
                self.restInfos.append(RestInfo(urlString: nil, detail: i))
            }

            
            print("🔑\(self.restInfos.count)")
            
            
            for (index, restInfo) in self.restInfos.enumerated() {
                print("\(index) -- \(restInfo.detail.place_name)")
            let params = [
                // 검색어를 가게 이름 + 주소로 설정
                "query" : "\(restInfo.detail.place_name)",
                // 하나의 항목만 필요하니까 1개
                "display" : "1", // 이부분 정수로 받아야해서 문제 생길 거 같은데 일단 해봐
                // 유사도 순으로 정렬
                "sort" : "sim"
            ]
            
           
            AF.request("https://openapi.naver.com/v1/search/image", method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: self.naverHeaders)
                .validate()
                .responseDecodable(of: NaverData.self) { response in
                    
                    
                    switch response.result {
                    case .success:
                        print("🌊🌊🌊 \(index) naver decoded  successful")
                        if let link = response.value?.items[0].link {
                            
                            //이미지 url 불러오는 데 성공했으면 그걸 각각의 restInfo 데이터에 추가.
                            self.restInfos[index].urlString = link
                        }
                    case let .failure(error):
                        print(error)
                        print("🌊🌊🌊 \(index) naver decoded  fail")
                    }
                    
                    
                    //임시 방편으로 15회 반복에 대한 count 를 세어서 15 회 째에 collectionView 를 reload 하게 하였음.
                    self.count = self.count + 1
                    if self.count == 15 {
                        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                        
                        DispatchQueue.main.async {
                            for i in self.restInfos {
                                print(i.detail.place_name)
                            }
                            self.firstCollectionView.reloadData()
                            
                        }
                    }
                }
            }
        }
    }
}


extension FirstVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! FirstCollectionViewCell
        let restInfo = restInfos[indexPath.row]
        
        let detail = restInfo.detail
        let name = detail.place_name
        cell.titleLabel.text = name
        
        print("\(indexPath.row) - \(name) - \(restInfos[indexPath.row].detail.place_name)")
        
        if let image = restInfo.image {
            cell.imageView1.image = image
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


extension FirstVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate.latitude)
            print(coordinate.longitude)
        }
    }
}


extension FirstVC: UICollectionViewDataSourcePrefetching {
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}
