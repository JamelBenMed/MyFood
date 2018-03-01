//
//  MapviewExtension.swift
//  newmyfood
//
//  Created by jamel on 21/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//
import MapKit
import Foundation

extension MapViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
        self.mapView.showsUserLocation = true
        zoomMapOn(location: location)
    }
 
}
extension MapViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
        
    {

        if let annotation = annotation as? AllEspaces {
            let identifier = "pin"
            var view: MKPinAnnotationView


            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView

            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                view.animatesDrop = true
            }
          //  annotationView.image = UIImage(named: "rest1")

            
            return view
        } 

        return nil

    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let location = view.annotation as? AllEspaces{
            self.currentPlaceMark = MKPlacemark(coordinate: location.coordinate)//currentPlaceMark : destination
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.red
        render.lineWidth = 4.0
        return render
    }
}


