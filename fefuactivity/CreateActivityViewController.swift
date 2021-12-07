//
//  CreateActivityViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 26.11.2021.
//

import UIKit
import CoreLocation
import MapKit

class CreateActivityViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startContainer: UIView!
    @IBOutlet weak var startButtomActivity: UIButton!
    
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        return manager
    }()
    
    var userLocation: CLLocation? {
        didSet{
            guard let userLocation = userLocation else {
                return
            }
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
            
            userLocationHistory.append(userLocation)
        }
    }
    
    fileprivate var userLocationHistory: [CLLocation] = [] {
        didSet {
            let coordinates = userLocationHistory.map { $0.coordinate }
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            
            route.title = "Ваш маршрут"
            
            mapView.addOverlay(route)
        }
    }
    
    private let userLocationIdentifier = "user_icon"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    @IBAction func startActivityButton(_ sender: UIButton) {
        startContainer.isHidden = true
        startButtomActivity.isHidden = true
    }
}

private let userLocationIdentifier = "user_icon"

extension CreateActivityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
        print("координаты вашего устройства", currentLocation.coordinate)
    
        userLocation = currentLocation
    }
}

extension CreateActivityViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            render.fillColor = UIColor.blue
            render.strokeColor = UIColor.blue
            render.lineWidth = 5
            
            return render
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKUserLocation{
            let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationIdentifier)
            
            let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: userLocationIdentifier)
            
            view.image = UIImage(named: "ic_user_location")
            return view
        }
        return nil
    }
}
