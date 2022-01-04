//
//  MapViewController.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/28.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var restInfos: [RestInfo] = []
    
    @IBAction func mapBUtton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    let currentLocation = CLLocationCoordinate2D(latitude: 37.514322572335935, longitude: 127.06283102249932)
    
    let distanceSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    let mark = Marker(
//             title: "홍대입구역",
//             subtitle: "사람이 너무 많아요ㅜ",
//             coordinate: CLLocationCoordinate2D(latitude: 37.55769, longitude: 126.92450))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let mapCoordinates = MKCoordinateRegion(center: currentLocation, span: distanceSpan)
        mapView.setRegion(mapCoordinates, animated: true)
        mapView.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        
        for restInfo in restInfos {
            let name = restInfo.detail.place_name
            let subtitle = restInfo.detail.road_address_name
            let x = Double(restInfo.detail.x)
            let y = Double(restInfo.detail.y)
            print(x,y)
            
            let mark = Marker(title: name, subtitle: subtitle, coordinate: CLLocationCoordinate2D(latitude: y!, longitude: x!))
            mapView.addAnnotation(mark)
        }
    }
}


//"x": ["127.06283102249932"],
//"y": ["37.514322572335935"],



class Marker: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  let subtitle:String?

  init(
    title: String?,
    subtitle: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate

    super.init()
  }
}
