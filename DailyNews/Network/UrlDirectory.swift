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
        case mostSharedApi = "svc/mostpopular/v2/shared/"
        case mostEmailedApi = "svc/mostpopular/v2/emailed/"
    }
    
    // End Point API Call for Popular News
    // - Parameter days: as String
    static func getPopularNewsApi(for days: Int = 1) -> String {
        let params = "\(UrlDirectory.apiHeader)=\(UrlDirectory.apiKey)"
        let link   = "\(Endpoint.popularNewsApi.rawValue)\(days).json?\(params)"
        
        return link
    }
    
    static func getMostSharedNewsApi(for days: Int = 1) -> String {
        let params = "\(UrlDirectory.apiHeader)=\(UrlDirectory.apiKey)"
        let link   = "\(Endpoint.mostSharedApi.rawValue)\(days).json?\(params)"
        
        return link
    }
    
    static func getMostEmailedNewsApi(for days: Int = 1) -> String {
        let params = "\(UrlDirectory.apiHeader)=\(UrlDirectory.apiKey)"
        let link   = "\(Endpoint.mostEmailedApi.rawValue)\(days).json?\(params)"
        
        return link
    }
}
