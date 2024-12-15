//
//  ViewModels.swift
//  allOrder
//
//  Created by Александр Белый on 14.12.2024.
//
import SwiftUI
import Foundation

struct PurchaseOrderViewModel: Identifiable {
    let id = UUID() 
    var rings: [Ring]
    var banks: [Bank]
    var promocodes: [Promocode]
    
    struct Ring: Identifiable {
        let id: UUID
        let totalOrder: String
        let titleRing: String
        let titleQuanityAndSize: String
        let priceDiscount: Double
        let price: Double
        let imageURL: String
    }
    
    
    
    struct Bank: Identifiable {
        let id: UUID
        let nameBank: String
        let titleBank: String
        let imageURL: String
        
    }
    
    struct Promocode: Identifiable {
        let id: UUID
        let title: String
        let titleOneOrder: String?
        let percent: Int
        var endDate = Date()
        let info: String?
        var active: Bool
        
        
    }
    
 
    let paymentDiscount: Double?
    let baseDiscount: Double?
    
}


