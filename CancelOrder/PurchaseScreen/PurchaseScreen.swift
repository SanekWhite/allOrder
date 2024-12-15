//
//  PurchaseScreen.swift
//  allOrder
//
//  Created by Александр Белый on 13.12.2024.
//

import SwiftUI

class ViewModelOrder: ObservableObject {
    @Published var viewModel: [PurchaseOrderViewModel] = [
        .init(rings: [
            .init(
                id: UUID(),
                totalOrder: "Вы можете изменить параметры и состав заказа в корзине",
                titleRing: "Золотое плоское обручальное кольцо",
                titleQuanityAndSize: "1 шт. • Размер: 17",
                priceDiscount: 24000,
                price: 23000,
                imageURL: "https://pngicon.ru/file/uploads/obruchalnie_kolca.png"
            ),
            .init(
                id: UUID(),
                totalOrder: "Вы можете изменить параметры и состав заказа в корзине",
                titleRing: "Золотое плоское обручальное кольцо",
                titleQuanityAndSize: "1 шт. • Размер: 17",
                priceDiscount: 24000,
                price: 23000,
                imageURL: "https://pngicon.ru/file/uploads/obruchalnie_kolca.png"
            )
            
        ],
              banks: [
                .init(id: UUID(), nameBank: "SberPay", titleBank: "Через приложение СберБанк", imageURL: "https://png.klev.club/uploads/posts/2024-03/png-klev-club-p-sberbank-logotip-png-1.png"),
                .init(id: UUID(), nameBank: "Банковской картой", titleBank: "Visa, Master Card, Мир", imageURL: "https://png.pngtree.com/png-clipart/20190617/original/pngtree-banking-card-vector-icon-png-image_3876273.jpg"),
                .init(id: UUID(), nameBank: "Яндекс Пэй со Сплитом", titleBank: "Оплата частями", imageURL: "https://ps.w.org/yandex-pay/assets/icon-256x256.png?rev=2644923"),
                .init(id: UUID(), nameBank: "Рассрочка Тинькофф", titleBank: "На 3 месяца без переплат", imageURL: "https://www.gateline.net/wp-content/uploads/Лого-Тинькофф_2.png"),
                .init(id: UUID(), nameBank: "Tinkoff Pay", titleBank: "Через приложение Тинькофф", imageURL: "https://filearchive.cnews.ru/img/book/2022/05/23/tinkof_pej.jpg"),
                .init(id: UUID(), nameBank: "Оплатить при получении", titleBank: "Наличными или картой", imageURL: "https://cdn-icons-png.flaticon.com/512/482/482544.png"),
                
              ],
              promocodes: [
                .init(
                    id: UUID(),
                    title: "Hello",
                    titleOneOrder: nil,
                    percent: 5,
                    endDate: Date(),
                    info: "-5%",
                    active: false
                ),
                .init(
                    id: UUID(),
                    title: "Vesna23",
                    titleOneOrder: "Промокод действует на первый заказ\nв приложении",
                    percent: 5,
                    endDate: Date(),
                    info: "-5%",
                    active: false
                )
              ],
              
              paymentDiscount: 10,
              baseDiscount: 10
        )
    ]
    var updateHandler: (() -> Void)?
    
    func togglePromoActive(promoID: UUID) {
        for (index, order) in viewModel.enumerated() {
            for (promoIndex, promo) in order.promocodes.enumerated() where promo.id == promoID {
                viewModel[index].promocodes[promoIndex].active.toggle()
            }
        }
        
        updateHandler?()
    }
    
}



struct CustomButtonBank: View {
    
    var nameBank: String
    var titleBank: String
    @Binding var isSelected: Bool
    var action: () -> ()
    // var bankDiscount: Double
    
    var body: some View {
        Button(action: {
            action()
            isSelected.toggle()
        }) {
            HStack() {
                VStack(alignment: .leading) {
                    HStack {
                        Text(nameBank)
                        
                        Text("-5%")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 12))
                            .frame(width: 37, height: 20)
                            .background(Color.black)
                            .cornerRadius(12)
                        
                    }
                    
                    Text(titleBank)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "record.circle" : "circle")
                    .foregroundStyle(isSelected ? .red : .gray)
                    .frame(width: 24, height: 24)
            }
        }
    }
}

struct CustomImageURL: View {
    
    let imageUrl: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct CustomPromo: View {
    
    var namePromo: String
    var titleOneOrder: String
    var titleInfo: String
    var promocodeEndDate: Date
    @Binding var isActive: Bool
    
    var body: some View {
        
        
        
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                
                Text(namePromo)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.black)
                    .font(.system(size: 16))
                    .padding([.leading, .top], 12)
                
                
                
                Text(titleInfo)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12))
                    .frame(width: 37, height: 20)
                    .background(Color.green)
                    .cornerRadius(12)
                    .padding(.top, 12)
                
                Image(systemName: "exclamationmark.circle")
                    .foregroundStyle(Color.gray)
                    .padding(.top, 12)
                Spacer()
                
                Toggle(isOn: $isActive) {
                    
                }
                
                .toggleStyle(SwitchToggleStyle(tint: .red))
                .padding([.trailing, .top], 12)
            }
            
            Text(formattedEndDate(for: promocodeEndDate))
                .foregroundStyle(Color.gray)
                .font(.system(size: 14))
                .padding(.leading, 12)
            
            if !titleOneOrder.isEmpty {
                Text(titleOneOrder)
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14))
                    .padding(12)
            }
            
            
        }
        .background(Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255, opacity: 1))
        
        .cornerRadius(12)
    }
    
    func formattedEndDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        return "По \(dateFormatter.string(from: date))"
    }
}

struct CustomApplyButtonPromo: View {
    
    var title: String
    var foregroundStyle: Color
    var backgroundColor: Color
    var cornerRadius: Int
    var width: CGFloat
    var height: CGFloat
    var action: () -> ()
    
    var body: some View {
        
        Button(action: action) {
            Text(title)
                .foregroundStyle(foregroundStyle)
                .frame(width: width, height: height, alignment: .center)
                .background(backgroundColor)
                .cornerRadius(12)
            
        }
        
    }
}

struct HidePromoCodes: View {
    
    var title: String
    var action: () -> ()
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16))
                    .foregroundStyle((Color(red: 255 / 255, green: 70 / 255, blue: 17 / 255, opacity: 1)))
            }
        }
    }
}

struct SummTable: View {
    var titlePriceForItems: String
    var titleDiscounts: String
    var titlePromocodes: String
    var titlePaymentMethod: String
    var titleTotal: String
    
    // Добавляем привязки для значений, которые будут обновляться
    @Binding var totalPriceForItems: String
    @Binding var totalDiscounts: String
    @Binding var totalPromocodes: String
    @Binding var totalPaymentMethod: String
    @Binding var totalFinal: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Цена за товары
            HStack {
                Text(titlePriceForItems)
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                Spacer()
                Text(totalPriceForItems)
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
            }
            
            // Скидки
            HStack {
                Text(titleDiscounts)
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                Spacer()
                Text(totalDiscounts)
                    .font(.system(size: 14))
                    .foregroundStyle(.red)
                    .padding(.horizontal)
            }
            
            // Промокоды
            HStack {
                
                Text(titlePromocodes)
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                Image(systemName: "exclamationmark.circle")
                    .foregroundStyle(Color.blue)
                
                
                Spacer()
                Text(totalPromocodes)
                    .font(.system(size: 14))
                    .foregroundStyle(.green)
                    .padding(.horizontal)
            }
            
            // Способ оплаты
            HStack {
                Text(titlePaymentMethod)
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                Spacer()
                Text(totalPaymentMethod)
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
            }
            
            
            Spacer()
            
            // Итого
            HStack {
                Text(titleTotal)
                    .font(.system(size: 18))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                Spacer()
                Text(totalFinal)
                    .font(.system(size: 18))
                    .foregroundStyle(.black)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}


struct Pay: View {
    var pay: String
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(pay)
                .foregroundStyle(.white)
                .font(.system(size: 16))
                .frame(width: 330, height: 54)
                .background(Color.red)
                .cornerRadius(12)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

struct PurchaseScreen: View {
    @ObservedObject var viewModelOrder: ViewModelOrder
    @State private var selectedBankStates: [UUID: Bool] = [:]
    @State private var showPromocodes: Bool = true
    @State private var activePromoCodes: Bool = false
    
    @State private var totalPriceForItems = "0 ₽"
    @State private var totalDiscount = "0 ₽"
    @State private var totalPromocodes = "0 ₽"
    @State private var totalPaymentMethod = "0 ₽"
    @State private var totalFinal = "0 ₽"
    @State private var randomScreen: Int = 1
    
  
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                List {
                    Text("Состав заказа")
                        .font(.system(size: 24, weight: .bold))
                    
                    if let headerText = viewModelOrder.viewModel.first?.rings.first?.totalOrder {
                        
                        
                        Text(headerText)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 8)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    
                    
                    // Список колец
                    ForEach(viewModelOrder.viewModel) { order in
                        ForEach(order.rings) { ring in
                            HStack(spacing: 16) {
                                CustomImageURL(imageUrl: ring.imageURL, width: 80, height: 80, cornerRadius: 8)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(ring.titleRing)")
                                        .font(.system(size: 14))
                                    Text("\(ring.titleQuanityAndSize)")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.gray)
                                    Text("\(ring.price, specifier: "%.2f") ₽")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                    Text("\(ring.priceDiscount, specifier: "%.2f") ₽")
                                        .foregroundColor(.black)
                                }
                            }
                            
                            
                        }
                        
                        Divider()
                            .background(Color.gray)
                            .frame(height: 16)
                        
                        Text("Способ Оплаты")
                            .font(.system(size: 24, weight: .bold))
                        
                        ForEach(order.banks) { bank in
                            HStack {
                                CustomImageURL(imageUrl: bank.imageURL, width: 24, height: 24, cornerRadius: 8)
                                
                                
                                CustomButtonBank(
                                    nameBank: bank.nameBank,
                                    titleBank: bank.titleBank,
                                    isSelected: Binding(
                                        get: { selectedBankStates[bank.id] ?? false },
                                        set: { newValue in
                                            if newValue {
                                                
                                                selectedBankStates = [bank.id: true]
                                            } else {
                                                selectedBankStates.removeValue(forKey: bank.id)
                                            }
                                        }
                                    )
                                ) {
                                    print("\(bank.nameBank) button tapped")
                                }
                                
                                
                            }
                        }
                        Divider()
                            .background(Color.gray)
                            .frame(height: 16)
                        
                        Text("Промокоды")
                            .font(.system(size: 24, weight: .bold))
                        
                        Text("На один товар можно применить только один промокод")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.gray)
                            .multilineTextAlignment(.leading)
                        VStack {
                            
                            CustomApplyButtonPromo(title: "Применить промокод", foregroundStyle: .red, backgroundColor: (Color(red: 255 / 255, green: 70 / 255, blue: 17 / 255, opacity: 0.1)), cornerRadius: 12, width: 370, height: 54) {
                                
                            }
                        }
                        
                        if showPromocodes {
                            ForEach(order.promocodes) { promocode in
                                CustomPromo(
                                    namePromo: promocode.title,
                                    titleOneOrder: promocode.titleOneOrder ?? "",
                                    titleInfo: promocode.info ?? "", promocodeEndDate: promocode.endDate,
                                    isActive: Binding(
                                        get: { promocode.active },
                                        set: { newValue in viewModelOrder.togglePromoActive(promoID: promocode.id)
                                            
                                        }
                                    )
                                )
                            }
                        }
                        
                        
                        HidePromoCodes(title: showPromocodes ? "Скрыть промокоды" : "Показать промокоды") {
                            showPromocodes.toggle()
                            
                            
                        }
                        VStack {
                            SummTable(
                                titlePriceForItems: "Цена за два товара",
                                titleDiscounts: "Скидки",
                                titlePromocodes: "Промокоды",
                                titlePaymentMethod: "Способ оплаты",
                                titleTotal: "Итого",
                                totalPriceForItems: $totalPriceForItems,
                                totalDiscounts: $totalDiscount,
                                totalPromocodes: $totalPromocodes,
                                totalPaymentMethod: $totalPaymentMethod,
                                totalFinal: $totalFinal
                            )
                            
                            NavigationLink(destination: destinationView(randomScreen)) {
                                
                                Pay(pay: "Оплатить") {
                                    randomScreen = Int.random(in: 1...4)
                                }
                                
                            }
                            
                            .padding()
                            Text("Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с Условиями оферты")
                                .foregroundStyle(Color.gray)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 12))
                                .padding(.bottom)
                        }
                        .background((Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255, opacity: 1)))
                    }
                    
                    .listRowSeparator(.hidden)
                }
                .backgroundStyle(Color.white)
                .listStyle(PlainListStyle())
                
                
            }
            .navigationTitle("Оформление заказа")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
        .onAppear {
            viewModelOrder.updateHandler = setupUpdate // Передаем функцию для обновления
        }
    }
    
    func setupUpdate() {
        
        var totalPrice: Double = 0
        var totalDiscounts: Double = 0
        var totalPromoCodesDiscount: Double = 0
        
        for order in viewModelOrder.viewModel {
            
            let orderTotalPrice = order.rings.reduce(0) { $0 + $1.price }
            totalPrice += orderTotalPrice
            
            
            for promo in order.promocodes where promo.active {
                totalPromoCodesDiscount += orderTotalPrice * (Double(promo.percent) / 100)
            }
        }
        
      
        totalDiscounts = totalPromoCodesDiscount
        
        
        let finalTotal = totalPrice - totalDiscounts
        

        totalPriceForItems = "\(Int(totalPrice)) ₽"
        totalDiscount = "\(Int(totalDiscounts)) ₽"
        totalPromocodes = "\(Int(totalPromoCodesDiscount)) ₽"
        totalFinal = "\(Int(finalTotal)) ₽"
    }
    
    func destinationView(_ screen: Int) -> some View {
        switch screen {
        case 1:
            return AnyView(ContentViewOrder())
        case 2:
            return AnyView(ContentViewOrderTwo())
        case 3:
            return AnyView(ContentViewOrderThree())
        case 4:
            return AnyView(ContentViewOrderFour())
        default:
            return AnyView(ContentViewOrder())
        }
    }
}








#Preview {
    PurchaseScreen(viewModelOrder: ViewModelOrder())
}
