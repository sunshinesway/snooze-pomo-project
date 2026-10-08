//
//  StoreSettings.swift
//  snooze-pomo
//
//  Created by Cheyenne C Swasey on 10/8/26.
//

import Foundation

protocol SettingsStore {
    func load() -> PomoSettings?
    func save(_ settings: PomoSettings)
}

struct UserDefaultsSettingsStore: SettingsStore {
    private let defaults: UserDefaults
    private let key: String = "pomoSettings"
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func load() -> PomoSettings? {
        guard let data = defaults.data(forKey: key) else {return nil}
        return try? JSONDecoder().decode(PomoSettings.self, from: data)
    }
    

    func save(_ settings: PomoSettings) {
        guard let data = try? JSONEncoder().encode(settings) else {return}
        defaults.set(data, forKey: key)
    }
}
