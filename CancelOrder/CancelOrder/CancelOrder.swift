//
//  Untitled.swift
//  allOrder
//
//  Created by Александр Белый on 12.12.2024.
//
import SwiftUI


struct CustomButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            Text(title)
            
                .multilineTextAlignment(.leading)
            
                .font(.custom(title, size: 16))
                .padding(.bottom, 10)
                .foregroundColor(.black)
            
                .padding(.bottom, 10)
                .background(backgroundColor)
            
            
        }
        
    }
}



struct CustomReturnMoney: View {
    var title: String
    
    var body: some View {
        Text(title)
        
            .font(.custom(title, size: 14))
           
            .frame(minWidth: 0, maxWidth: .infinity)
        //  .padding(.horizontal, 30)
            .padding(12)
        
            .multilineTextAlignment(.leading)
            .padding(.trailing, 80)
            .background((Color(red: 254 / 255, green: 247 / 255, blue: 222 / 255, opacity: 1)))
            .foregroundColor(.black)
        
            .cornerRadius(12)
        
        
        
    }
    
}

struct CustomCancelButton: View {
    
    var title: String
    var backgroundColor: Color
    var action: () -> ()
    
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom(title, size: 16))
            
            
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(20)
                .foregroundStyle(.white)
                .background(backgroundColor)
                .cornerRadius(12)
                .padding(.horizontal, 20)
            
        }
    }
}

struct SquareColor: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.clear, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.red)
                )
            Path { path in
                path.move(to: CGPoint(x: 6, y: 12)) // Начало галочки
                path.addLine(to: CGPoint(x: 10, y: 16)) // Середина галочки
                path.addLine(to: CGPoint(x: 16, y: 6)) // Конец галочки
            }
            .stroke(Color.white, lineWidth: 2)
        }
        .frame(width: 22, height: 22)
    }
}

struct EmptySquare: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.clear)
                )
        }
        .frame(width: 22, height: 22)
    }
}



struct ContentViewNew: View {
    
    @State private var username: String = ""
    @State private var showOtherTextField: Bool = false
    @State private var buttonStates: [Bool] = Array(repeating: false, count: 6) // Состояния для каждой кнопки
    @State private var showReason: Bool = false
    @State private var cancelButtonPressed: Bool = false // Флаг для отслеживания нажатия CustomCancelButton
    @State private var isVisibleScreen: Bool = true
    @State private var showSuccessMessage: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            
            if cancelButtonPressed && showReason {
                Text("Пожалуйста выберите причину ")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.red)
                    .frame(width: 343, height: 48, alignment: .leading)
                    .padding(.leading, 16)
                    .background(
                        HStack {
                            Spacer() // Отступ слева
                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.red)
                                .padding(.trailing, 14) 
                        }
                    )
                    .background(Color(red: 255 / 255, green: 236 / 255, blue: 236 / 255, opacity: 1)) // Фон текста
                    .cornerRadius(30)
                    .padding(.top, 16)
            }
        }
        .padding()
        Spacer()
        
        
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<titles.count, id: \.self) { index in
                HStack(alignment: .top) {
                    
                    if buttonStates[index] {
                        SquareColor()
                    } else {
                        EmptySquare()
                    }
                    
                    
                    
                    
                    CustomButton(
                        title: titles[index],
                        
                        backgroundColor: .clear
                        
                    ) {
                        buttonStates[index].toggle() // Изменяем состояние только для текущей кнопки
                        
                        if titles[index] == "Другое" {
                            showOtherTextField.toggle()
                        }
                    }
                    
                    
                    
                }
                
                if titles[index] == "Другое" && showOtherTextField {
                    HStack(alignment: .center) {
                        TextField("Опишите проблему", text: $username)
                            .font(.system(size: 16))
                        
                            .padding()
                            .frame(width: 343, height: 54)
                            .background(Color(red: 246/255, green: 246/255, blue: 246/255, opacity: 1))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 246/255, green: 246/255, blue: 246/255, opacity: 1), lineWidth: 1)
                            )
                    }
                    
                }
                
                
                
            }
            
            .offset(x: CGFloat(30))
            Spacer()
            
            VStack(alignment: .leading) {
                
               
                    ZStack(alignment: .topTrailing) {
                        CustomReturnMoney(title: "Обычно деньги сразу возваращаются\nна карту. В некоторых случаях это\nможет занять до 3 рабочих дней. ")
                        
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundStyle((Color(red: 248 / 255, green: 198 / 255, blue: 35 / 255, opacity: 1)))
                            .offset(x: -20, y: 12)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    
                    
                    
                    CustomCancelButton(
                        title: "Отменить заказ",
                        backgroundColor: (Color(red: 255 / 255, green: 70 / 255, blue: 17 / 255, opacity: 1))
                    ) {
                        cancelButtonPressed = true
                        
                        if buttonStates.contains(true) {
                            showReason = false
                            isLoading = true
                            
                            // Показать индикатор на 3 секунды
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                isLoading = false
                                showSuccessMessage = true
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showSuccessMessage = false
                                    buttonStates = Array(repeating: false, count: buttonStates.count)
                                    showOtherTextField = false
                                }
                            }
                        } else {
                            showReason = true
                        }
                    }
                    
                Spacer()
                    
                 
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5) // Увеличение размера индикатора
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                if showSuccessMessage {
                    Text("Заказ успешно отменен")
                        .foregroundStyle(.white)
                        .frame(width: 205, height: 40)
                        .background(Color.gray)
                        .cornerRadius(30)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                
                
                Spacer()
                
            }
            
            
            
            
        }
        
        
        
    }
    
    private let titles = [
        "Не подходит дата получения",
        "Часть товаров из заказа была\nотменена",
        "Не получилось применить скидку\nили промокод",
        "Хочу изменить заказ и оформить\nзаново",
        "Нашелся товар дешевле",
        "Другое",
        
    ]
}

#Preview {
    ContentViewNew()
}

