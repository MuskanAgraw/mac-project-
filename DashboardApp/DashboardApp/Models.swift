//
//  Models.swift
//  DashboardApp
//
//  Created by Karan Shukla on 21/05/24.
//

import Foundation

struct Link: Identifiable, Codable {
    let id: Int
    let title: String
}

struct ChartData: Identifiable, Codable {
    let id: Int
    let value: Double
}

struct ApiResponse: Codable {
    let topLinks: [Link]
    let recentLinks: [Link]
    let chartData: [ChartData]
}
