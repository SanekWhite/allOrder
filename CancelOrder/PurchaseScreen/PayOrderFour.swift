//
//  PayOrderFour.swift
//  allOrder
//
//  Created by Александр Белый on 15.12.2024.
//

import SwiftUI
import Foundation


struct OrderFour:View {
    var image: String
    var thankYouForOrder: String
    var titleDescription: String

  
    var body: some View {

            VStack {
                Image(image)
                    .padding(.bottom)
                Text(thankYouForOrder)
                    .font(.system(size: 24))
                    
                    .padding(.bottom, 10)
                Text(titleDescription)
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
          
            }
        
    }
}

struct ButtonContinueFour: View {
    var title: String
    var backColor: Color
    var action: () -> ()

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 16))
                .frame(width: 280, height: 54)
                .background(backColor)
                .cornerRadius(12)
        }
    }
}


struct ContentViewOrderFour: View {
    var body: some View {
        VStack {
            OrderOne(image: "payerror", thankYouForOrder: "Что-то пошло не так...", titleDescription: "К сожалению, ваш заказ не был создан")
            
                .padding(.bottom, 24)
            
            ButtonContinue(title: "Продолжить покупки", backColor: .red) {
                
            }
        }
     
                
            
            
        
        
    }
}

#Preview {
    ContentViewOrderFour()
}
