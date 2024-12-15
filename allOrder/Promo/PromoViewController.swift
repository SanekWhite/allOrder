//
//  PromoViewController.swift
//  allOrder
//
//  Created by Александр Белый on 10.12.2024.
//

import UIKit
import SnapKit



class PromoViewController: UIViewController, HeaderView.HeaderViewDelegate, PromoCodeDelegate {
    
   
    
    func promocodeButtonTapped() {
        let secondVC = PromoViewController2()
            secondVC.viewModel = viewModel // Передаем текущий ViewModel
            secondVC.delegate = self       // Назначаем делегатом
            navigationController?.pushViewController(secondVC, animated: true)
        }
    
    
    
    let viewModel = ViewModel()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        return containerView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Оформление заказа"
        view.addSubview(scrollView)
        
        updateAllViews()
       
        
            
    }
    
    
   
    
    func updateAllViews() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        scrollView.addSubview(containerView)
        // Constraints для HeaderView
        
        
        
        containerView.subviews.forEach { $0.removeFromSuperview() }
        let header = HeaderView()
        containerView.addSubview(header)
        header.delegate = self
        
        header.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(192)
        }
        
   
        
        let footer = FooterView()
        var previousView: UIView?
        viewModel.viewModels.forEach { promoViewModel in
            let view = PromoView(promo: promoViewModel, footerView: footer)
            view.translatesAutoresizingMaskIntoConstraints = false
          
            containerView.addSubview(view)
            
            view.snp.makeConstraints { make in
                
                make.left.right.equalTo(containerView).inset(16)
                make.height.equalTo(90)
                
                
            }
            
            view.onSwitchToggle = {[weak self] isActive, promoCode in
                view.footerView?.setupUpdate()
                
            }
            
            if previousView == nil {
                // Первый PromoView
                view.snp.makeConstraints { make in
                    make.top.equalTo(header.snp.bottom).offset(16)  // Расстояние от header
                }
            } else {
                // Последующие PromoView
                view.snp.makeConstraints { make in
                    make.top.equalTo(previousView!.snp.bottom).offset(8)
                }
            }
            
            
            previousView = view
        }
        
        
        
       // let footer = FooterView()
        footer.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        containerView.addSubview(footer)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.left.equalTo(scrollView.contentLayoutGuide.snp.left)
            make.right.equalTo(scrollView.contentLayoutGuide.snp.right)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        
        footer.snp.makeConstraints { make in
            //   make.top.equalTo(previousView!.snp.bottom).offset(16)
            make.left.right.equalTo(containerView)
            make.height.equalTo(350) // Высота footer
            make.bottom.equalTo(containerView.snp.bottom) // Закрепляем к низу containerView
        }
        
        
        if previousView != nil {
            // добавляем constraints к последнему промокоду
            footer.topAnchor.constraint(equalTo: previousView!.bottomAnchor, constant: 16).isActive = true
        } else {
            // добавляем constraints header
            footer.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16).isActive = true
        }
    }
    
    func didAddPromoCode(_ promoCode: PromoViewModel) {
        viewModel.viewModels.append(promoCode) // Обновляем данные
                updateAllViews() // Обновляем UI
    }
    
    
}

struct PromoViewModel {
    
    struct Promocode {
        
        let title: String
        let titleOneOrder: String
        let percent: Int
        var endDate = Date()
        let info: String?
        var active: Bool
        
        
    }
    
    struct Product {
        
        let price: Double
        let title: String
        
    }
    
    var screenTitle: String
    var promocodes: [Promocode]
    
    
    
    var products: [Product]
    let paymentDiscount: Double?
    let baseDiscount: Double?
    
    
}
