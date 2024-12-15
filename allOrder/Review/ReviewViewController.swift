//
//  ReviewController.swift
//  allOrder
//
//  Created by Александр Белый on 10.12.2024.
//

import UIKit
import SnapKit
//MARK: class ViewModel
class ReviewViewModel {
    var cellViewModels: [TableViewModel] = [
        .init(type: .rings(.init(icon: .iconRing, description1: "Золотое плоское", description2: "обручальное кольцо 4 мм"))),
        .init(type: .rings(.init(icon: .iconRing2, description1: "Золотое плоское", description2: "обручальное кольцо 4 мм"))),
        .init(type: .rings(.init(icon: .iconRing3, description1: "Золотое плоское", description2: "обручальное кольцо 4 мм"))),
        .init(type: .rings(.init(icon: .iconRing4, description1: "Золотое плоское", description2: "обручальное кольцо 4 мм"))),
        
        
    ]
}

//MARK: class ViewController
class ReviewViewController: UIViewController {
    
    let viewModels = ReviewViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(RingsCell.self, forCellReuseIdentifier: String(describing: RingsCell.self))
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Напишите отзыв"
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            tableView.reloadData()
        }
        
        
    }
    
    
}
//MARK: struct TableViewModel
struct TableViewModel {
    enum ViewModelType {
        struct AllRings {
            let icon: UIImage
            let description1: String
            let description2: String
            
            
        }
        
        case rings(AllRings)
    }
    
    var type: ViewModelType
}



//MARK: extension ViewController:
extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let viewModels = self.viewModels.cellViewModels[indexPath.row]
        
        switch viewModels.type {
        case .rings(let rings):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RingsCell.self), for: indexPath) as? RingsCell else {
                fatalError()
            }
            cell.viewModels = rings
            return cell
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.navigationController?.pushViewController(ReviewViewController2(), animated: true)
        }
    }
    
}
//MARK: class RingsCell
class RingsCell: UITableViewCell {
    
    var viewModels: TableViewModel.ViewModelType.AllRings? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var descriptionLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel2: UILabel = {
        let label2 = UILabel()
        label2.textColor = .black
        label2.font = .systemFont(ofSize: 14)
        label2.numberOfLines = 0
        return label2
    }()
    
    private lazy var iconRingView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var arrowNext: UIImageView = {
        let imageNext = UIImageView()
        imageNext.image = .arrowNext
        imageNext.contentMode = .scaleAspectFill
        imageNext.backgroundColor = .clear
        return imageNext
        
    }()
    
    private func updateUI() {
        descriptionLabel1.text = viewModels?.description1
        descriptionLabel2.text = viewModels?.description2
        iconRingView.image = viewModels?.icon
        
    }
    
    private func setupUI() {
        contentView.addSubview(descriptionLabel1)
        contentView.addSubview(descriptionLabel2)
        contentView.addSubview(iconRingView)
        contentView.addSubview(arrowNext)
        
        iconRingView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.width.equalTo(80)
            make.height.equalTo(80)
            
            descriptionLabel1.snp.makeConstraints { make in
                make.top.equalTo(contentView).inset(10)
                make.left.equalTo(iconRingView.snp_rightMargin).offset(12)
                make.right.equalTo(contentView.snp_rightMargin).inset(5)
                
                descriptionLabel2.snp.makeConstraints { make in
                    make.top.equalTo(descriptionLabel1.snp_bottomMargin).offset(10)
                    make.left.equalTo(iconRingView.snp_rightMargin).offset(12)
                    
                    arrowNext.snp.makeConstraints { make in
                        make.centerY.equalTo(contentView)
                        make.right.equalTo(contentView)
                    }
                }
            }
        }
    }
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
