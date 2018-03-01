//
//  MapViewController.swift
//  newmyfood
//
//  Created by jamel on 21/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class MapViewController: UIViewController {
    
   
    @IBOutlet weak var mapView: MKMapView!
    var allEspace = [AllEspaces]()
    
    let URL_GET_ALLESPACES =  "http://alsoqub.com/Mobiles/allEspaces"
    
    func fetchData()
    {
        let url = "http://alsoqub.com/Mobiles/allEspaces"
        
        let filePath = URL(fileURLWithPath: url)
        
        var data : Data?
       // data: Data?
        do {
    data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
        } catch let error {
          data = nil
            print("Report error \(error.localizedDescription)")
        }
        if let jsonData =  data  {
            let json = JSON(jsonData)
            if let allespaces = json["result"].array {
                for allespace in allespaces {
                    if let espace = AllEspaces.from(json:  allespace) {
                        self.allEspace.append(espace)
                    }
                }
            }
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

      let initialLocation = CLLocation(latitude: 36.80871189, longitude: 10.08982292)
        zoomMapOn(location: initialLocation)
        
       LoadEsapces()

        if #available(iOS 9.0, *)
        {
            mapView.showsScale = true
            mapView.showsCompass = true
            mapView.showsTraffic = true
            mapView.showsUserLocation = true
        }
        
        mapView.delegate = self
       // fetchData()
        mapView.addAnnotations(allEspace)
    }
    var currentPlaceMark:CLPlacemark?
   
    @IBAction func showDirection(_ sender: Any) {
        guard let currentPlaceMark = currentPlaceMark else{
            return // si la destination est egal cuurentplacemark si non sortir de boucle
        }
        let directionRequest = MKDirectionsRequest()
        let destinationPlaceMark = MKPlacemark(placemark: currentPlaceMark)
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        // calculate the direction
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (directionsResponse, error) in
            guard let directionsResponse = directionsResponse else{
                if let error = error {
                    print("error getting directions: \(error.localizedDescription)")
                }
                return
            }
            
            let route = directionsResponse.routes[0]
            self.mapView.remove(self.mapView.overlays as! MKOverlay)
            self.mapView.add(route.polyline, level: .aboveRoads)
            let routRect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(routRect), animated: true)
        }
    }
    
 func LoadEsapces(){
   /* let SampleJava = AllEspaces(adresse: " عنوان مطعم 1", nom: "مطعم 1", coordinate:CLLocationCoordinate2DMake(36.80871189, 10.08982292), image:"rest1", allEspaceID: 4)
    let SampleJava2 = AllEspaces(adresse: " عنوان مطعم 21", nom: "21", coordinate:CLLocationCoordinate2DMake(36.80871189, 10.08982290), image:"rest2", allEspaceID: 2)*/
    self.allEspace.append(AllEspaces (adresse: " عنوان مطعم 1", nom: "مطعم 1", coordinate: CLLocationCoordinate2DMake(36.80871189, 10.08982292), image: "rest1", allEspaceID: 1))
     self.allEspace.append(AllEspaces (adresse: " عنوان مطعم 2", nom: "مطعم 2", coordinate: CLLocationCoordinate2DMake(36.80871190, 10.08982292), image: "rest1", allEspaceID: 2))
     self.allEspace.append(AllEspaces (adresse: " عنوان مطعم 3", nom: "مطعم 3", coordinate: CLLocationCoordinate2DMake(36.80871189, 10.08982290), image: "rest1", allEspaceID: 3))
    self.allEspace.append(AllEspaces (adresse: " عنوان مطعم 4", nom: "مطعم 4", coordinate: CLLocationCoordinate2DMake(36.80871190, 10.08982280), image: "rest1", allEspaceID: 3))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private let regionRadius: CLLocationDistance = 5000 // 1km ~ 1 mile = 1.6km
    func zoomMapOn(location: CLLocation)
        
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
   /*func fetchData(url:String)
    {
    let requestURL = NSURL(string: URL_GET_ALLESPACES)
    let request = NSMutableURLRequest(url: requestURL! as URL)
    request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest){
        data, response, error in
            do {
                //converting resonse to NSDictionary
                var produitJSON: NSDictionary!
                produitJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)  as! NSDictionary
               //print(produitJSON)
                let listProduitJSON:NSArray! = produitJSON["result"] as! NSArray
                print(listProduitJSON)
               for elem in listProduitJSON{
                    let produit: NSDictionary = elem as! NSDictionary
                   // print(produit)
                    let lat = produit["latitude"] as? Double
                    let long = produit["longitude"]as? Double
                    
    
                    self.allEspace.append(AllEspaces(adresse: (produit["adresse"] as? String)!, nom: (produit["nom"] as? String)!, coordinate: (CLLocationCoordinate2D (latitude: lat!, longitude: long!)), image: (produit["image"] as? String)!,  allEspaceID : (produit["id"] as? Int64)!))
                }
                DispatchQueue.main.async {
                //    self.CollectionViewList.reloadData()
                }}
            catch {
                print("cannot load from server")
            }}
        task.resume()
        
    
      
    }*/
    
    
    // MARK: - Current Location
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationServiceAuthenticationStatus()
    }
    
    var locationManager = CLLocationManager()
    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self as CLLocationManagerDelegate
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

}

