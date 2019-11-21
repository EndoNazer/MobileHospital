//
//  Model.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class User {
    var id: Int64 = 0
    var login: String = ""
    var password: String = ""
    var token: String = ""
}

class Doctor {
    
}

class Client {
    var id: Int64 = 0
    var siteUseCode: String = ""
    var sessionId: Int64 = 0
    var customerName: String = ""
    var orgId: Int64 = 0
    var concatenatedAddress: String = ""
    var zakazchik: String = ""
    var associationName: String = ""
    var associationId: Int64 = 0
    var associationGroupId: Int? = nil
    
    func isBillTo() -> Bool {
        return "BILL_TO" == siteUseCode
    }
}

class Delivery {
    var orderNumber: Int64 = 0
    var orderType: String = ""
    var billToSiteUseId: Int64 = 0
    var shipToSiteUseId: Int64 = 0
    var deliveryId: Int64 = 0
    var deliveryName: String = ""
    var statusName: String = ""
    var total: Double = 0
    var statusImplementation: String = ""
    var orderedDate: String = ""
    var billToLocation: String = ""
    var shipToLocation: String = ""
}

class Order {
    var orderNumber: Int64 = 0
    var orderType: String = ""
    var billToSiteUseId: Int64 = 0
    var shipToSiteUseId: Int64 = 0
    var deliveryId: Int64 = 0
    var deliveryName: String = ""
    var statusName: String = ""
    var total: Double = 0
    var statusImplementation: String = ""
    var orderedDate: String = ""
    var billToLocation: String = ""
    var shipToLocation: String = ""
    
    var positions: [OrderPosition] = []
}

class OrderPosition {
    var item: String = ""
    var orderNumber: Int64 = 0
    var deliveryId: Int64 = 0
    var requestedQuantity: Int = 0
    var shippedQuantity: Int = 0
    var itemDescription: String = ""
    var priceWithNds: Double = 0
}

class Claim {
    var id: String = ""
    var incidentId: Int64 = 0
    var incidentDate: String = ""
    var statusCode: String = ""
    var typeCode: String = ""
    var billToSiteUseId: Int64 = 0
    var shipToSiteUseId: Int64 = 0
    var lastUpdateDate: String = ""
    var clientMessage: String = ""
    var creationDate: String = ""
    var orderNumber: Int64 = 0
    var solutionName: String = ""
    var wshNaklName: String = ""
    var ontOrderNumber: String = ""
    var description: String = ""

    var positions: [ClaimPosition] = []
}

class ClaimPosition {
    var itemCode: String = ""
    var itemDescription: String = ""
    var producer: String = ""
    var quantity: Int64 = 0
    var amount: Double = 0.0
}

class Association {
    var groupId: Int = 0
    var groupDesc: String = ""
}

class Contact {
    var id: Int = 0
    var orgName: String = ""
    var tel: String = ""
    var position: String = ""
    var fio: String = ""
    var csId: Int = 0
    var insDate: Int64 = 0
    var modDate: Int64 = 0
    var positionType: String = ""
}

class News {
    var nIdx: Int = 0
    var nDate: String = ""
    var nTitle: String = ""
    var nPicture: String = ""
    var nText: String = ""
    var tezis: String = ""
    var priceFilter: Int = 0
    var actionDelete: Int = 0
    var insDate: Int64 = 0
    var modDate: Int64 = 0
}

class Promo {
    var atype: Int = 0
    var nmActions: Int = 0
    var promoName: String = ""
    var sdate: String = ""
    var edate: String = ""
    var description: String = ""
    var category: String = ""
    var promoTerm: Int = 0
    var isActive: Int = 0
    var plan: Int = 0
    var pictureType: Int = 0
    var informAction: Int = 0
    var promoBonus: String = ""
    var shipBill: Int = 0
    // Field ignored during data insert to DB
    //var promoConditions: [PromoConditionsModel] = []
}

//extension Claim {
//    func solutionColor() -> UIColor {
//        switch solutionName {
//        case "Удовлетворить":
//            return UIColor.Protek.Text.Green
//        case "Отклонить":
//            return UIColor.Protek.Text.Red
//        default:
//            return UIColor.Protek.Text.Sky
//        }
//    }
//}
