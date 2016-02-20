//
//  MapViewController.swift
//  NeighborApp
//
//  Created by Asif Junaid on 2/7/16.
//  Copyright © 2016 Nitesh. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: BaseTabViewController,MKMapViewDelegate {

    @IBOutlet weak var mapViewOutlet: MKMapView!
    let initialLocation = CLLocation(latitude: 12.9335317047243, longitude: 77.621838592872)
    let pickUpDistanceLocation = CLLocation(latitude: 12.909671, longitude: 77.624458)
    let regionRadius: CLLocationDistance = 10000
    var overlayRadius : CLLocationDistance = 300
    let dropOffDistanceLocation = CLLocation(latitude: 11.909674, longitude: 77.624458)
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewOutlet.delegate = self
        centerMapOnLocation(initialLocation)
        checkLocationAuthorizationStatus()
        testing()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func testing()
    {
//        var location = CLLocation(latitude: lat, longitude: lon)
//        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))
        
        var location = CLLocation(latitude: 12.9335317047243, longitude: 77.621838592872)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))
        
       
        
        
        location = CLLocation(latitude: 12.9095317067243, longitude: 77.621838592894)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))
        
        
        location = CLLocation(latitude: 12.9095317067243, longitude: 77.621838592895)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))

        
        location = CLLocation(latitude: 12.9095317067243, longitude: 77.621838592896)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))

        
        
        location = CLLocation(latitude: 12.9095317067243, longitude: 77.621838592872)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))

        
        location = CLLocation(latitude: 12.9095317067243, longitude: 77.621838592872)
        
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))

        overlayRadius = 100

       
        location = CLLocation(latitude: 12.9335317047276, longitude: 77.621838592872)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))
        
        
        location = CLLocation(latitude: 12.9335317047287, longitude: 77.621838592872)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))
        
        
        location = CLLocation(latitude: 12.9335317047298, longitude: 77.621838592872)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))
        
        
        location = CLLocation(latitude: 12.9335317047249, longitude: 77.621838592872)
        self.mapViewOutlet.addOverlay(MKCircle(centerCoordinate: location.coordinate, radius: self.overlayRadius))
    }
    func addAnnotaion(location : CLLocationCoordinate2D,name : String){
        var myHomePin = MKPointAnnotation()
        myHomePin.coordinate = location
        myHomePin.title = name
        myHomePin.subtitle = name
//        self.mapViewOutlet.addAnnotation(myHomePin)
        
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapViewOutlet.setRegion(coordinateRegion, animated: true)
    }
    
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapViewOutlet.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
 
 
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.lineDashPattern = [14,10,6,10,4,10]
            polylineRenderer.strokeColor = UIColor(red: 0.012, green: 0.012, blue: 0.012, alpha: 1.00)
            polylineRenderer.lineWidth = 2.5
            return polylineRenderer
        }
        if let overlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = UIColor.blueColor()
            circleRenderer.alpha = 0.3
            return circleRenderer
        }
        
        return nil
        
    }
    
    
//    func addRoutesOverLayForMapView(){
//        
//        var source:MKMapItem?
//        var destination:MKMapItem?
//        var sourcePlacemark = MKPlacemark(coordinate: pickUpDistanceLocation.coordinate, addressDictionary: nil)
//        source = MKMapItem(placemark: sourcePlacemark)
//        
//        var desitnationPlacemark = MKPlacemark(coordinate: dropOffDistanceLocation.coordinate, addressDictionary: nil)
//        destination = MKMapItem(placemark: desitnationPlacemark)
//        let request:MKDirectionsRequest = MKDirectionsRequest()
//        request.source = source
//        request.destination = destination
//        request.transportType = MKDirectionsTransportType.Walking
//        
//        let directions = MKDirections(request: request)
//        directions.calculateDirectionsWithCompletionHandler ({
//            (response: MKDirectionsResponse?, error: NSError?) in
//            
//            if error == nil {
//                
//                self.showRoute(response!)
//            }
//            else{
//                
//                print("trace the error \(error?.localizedDescription)")
//                
//            }
//        })
//    }
    
//    func showRoute(response:MKDirectionsResponse){
//        for route in response.routes as! [MKRoute]{
//            mapViewOutlet.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
//            var routeSeconds = route.expectedTravelTime
//            let routeDistance = route.distance
//            print("distance between two points is \(routeSeconds) and \(routeDistance)")
//            
//            
//        }
//    }
    
}

