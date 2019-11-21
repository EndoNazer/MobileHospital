//
//  Events.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

enum Events: Hashable {
    case UnauthEvent
    case MessageEvent
    
    case ShowLoader
    case HideLoader
}

extension Events {
    
    func getEventTag() -> String {
        return "\(hashValue)"
    }
    
    func post() {
        EventBus.post(getEventTag())
    }
    
    func post(_ sender: Any?) {
        EventBus.post(getEventTag(), sender: sender)
    }
    
}
