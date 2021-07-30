//
//  UrlDirectory.swift
//  DailyNews
//
//  Created by D&C Dev on 28/07/2021.
//

import Foundation
class UrlDirectory: NSObject {
// Registerd Api Key on NY Developer Page
static let apiKey = "RV2Ggx4ixFPyAM4MV3fnwr21Qfwpt1A9"
static let apiHeader = "api-key"
static let baseUrl = "http://api.nytimes.com/"
    
    /// API End Point
    enum Endpoint: String {
        // Popular News Api
        case popularNewsApi = "svc/mostpopular/v2/viewed/"
    }
    
    // End Point API Call for Popular News
    // - Parameter days: as String
    static func getPopularNewsApi(for days: Int = 1) -> String {
        let params = "\(UrlDirectory.apiHeader)=\(UrlDirectory.apiKey)"
        let link   = "\(Endpoint.popularNewsApi.rawValue)\(days).json?\(params)"
        
        return link
    }
}
