//
//  Constants.swift
//  DailyNews
//
//  Created by Fawaz Faiz on 29/07/2021.
//

import Foundation

    // App Strings
    public struct Strings {
        
        // Common strings
        static let no_internet   = "Please check your internet connection and try again later."
        static let messageNoData = "No news to display. Please try again later."
        
        // Home
        static let homePageTitle = "Most Popular"
        
        // Button Titles
        static let readMoreBtnTitle = "Read More..."
        
        // Segue Ideantifies
        static let homeToDetail = "homeDetailSegue"
       
    }

enum newsTitle : String {
    case popular = "Most Popular"
}


