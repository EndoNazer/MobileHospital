//
//  UseCase.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

class UseCase<T> {

    func execute() -> Response<T> {
        return Response(nil, ERROR_EMPTY)
    }

    func backgroundWithoutExecutor(execute work: @escaping (_ ui:UI) -> Void) -> Job {
        let job = Job()
        let ui = UI(job)
        let item = DispatchWorkItem {
            do {
                work(ui)
            } catch {
                // TODO Errors
            }
        }

        DispatchQueue.global(qos: .background).async (execute: item)
        job.addWorkItem(item)
        return job
    }

    func background(_ work: @escaping  (_ ui:UI, _ executorMethod: () -> Response<T>) -> Void) -> Job {
        let useCase = self
        let job = Job()
        let ui = UI(job)
        let item = DispatchWorkItem {
            do {
                work(ui, { useCase.execute() })
            } catch {
                // TODO Errors
            }
        }

        DispatchQueue.global(qos: .background).async (execute: item)

        job.addWorkItem(item)
        return job
    }
}

class Job {
    private var workItems: [DispatchWorkItem] = []

    func addWorkItem(_ item: DispatchWorkItem) {
        workItems.append(item)
    }
    
    func cancel() {
        for item in workItems {
            item.cancel()
        }
    }
}

class UI {
    let job: Job
    
    init(_ job: Job) {
        self.job = job
    }
    
    func post(_ data: @escaping  () -> Void) {
        let item = DispatchWorkItem {
            do {
                data()
            } catch {
                // TODO Errors
            }
        }
        
        job.addWorkItem(item)
        DispatchQueue.main.async (execute: item)
    }
}
