//
//  HomeController.swift
//  JTWalkthrough
//
//  Created by Jaksa Tomovic on 27/02/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

public let mainColor = UIColor(red: 251/255, green: 253/255, blue: 255/255, alpha: 1)

class HomeController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate  {
    
    let locationManager = CLLocationManager()
    var pointAnotation  = MKPointAnnotation()
//    var bikeStop = NSDictionary()

    
    let paperView = PaperView()
    
    let mapView: MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainColor
        
        setupNavigationBar()
        
        view.addSubview(mapView)
        
        _ = mapView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //1 creates alert to request access from the user
        locationManager.requestWhenInUseAuthorization()
        
        // 2 sets the location managers delegates to this VC
        locationManager.delegate = self
        //4 start tracking user
        locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        let x = 43.512299
        let y = 16.441770
        
        let latitude = Double(x)
        let longitude = Double(y)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
//        annotation.title = bikeStop.object(forKey: "stationName") as? String
        //        annotation.subtitle = bikeStop.objectForKey("") as? String
        
        self.mapView.addAnnotation(annotation)
        
        self.zoomMap()

        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }
    
    func mapView(_ mapView: MKMapView,viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //userlocation
        if annotation is MKUserLocation{
            return nil
        }
        
        let pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pinView.image = UIImage(named:"bike")
        pinView.canShowCallout = true
        let calloutButton = UIButton(type: .detailDisclosure) as UIButton
        pinView.rightCalloutAccessoryView = calloutButton
        
        return pinView
    }
    
    func zoomMap()
    {
//        let x = bikeStop.object(forKey: "latitude") as! Int
//        let y = bikeStop.object(forKey: "longitude") as! Int
        let x = 43.512299
        let y = 16.441770
        let latitude = Double(x)
        let longitude = Double(y)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude , longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
        
    }

   
    
    fileprivate func setupNavigationBar() {
        
        addSegmentControl()                
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let filterButton = UIButton(type: .system)
        filterButton.setImage(UIImage(named: "ico-filter-map")?.withRenderingMode(.alwaysOriginal), for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
    }

    fileprivate func addSegmentControl() {

        let items = ["Map", "Paper"]
        let customSC = UISegmentedControl(items: items)
        customSC.layer.cornerRadius = 5.0
        customSC.clipsToBounds = true
        customSC.sizeToFit()
        customSC.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/2-40, height: 34)
        customSC.tintColor = UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1)
        customSC.backgroundColor = UIColor(red: 251/255, green: 253/255, blue: 255/255, alpha: 1)
        customSC.selectedSegmentIndex = 0
        customSC.addTarget(self, action: #selector(changeView), for: .valueChanged)
        navigationItem.titleView = customSC
    
    }
    
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            self.view.addSubview(paperView)
            _ = paperView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        default:
            paperView.removeFromSuperview()
        }
    }
    
}


class PaperView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = mainColor
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: cellId)
        
        _ = collectionView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 187)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PreviewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(50, 32, 0, 32)
    }
    
}
