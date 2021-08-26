//
//  UserDefaultsStorage.swift
//  iosApp
//
//  Created by Jakkidi Chandrasekhar Reddy on 03/08/21.
//  Copyright © 2021 orgName. All rights reserved.
//

import Foundation

class UserDefaultsStorage {
    private static var sharedInstance: UserDefaultsStorage?
    
    class var shared : UserDefaultsStorage {
        guard let instance = self.sharedInstance else {
            let strongInstance = UserDefaultsStorage()
            self.sharedInstance = strongInstance
            return strongInstance
        }
        return instance
    }
    
    var units: Any? {
        set {
            setValueToDefaults(with: newValue, and: UserDefaultkeys.units.rawValue)
        }
        get {
            return getValueFromDefaults(with:UserDefaultkeys.units.rawValue)
        }
    }
}

private extension UserDefaultsStorage {
    func setValueToDefaults(with value: Any?, and key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func getValueFromDefaults(with key: String) -> Any? {
        return UserDefaults.standard.value(forKey:key)
    }
    
    func setObjectToDefaults(with object: Any?, and key: String) {
        do {
            guard let unWrappedObject = object else { return }
            
            let objectData = try NSKeyedArchiver.archivedData(withRootObject: unWrappedObject, requiringSecureCoding: false)
            UserDefaults.standard.setValue(objectData, forKey: key)
        } catch  {}
    }
    
    func getObjectFromDefaults(for key: String) -> Any? {
        do {
            guard let decodedData  = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
            
            let decodedObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData)
            
            return decodedObject
        } catch {}
        
        return nil
    }
}

enum UserDefaultkeys: String {
    case units = "Units"
}
