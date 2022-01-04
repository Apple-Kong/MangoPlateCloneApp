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
import Kingfisher


class FirstVC: UIViewController {
    var locationManager = CLLocationManager()
    let kakaoLocalDataManager = KakaoLocalDataManager()
    let naverImageDataManager = NaverImageDataManager()
    var refreashControl = UIRefreshControl()
    
    var restInfos: [RestInfo] = []
    var x = "127.06283102249932"
    var y = "37.514322572335935"
    
    let images = [ImageSource(image: UIImage(named: "event_0")!),
                  ImageSource(image: UIImage(named: "event_1")!),
                  ImageSource(image: UIImage(named: "event_2")!),
                ]
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var firstCollectionView: UICollectionView!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "map" {
            
            
            let followingVC = segue.destination as? MapViewController
            followingVC?.restInfos = self.restInfos
            followingVC?.currentLocation = (x,y)
        }
    }
    
    @objc func pullToRefreash(_ sender: Any) {
        
        locationManager.requestLocation()
        
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            self.locationButton.titleLabel?.text = locationString
            print("💸💸💸💸   \(locationString)")
        }
        kakaoLocalDataManager.fetchRestaurants(x: x, y: y, delegate: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        firstCollectionView.refreshControl = refreashControl
        refreashControl.addTarget(self, action: #selector(pullToRefreash(_:)), for: .valueChanged)
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            self.locationButton.titleLabel?.text = locationString
            print("💸💸💸💸   \(locationString)")
        }

        self.showIndicator()
        kakaoLocalDataManager.fetchRestaurants(x: x, y: y, delegate: self)

    }
}


extension FirstVC {
    func didRetrieveLocal(response: KakaoLocalResponse) {
        // 네트워크 성공시 실행
        
        for (index, detail) in response.documents.enumerated() {
            self.restInfos = []
            
            naverImageDataManager.fetchImage(place_name: detail.place_name) { urlString in
                if urlString != "요청실패" {
                    self.dismissIndicator()
                    self.restInfos.append(RestInfo(urlString: urlString, detail: detail))
                    self.firstCollectionView.reloadData()
                } else {
                    self.dismissIndicator()
                    print("\(index)이미지 요청 실패")
                }
            }
        }
    }
    
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
}




extension FirstVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restInfos.count
    }
    
    
    //KingFisher 사용해서 이미지 캐싱 및 다운로드 해보기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! FirstCollectionViewCell
        
        if indexPath.row < restInfos.count {
            let restInfo = restInfos[indexPath.row]
            
            //옵셔널값 대응 필요.
            let url = URL(string: restInfo.urlString!)
            cell.imageView1.kf.setImage(with: url)
            let name = restInfo.detail.place_name
            cell.titleLabel.text = name
            cell.distanceLabel.text = restInfo.distance + "km"
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
            
            self.x = String(coordinate.longitude)
            self.y = String(coordinate.latitude)
            print("🗺 🗺 🗺위치 정보 불러오기 완료")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription + "🗺 🗺 🗺🗺 🗺 🗺 ")
    }
}
