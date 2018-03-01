//
//  AllEspacesItem.swift
//  newmyfood
//
//  Created by jamel on 21/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import MapKit
import AddressBook
import SwiftyJSON
class AllEspaces: NSObject, MKAnnotation
{
    let adresse: String?
    let nom: String?
    let coordinate: CLLocationCoordinate2D
    let image: String
    var allEspaceID:Int64

    init(adresse: String, nom: String?, coordinate: CLLocationCoordinate2D, image:String, allEspaceID: Int64)
    {
        self.adresse = adresse
        self.nom = nom
        self.coordinate = coordinate
        self.image = image
        self.allEspaceID = allEspaceID
        super.init() // because NSObject
}
    var subtitle: String? {
        return adresse
       
    }
    var title: String? {
        return nom
        
    }
   class func from(json: JSON) -> AllEspaces?
    {
        var locationName: String
        if let unwrappedTitle = json["nom"].string {
            locationName = unwrappedTitle
        } else {
            locationName = ""
        }
        
        let locationAdress = json["adresse"].string
        let lat = json["latitude"].doubleValue
        let long = json["longitude"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let image = json ["image"].string
        let allEspaceID = json ["id"].int64
        return AllEspaces ( adresse: locationAdress!, nom: locationName, coordinate: coordinate, image:image!, allEspaceID: allEspaceID!)
        
    }
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(title) \(subtitle)"
        
        return mapItem
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! AllEspaces
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    }
    

