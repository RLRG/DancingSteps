//
//  Constants.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: - EVENTBRITE API
    
    // MARK: General data
    static let EventBriteAPI = "https://www.eventbriteapi.com/v3/"
    static let AnonymousAccessTokenParameter = "token"
    static let AnonymousAccessToken = "GOFDC4WEPOGSMDHTPOIB"
    
    // MARK: Events Web Service
    static let eventsService = "events/search"
    static let categoryParameter = "categories"
    static let subcategoryParameter = "subcategories"
    static let categoryValue = "105" // Category: "Performing & Visual Arts" - https://www.eventbriteapi.com/v3/categories/105/?token=GOFDC4WEPOGSMDHTPOIB
    static let subcategoryValue = "5004" // Subcategory: "Dance" - https://www.eventbriteapi.com/v3/subcategories/5004/?token=GOFDC4WEPOGSMDHTPOIB
    static let eventsURL = "\(eventsService)/?\(AnonymousAccessTokenParameter)=\(AnonymousAccessToken)&\(categoryParameter)=\(categoryValue)&\(subcategoryParameter)=\(subcategoryValue)"
}
