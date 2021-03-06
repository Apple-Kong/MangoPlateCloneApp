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
    @IBOutlet weak var locationButton: UIButton!
    
    var currentLocationString: String?
    var restInfos: [RestInfo] = []
    var currentLocation: (String, String)?
    
    @IBAction func mapBUtton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }

    
    var currentCoordinate: CLLocationCoordinate2D {
        
        if let currentLocation = currentLocation {
            return CLLocationCoordinate2D(latitude: Double(currentLocation.1) ?? 37.514322572335935, longitude: Double(currentLocation.0) ??  127.06283102249932)
        } else {
            return CLLocationCoordinate2D(latitude: 37.514322572335935, longitude: 127.06283102249932)
        }
        
    }
    let distanceSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationButton.titleLabel?.text = currentLocationString
        
        let mapCoordinates = MKCoordinateRegion(center: currentCoordinate, span: distanceSpan)
        mapView.setRegion(mapCoordinates, animated: true)
        mapView.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        
        for restInfo in restInfos {
            let name = restInfo.detail.place_name
            let subtitle = restInfo.detail.road_address_name
            let x = Double(restInfo.detail.x)
            let y = Double(restInfo.detail.y)
          
            
            let mark = Marker(title: name, subtitle: subtitle, coordinate: CLLocationCoordinate2D(latitude: y!, longitude: x!))
            mapView.addAnnotation(mark)
        }
    }
}



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
