//
//  MainViewController + Beacon.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import CoreLocation

extension MainViewController: CLLocationManagerDelegate{
    func initializeLocationManager(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            rangeBeacons()                                          // --------------- 1
        }
    }
    
    func rangeBeacons(){
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            self.beaconRegion.notifyEntryStateOnDisplay = true
            self.beaconRegion.notifyOnExit = true
            self.beaconRegion.notifyOnEntry = true
            locationManager.startMonitoring(for: self.beaconRegion) // --------------- 2

        }else{
            print("CLLocation Monitoring is unavailable")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside {
            locationManager.startRangingBeacons(in: self.beaconRegion) // --------------- 5
        }else if state == .outside {
            locationManager.stopRangingBeacons(in: self.beaconRegion) // --------------- 8
        }else if state == .unknown {
            print("Now unknown of Region")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        localNotification(text: "You are now in COEX", identifier: "inside")          // --------------- 4
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        localNotification(text: "Bye Bye", identifier: "outside")                      // --------------- 7
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
                                                                            // --------------- 6
        if beacons.count > 0 {
            let nearestBeacon = beacons.first!
            
            UserDefaults.standard.loadBrands().forEach({
                if $0.store_beacon_minor == nearestBeacon.minor.intValue && currentBeaconMinor != nearestBeacon.minor.intValue{
                    currentBeaconMinor = nearestBeacon.minor.intValue
                    let store_name = $0.store_name
                    self.promotionInfo = []
                    APIService.shared.didConnected(store: $0.store_name, cards: UserDefaults.standard.loadCards(), completion: { (promotions) in
                        promotions.forEach({
                            self.promotionInfo.append("\(store_name)의 \($0.product_name)(을/를) \($0.product_promotion)% 할인받을 수 있습니다.")
                        })
                        self.promotionInfo.forEach({
                            self.localNotification(text: $0, identifier: $0)
                        })
                    })
                    
                    if nearestBeacon.proximity == .immediate {
                        APIService.shared.didClosed(at: store_name)
                    }
                }
            })
        }
    }
}
