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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            rangeBeacons()                                          // --------------- 1
        }
    }
    
    func rangeBeacons(){
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            self.beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: beacons[0].uuid)!, identifier: beacons[0].identifier)
            self.beaconRegion.notifyEntryStateOnDisplay = true
            self.beaconRegion.notifyOnExit = true
            self.beaconRegion.notifyOnEntry = true
            locationManager.startMonitoring(for: self.beaconRegion) // --------------- 2
        }else{
            print("CLLocation Monitoring is unavailable")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Start Monitoring")                                   // --------------- 3
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside {
            print("State is inside")                                // --------------- 5
            locationManager.startRangingBeacons(in: self.beaconRegion)
        }else if state == .outside {
            print("State is outside")                               // --------------- 8
            locationManager.stopRangingBeacons(in: self.beaconRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnter at \(region.identifier)")                   // --------------- 4
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExit at \(region.identifier)")                    // --------------- 7
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
                                                                    // --------------- 6
        if beacons.count > 0 {
            let nearestBeacon = beacons.first!
            switch nearestBeacon.proximity {
            case .far:
                print("far")
                break
            case .near:
                print("near")
                break
            case .immediate:
                print("It's on your face")
                break
            case .unknown:
                print("unknown")
            }
        }
    }
}
