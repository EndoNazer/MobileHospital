//
//  BasePresenter.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit

class BasePresenter<T: BaseView> {
    let viewState : T
    var jobs : [Job] = []
    
    init(viewState: T) {
        self.viewState = viewState
    }

    func destroy() {
        for job in jobs {
            job.cancel()
        }
    }
    
    deinit {
        destroy()
        unRegisterEvents()
    }
    
    func registerEventOnMainThread<K>(_ event: Events, handler: @escaping (K?) -> Void) {
        EventBus.onMainThread(self, name: event.getEventTag()) { result in
            handler(result?.object as? K)
        }
    }
    
    func unRegisterEvents() {
        EventBus.unregister(self)
    }
    
    func unRegisterEvent(eventTag: String) {
        EventBus.unregister(self, name: eventTag)
    }
} 
