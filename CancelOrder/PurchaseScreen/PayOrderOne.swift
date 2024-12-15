//
//  PayOrders.swift
//  allOrder
//
//  Created by Александр Белый on 15.12.2024.
//

import SwiftUI
import Foundation

struct OrderOne: View {
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

struct ButtonContinue: View {
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

struct ContentViewOrder: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
            
                OrderOne(image: "pay", thankYouForOrder: "Cпасибо за заказ", titleDescription: "Заказ успешно оформлен. Вы можете\nотслеживать его статус в личном\nкабинете.")
                    .padding(.bottom, 24)
                
           
                ButtonContinue(title: "Продолжить покупки", backColor: .red) {
              
                    presentationMode.wrappedValue.dismiss()
                }
                
                // Текст "Статус заказа"
                Text("Статус заказа")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.red)
                    .onTapGesture {
                        print("статус нажат")
                    }
                    .padding(.top, 24) 
            }
            .padding()
        }
    }
}

#Preview {
    ContentViewOrder()
}
