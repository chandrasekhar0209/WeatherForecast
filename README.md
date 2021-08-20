# GPSConnectivity

[![CI Status](https://img.shields.io/travis/Jakkidi Chandrasekhar Reddy/GPSConnectivity.svg?style=flat)](https://travis-ci.org/Jakkidi Chandrasekhar Reddy/GPSConnectivity)
[![Version](https://img.shields.io/cocoapods/v/GPSConnectivity.svg?style=flat)](https://cocoapods.org/pods/GPSConnectivity)
[![License](https://img.shields.io/cocoapods/l/GPSConnectivity.svg?style=flat)](https://cocoapods.org/pods/GPSConnectivity)
[![Platform](https://img.shields.io/cocoapods/p/GPSConnectivity.svg?style=flat)](https://cocoapods.org/pods/GPSConnectivity)

## About

This framework is used to get the User GPS Location in the form of Coordinates (Latitude and Longitude) with the help of users GPS Services of the device. It internally uses the default Apple’s Core Location framework and produces you the coordinates without any much time spent and with accurate results.

## Requirements

•    Mac OS
•    XCode
•    Swift 4.0
•    Deployment Target 11.0

## Installation

Run below mentioned commands in terminal.
•    If pod file doesn’t exist in your project.
o    pod init
o    pod install
o    Then open pod file and add below in pod file.
o    pod ‘GPSConnectivity’, :git=> ‘https://gitlab-ce.ivycomptech.co.in/NativeLayer/GPSConnectivity.git’
o    pod install
•    If pod file already exists, then add below in pod file.
o    pod ‘GPSConnectivity’, :git=> ‘https://gitlab-ce.ivycomptech.co.in/NativeLayer/GPSConnectivity.git’
o    pod install

## Usage

Step 1: Add below statements in Info.plist file of your project. Open it as source code.

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Display Message Location Always and When In Use Usage Description</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Display Message for Location When In Use Usage Description</string>
<key>UIBackgroundModes</key>
<array>
<string>location</string>
</array>

Step 2: Go to project target > Signing and Capabilities > + Capability and add Background Modes and enable Location Updates. (This step is to update the location of user when app is in background).


Step 3: Import the GPSConnectivity in view controller where you want the location to be triggered.
import GPSConnectivity

Step 4: Next you need to configure the GPSConnectivity framework by injecting view controller to conform the GPSConnectivty results protocol and Distance Filter (Auto location update after the given distance travelled by user in meters).

GPSConnectivity.sharedManager.configureGPS(withView: self, distanceFilter: 35.0)

Step 5: Conform the GPSConnectivityDelegate in your view controller to get the results.

    func gpsConnectivityResult(result: GPSConnectivity.GPSResult) {
        switch result {
        case .authorizationStatus(let status): ---> (This gives the authorization status of the user preferences)
        case .coordinates(let latitude, let longitude): ---> (This gives the latitude and longitude value of the user location)   
        case .error(let errorMessage): ---> (This gives the error message, if the location fetching did fail with some reason)
        }
    }

## Author

Jakkidi Chandrasekhar Reddy, jakkidi.reddy@ivycomptech.com

## License

GPSConnectivity is available under the MIT license. See the LICENSE file for more info.
