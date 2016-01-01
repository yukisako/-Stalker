//
//  ViewController.swift
//  Map demo
//
//  Created by 迫 佑樹 on 2015/12/31.
//  Copyright © 2015年 迫 佑樹. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    //ロケーションマネージャ
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //iPhoneのGPSを使う
        
        locationManager.requestWhenInUseAuthorization()
        //認証を要求
        
        locationManager.startUpdatingLocation()
        //場所変わってもOK
        
        //35.013392, 135.857579
        /*
        var latitude: CLLocationDegrees = 35.013392
        var longitude: CLLocationDegrees = 135.857579
        
        */
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 1
        
        map.addGestureRecognizer(uilpgr)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //新しい位置情報が取得された時に呼び出される
        print(locations)
        
        var userLocation: CLLocation = locations[0]
        
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.003
        var longDelta: CLLocationDegrees = 0.003
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location

        
        annotation.title = "Яの軌跡"
        
        annotation.subtitle = "きてええで"
        
        map.addAnnotation(annotation)
        
    }
    
    
    
    
    func action(gestureRecognizer: UIGestureRecognizer){
        
        print("Gesture Recognized")
        
        
        var touchPoint = gestureRecognizer.locationInView(self.map)
        
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinate
        
        annotation.title = "タップしたとこ！"
        
        annotation.subtitle = "めっちゃでかかった"
        
        map.addAnnotation(annotation)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

