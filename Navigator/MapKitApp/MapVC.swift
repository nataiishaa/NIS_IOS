//
//  ViewController.swift
//  MapKitApp
//  Created by Студент on 29.11.2023.
//
import UIKit
import CoreLocation
import MapKit
// in info.plist:
// NSLocationWhenInUseUsageDescription
// Privacy - Location When In Use Usage Description
// or
// NSLocationAlwaysUsageDescription


class CustomAnnotationView: MKAnnotationView {
    private let annotationFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
    private let label: UILabel

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.label = UILabel(frame: annotationFrame.offsetBy(dx: 0, dy: -6))
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        self.label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.label.textColor = .red
        self.label.textAlignment = .center
        self.backgroundColor = .systemCyan
        self.addSubview(label)
        
    }
    override var isSelected: Bool {
        didSet {
            updateAnnotationSize()
        }
    }

    private func updateAnnotationSize() {
        let newFrame = isSelected ? CGRect(x: 0, y: 0, width: 40, height: 40) : CGRect(x: 0, y: 0, width: 20, height: 20)
            UIView.animate(withDuration: 0.2) {
            self.frame = newFrame
            self.label.frame = newFrame.offsetBy(dx: 0, dy: -6)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        if let image = UIImage(named: "kk") {
            // Рассчитываем масштаб так, чтобы изображение поместилось и сохраняло пропорции
            let scale = min(rect.width / image.size.width, rect.height / image.size.height)
            let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            let newRect = CGRect(x: rect.midX - newSize.width / 2,
                                 y: rect.midY - newSize.height / 2,
                                 width: newSize.width,
                                 height: newSize.height)

            // Рисуем изображение в новом размере
            image.draw(in: newRect)
        }
    }



}

class MapVC: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, MKMapViewDelegate
{
    let customAnnotationView = CustomAnnotationView()
    let locationManager = CLLocationManager()
    var coordinatesArray = [CLLocationCoordinate2D]()
    var annotationsArray = [MKAnnotation]()
    var overlaysArray = [MKOverlay]()
    
    let mapView: MKMapView = {
        let control = MKMapView()
        control.layer.cornerRadius = 15
        control.layer.masksToBounds = true
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        control.showsScale = true
        control.showsCompass = true
        control.showsTraffic = true
        control.showsBuildings = true
        control.showsUserLocation = true
        return control
    }()
    
    
    let startLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.gray
        control.textColor = UIColor.white
        control.placeholder = "From"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.go
        control.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    
    let finishLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.gray
        control.textColor = UIColor.white
        control.placeholder = "To"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.go
        control.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    let clearButton: UIButton = {
        let control = UIButton()
        control.addTarget(self, action: #selector(clearMap), for: .touchUpInside)
        control.setTitle("Clear!", for: .normal)
        control.backgroundColor = UIColor.blue
        control.titleLabel?.textColor = UIColor.white
        control.layer.cornerRadius = 4
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let goButton: UIButton = {
        let control = UIButton()
        control.addTarget(self, action: #selector(getYourRoute), for: .touchUpInside)
        control.setTitle("Go!", for: .normal)
        control.backgroundColor = UIColor.blue
        control.titleLabel?.textColor = UIColor.white
        control.layer.cornerRadius = 4
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    @objc func clearMap() {
            coordinatesArray.removeAll()
            annotationsArray.removeAll()
            overlaysArray.removeAll()
            mapView.removeAnnotations(mapView.annotations)
            mapView.removeOverlays(mapView.overlays)
            startLocation.text = ""
            finishLocation.text = ""
            
            if let userLocation = locationManager.location?.coordinate {
                let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
                mapView.setRegion(region, animated: true)
                

            }
        }
    
    
    
    @objc
    func getYourRoute(_ sender: UIButton) {
        dismissKeyboard()
        let completion1 = doAfterOne
        
        if self.mapView.annotations.count > 0 {
            self.mapView.removeAnnotations(self.annotationsArray)
            self.annotationsArray = []
        }
        
        if self.overlaysArray.count > 0 {
            self.mapView.removeOverlays(self.overlaysArray)
            self.overlaysArray = []
        }
        
        self.coordinatesArray = []
        
        if ( // self.startLocation.text!.count == 0 ||
            self.finishLocation.text!.count == 0 ||
            self.startLocation == self.finishLocation) {
            return
        }
        
        if self.startLocation.text!.count == 0 {
            guard let sourceCoordinate = locationManager.location?.coordinate else { return }
            //            showCurrent(coordinates: sourceCoordinate, completion: completion1)
            self.coordinatesArray.append(sourceCoordinate)
            doAfterOne()
        } else {
            DispatchQueue.global(qos: .utility).async {
                self.findLocation(location: self.startLocation.text!, showRegion: false, completion: completion1)
            }
        }
    }
    private func findLocation(location: String, showRegion: Bool = false, completion: @escaping () -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                let coordinates = placemark.location!.coordinate
                self.coordinatesArray.append(coordinates)
                let point = MKPointAnnotation()
                point.coordinate = coordinates
                point.title = location
                
                if let country = placemark.country {
                    point.subtitle = country
                }
                
                self.mapView.addAnnotation(point)
                self.annotationsArray.append(point)
                
                if showRegion {
                    self.mapView.centerCoordinate = coordinates
                    let span = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
                    let region = MKCoordinateRegion(center: coordinates, span: span)
                    self.mapView.setRegion(region, animated: showRegion)
                }
            } else {
                print(String(describing: error))
            }
            completion()
        }
    }
    
    
    private func showCurrent(coordinates: CLLocationCoordinate2D, showRegion: Bool = false, completion: @escaping () -> Void ) {
        
        self.coordinatesArray.append(coordinates)
        let point = MKPointAnnotation()
        point.coordinate = coordinates
        point.title = ""
        point.subtitle = ""
        
        self.mapView.addAnnotation(point)
        self.annotationsArray.append(point)
        
        if showRegion {
            self.mapView.centerCoordinate = coordinates
            let span = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            self.mapView.setRegion(region, animated: showRegion)
        }
        completion()
    }
    
    
    private func doAfterOne() {
        let completion2 = findLocations
        DispatchQueue.global(qos: .utility).async {
            self.findLocation(location: self.finishLocation.text!, showRegion: true, completion: completion2)
        }
    }
    
    
    private func findLocations() {
        if self.coordinatesArray.count < 2 {
            return
        }
        
        let markLocationOne = MKPlacemark(coordinate: self.coordinatesArray.first!)
        let markLocationTwo = MKPlacemark(coordinate: self.coordinatesArray.last!)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: markLocationOne)
        directionRequest.destination = MKMapItem(placemark: markLocationTwo)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            if error != nil {
                print(String(describing: error))
            } else {
                let myRoute: MKRoute? = response?.routes.first
                if let a = myRoute?.polyline {
                    if self.overlaysArray.count > 0 {
                        self.mapView.removeOverlays(self.overlaysArray)
                        self.overlaysArray = []
                    }
                    self.overlaysArray.append(a)
                    self.mapView.addOverlay(a)
                    
                    // Настройка отображения маршрута на карте
                    let rect = a.boundingMapRect
                    self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                    
                    self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
                    view.addGestureRecognizer(tap)
            setupUI()
        }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
        
        
        override func viewWillAppear(_ animated: Bool) {
            startMap()
        }
        
        
        private func startMap() {
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
            }
        }
        
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation = locations[0] as CLLocation
            manager.stopUpdatingLocation()
            
            let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
                if let customAnnotationView = view as? CustomAnnotationView {
                customAnnotationView.isSelected = true
            }
        }
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
                if let customAnnotationView = view as? CustomAnnotationView {
                    customAnnotationView.isSelected = false
            }
        }
        
    private func setupUI() {
            startLocation.delegate = self
            finishLocation.delegate = self
            locationManager.delegate = self
            mapView.delegate = self
            
            self.view.addSubview(startLocation)
            self.view.addSubview(finishLocation)
            self.view.addSubview(goButton)
            self.view.addSubview(clearButton)
            self.view.addSubview(mapView)
            
            locationManager.startUpdatingLocation()
            
            clearButton.pinRight(to: view)
            clearButton.pinTop(to: view, 50)
            clearButton.setWidth(78)
            clearButton.setHeight(34)
            
            goButton.pinRight(to: view)
            goButton.pinTop(to: clearButton, 44)
            goButton.setHeight(34)
            goButton.setWidth(78)
            
            startLocation.pinLeft(to: view)
            startLocation.pinTop(to: view, 50)
            startLocation.pinRight(to: goButton, 88)
            startLocation.setHeight(34)
            
            finishLocation.pinLeft(to: view)
            finishLocation.pinTop(to: startLocation, 44)
            finishLocation.pinRight(to: goButton, 88)
            finishLocation.setHeight(34)
            
            mapView.pinLeft(to: view)
            mapView.pinTop(to: finishLocation, 44)
            mapView.pinRight(to: view)
            mapView.pinBottom(to: view)
        }
        
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            if overlay is MKPolyline {
                polylineRenderer.strokeColor = UIColor.green
                polylineRenderer.lineWidth = 4
            }
            return polylineRenderer
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            guard annotation is MKPointAnnotation else { return nil }

            let customAnnotationView = self.customAnnotationView(in: mapView, for: annotation)
            
            return customAnnotationView
        }
        
        private func customAnnotationView(in mapView: MKMapView, for annotation: MKAnnotation) -> CustomAnnotationView {
            let identifier = "CustomAnnotationViewID"

            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let customAnnotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                customAnnotationView.canShowCallout = true
                return customAnnotationView
            }
        }
    
        
    }
