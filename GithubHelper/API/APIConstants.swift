//
//  Constants.swift
//  ItunesSearch
//
//  Created by Mahmoud Amer on 9/14/18.
//  Copyright © 2018 Amer. All rights reserved.
//

import Foundation
import UIKit

public enum APIConstants: String {
    case baseSearchURL = "https://api.github.com/search/repositories?"
}

enum NetworkError: String {
    case networkError = "No internet connection"
    case jsonError = "Error decoding json"
    case noResponseError = "No response from server"
}
