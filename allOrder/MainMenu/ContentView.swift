//
//  ContentView.swift
//  allOrder
//
//  Created by Александр Белый on 10.12.2024.
//

import SwiftUI

struct PromoViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PromoViewController {
        return PromoViewController()
    }
    
    func updateUIViewController(_ uiViewController: PromoViewController, context: Context) {
        
    }
}

struct ReViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ReviewViewController {
        return ReviewViewController()
    }
    
    func updateUIViewController(_ uiViewController: ReviewViewController, context: Context) {
        
    }
}



struct CustomButtons: View {
    var title: String
    var backgroundColor: Color

    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(backgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.white, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                List {
                    NavigationLink(destination: PromoViewWrapper()) {
                        CustomButtons(title: "Ввод промокода", backgroundColor: .red)
                    }
                    .listRowBackground(Color.clear)
                    
                    NavigationLink(destination: ReViewWrapper()) {
                        CustomButtons(title: "Отзыв", backgroundColor: .red)
                    }

                    .listRowBackground(Color.clear)
                    
                    NavigationLink(destination: ContentViewNew()) {
                        CustomButtons(title: "Отмена заказа", backgroundColor: .red)
                    }

                    .listRowBackground(Color.clear)
                    
                    NavigationLink(destination:  PurchaseScreen(viewModelOrder: ViewModelOrder())) {
                        CustomButtons(title: "Заказ", backgroundColor: .red)
                    }
                    
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden) // Убирает фон списка, чтобы он стал прозрачным
            }
        }
    }
}


struct Promo: View {
    var body: some View {
        Text("gello")
    }
}




#Preview {
    ContentView()
}
