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
    @IBOutlet weak var startCont: UIView!
    @IBOutlet weak var stopCont: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentActivityName: UILabel!
    @IBOutlet weak var currentActivityDistance: UILabel!
    
    
    var activityType = ["Бег", "Вело", "Прыг", "Плавь"]
    
    var images = [UIImage]()
    var activityListName = [String]()
    var currentName = ""
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        return manager
    }()
    
    fileprivate var userLocation: CLLocation? {
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        for i in 0...3{
            let image = UIImage(named: "image\(i)")!
            images.append(image)
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if startCont.isHidden == false {
            startCont.isHidden = true
            stopCont.isHidden = false
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
    }
}


private let userLocationIdentifier = "user_icon"

extension CreateActivityViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityTypes", for: indexPath) as! MapCollectionViewCell
        let img = images[indexPath.row]
        cell.MapColCelImg.image = img
        let label = activityType[indexPath.row]
        cell.MapColCelLabel.text = label
        activityListName.append(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentName = activityListName[indexPath.row]
        self.currentActivityName.text = currentName
    }
}

var startLocation:CLLocation!
var lastLocation:CLLocation!

var traveledDistance:Double = 0

extension CreateActivityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        startLocation = locations.first
        guard let currentLocation = locations.first
        else {
            return
        }
        print("координаты вашего устройства", currentLocation.coordinate)
        
        lastLocation = locations.last
        traveledDistance += startLocation.distance(from: lastLocation)
        
        self.currentActivityDistance.text = String(traveledDistance)
        
        /*if currentLocation == nil {
            startLocation = locations.first as! CLLocation
        } else {
            lastLocation = locations.last as! CLLocation
            let distance = startLocation.distance(from: lastLocation)
            startLocation = lastLocation
            traveledDistance += distance
            self.currentActivityDistance.text = String(traveledDistance)*/
    
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
