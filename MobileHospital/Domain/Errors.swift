//
//  Errors.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

let ERROR_EMPTY = ResponseError(0, nil, nil)
let ERROR_CANCELATION = RequestError(0, nil)
let ERROR_INTERNET_NOT_FOUND = RequestError(800, "Отсутсвует интернет соединение")
let ERROR_TIMEOUT = RequestError(900, "Превышено время ожидания")
let ERROR = RequestError(1000, "Произошла ошибка")
let ERROR_SERVER = RequestError(300, "Ошибка сервера")
let ERROR_AUTH = RequestError(401, "Ошибка авторизации")
