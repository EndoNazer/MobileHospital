//
//  MainInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import Firebase

class MainInteractor: BaseInteractor {//<T: BaseModel>: BaseInteractor<T> {
    
    override func execute() -> Response<Void> {
//        let client: Client? = SessionData.SelectedClient.getValue()
//        let response: Response<ProtekDataModel<ReturnablePackagesModel>> = provider.response(apiService: ProtekService.loadReturnablePackages(customerId: Int(client?.id ?? 0)))
//        if let result = response.result, result.status?.asInt() == 0 {
//            return Response<ReturnablePackagesModel?>(response.result?.data, response.error)
//        } else {
//            return Response<ReturnablePackagesModel?>(nil, response.error)
//        }
        return Response()
    }
    
}
