//
//  PayOrderTwo.swift
//  allOrder
//
//  Created by Александр Белый on 15.12.2024.
//

import SwiftUI
import Foundation


struct OrderTwo:View {
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

struct ButtonContinueTwo: View {
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


struct ContentViewOrderTwo: View {
    var body: some View {
        VStack {
            OrderOne(image: "pay", thankYouForOrder: "Cпасибо за заказ", titleDescription: "Обратите внимание, что у неоплаченных\nзаказов ограниченный срок хранения")
            
                .padding(.bottom, 24)
            
            ButtonContinue(title: "Продолжить покупки", backColor: .red) {
                
            }
        }
        .padding()
            Text("Статус заказа")
                .font(.system(size: 16))
                .foregroundStyle(Color.red)
                .onTapGesture {
                   print("статус нажат")
                }
                
            
            
        
        
    }
}



#Preview {
    ContentViewOrderTwo()
}
