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
    var locationManager = CLLocationManager()
    let kakaoLocalDataManager = KakaoLocalDataManager()
    let naverImageDataManager = NaverImageDataManager()
    var refreashControl = UIRefreshControl()
    
    var restInfos: [RestInfo] = []
    var page = 1
    var isAvailable = true
    
    //위치정보 관련 변수
    var currentLocationString: String = "강남구"
    var x = "127.02776284632832"
    var y = "37.498229652849226"
    
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
            followingVC?.currentLocationString = currentLocationString
        }
    }
    
    @objc func pullToRefreash(_ sender: Any) {
        self.restInfos = []
        locationManager.requestLocation()
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            
            self.currentLocationString = locationString
            self.locationButton.titleLabel?.text = self.currentLocationString
        }
        kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: 1, delegate: self)
        self.page = 1
        self.isAvailable = true


    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationButton.titleLabel?.text = currentLocationString
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
        
        
        //현재 위도 경도에 대한 지역명 요청
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            self.locationButton.titleLabel?.text = locationString
            print("💸💸💸💸   \(locationString)")
        }
        
        
        //현재 위도 경도 기반 맛집 리스트 요청
        self.showIndicator()
        kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: 1, delegate: self)

    }
}


extension FirstVC {
    
    // 네트워크 성공시 실행
    func didRetrieveLocal(response: KakaoLocalResponse) {
        
        
        DispatchQueue.main.async {
           self.firstCollectionView.refreshControl?.endRefreshing()
        }
        
        if response.meta.is_end {
            self.isAvailable = false
        } else {
            self.isAvailable = true
        }
        print("🏄🏻‍♂️🏄🏻‍♂️\(response.documents)")
        
        
        for (index, detail) in response.documents.enumerated() {
            //각각의 셀에 대해 이미지 요청
            naverImageDataManager.fetchImage(place_name: detail.place_name, location: currentLocationString) { urlString in
                if urlString != "요청실패" {
                    self.dismissIndicator()
                    
                    //이미지 urlString 을 받아온 경우. 이를 구조체로 묶어 뷰컨트롤러에 추가.
                    self.restInfos.append(RestInfo(urlString: urlString, detail: detail))
                    
                    //사용자 응답성 개선을 위해 main 큐에서 reload
                
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
        self.isAvailable = true
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
