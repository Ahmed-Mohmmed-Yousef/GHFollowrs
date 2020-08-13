//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Ahmed on 8/13/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

enum  GFError: String, Error {
    case invalidUsername    = "this username created an invalid request. please, try agan."
    case unableToComplete   = "Unable to complete your request. Please, check your network."
    case invalidResponse    = "Invalid response from server. Please, try again."
    case invalidData        = "The data recived from server was invalid, Please, try again"
}
