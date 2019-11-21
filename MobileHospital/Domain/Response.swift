//
//  Response.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

class Response<T> {
    var result: T?
    var error: UseCaseMessage

    init() {
        self.result = nil
        self.error = ERROR_EMPTY
    }

    init(_ data: T?, _ error: UseCaseMessage) {
        self.result = data
        self.error = error
    }
}


class UseCaseMessage: Error {
    var message: String?
    init(_ message: String?) {
        self.message = message
    }
}

class RequestError: UseCaseMessage {
    var code: Int
    init(_ code: Int, _ message: String?) {
        self.code = code
        super.init(message)
    }
}

class ResponseError: UseCaseMessage {
    var code: Int
    var errorBody: String?
    init(_ code: Int, _ message: String?, _ errorBody: String?) {
        self.code = code
        self.errorBody = errorBody
        super.init(message)
    }
}

class ProtekError: UseCaseMessage {
    var code: Int
    var status: String?
    init(_ code: Int, _ message: String?, _ status: String?) {
        self.code = code
        self.status = status
        super.init(message)
    }
}
