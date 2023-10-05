//
//  ViewController.swift
//  UMC_5th_firstMission
//
//  Created by 신예진 on 9/28/23.
//

import UIKit
import SnapKit

//MARK: - ViewController
final class ViewController: UIViewController {
    var shopsDataArray: [ShopSection] = []
    
    var topViewfourDataArray: [ShopItem] = []
    
    //전체스크롤
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tag = 0
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var searchBarContentView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.logoColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "찾는 맛집 이름이 뭐예요?"
        searchBar.backgroundColor = .clear
        
        // Search TextField 설정
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            
            // 배경색 설정
            searchTextField.backgroundColor = UIColor.clear // 배경 색상 지정
            
            // 플레이스홀더 텍스트 색상 설정
            if let placeholderLabel = searchTextField.value(forKey: "placeholderLabel") as? UILabel {
                placeholderLabel.textColor = UIColor(red: 0xD8 / 255, green: 0xD8 / 255, blue: 0xD8 / 255, alpha: 1)
            }
            
            // 검색 아이콘 설정
            if let leftImageView = searchTextField.leftView as? UIImageView {
                leftImageView.image = UIImage(systemName: "magnifyingglass")
                leftImageView.tintColor = UIColor(red: 0x2A / 255, green: 0xC1 / 255, blue: 0xBC / 255, alpha: 1) // 아이콘 색상 지정
            }
        }
        
        return searchBar
    }()
    
    private lazy var couponBannerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 쿠폰 배너
    private lazy var couponBanner: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "couponBanner")
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
        
    }()
    
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.interSpaceColor
        return view
    }()
    
    private lazy var midView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    //customView1 3개를 stackview로묶기
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var customView1: FirstCustomView = {
        let view = FirstCustomView()
        view.configure(title: "배달", subtitle: "세상은 넓고\n맛집은 많다", image: UIImage(named: "맨위1"))
        return view
    }()
    
    private lazy var customView2: FirstCustomView = {
        let view = FirstCustomView()
        view.configure(title: "B마트", subtitle: "장보기도\n더빠르게!", image: UIImage(named: "맨위2"))
        return view
    }()
    
    private lazy var customView3: FirstCustomView = {
        let view = FirstCustomView()
        view.configure(title: "배민스토어", subtitle: "홈플익스프레스\n신선 장보기", image: UIImage(named: "맨위3"))
        return view
    }()
    
    //customView2
    private lazy var customItemView = SecondCustomView()
    private var secondCustomviewHeight: CGFloat = 0.0
    
    //banners
    private lazy var bannerView : UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 10
        uiView.layer.masksToBounds = true
        uiView.backgroundColor = .clear
        return uiView
    }()
    // BannerViewController 커스텀
    private let bannerViewController = BannerViewController()
    
    //4가지 쿠폰
    private lazy var topViewLastView : UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    private lazy var topViewLastImage : UIImageView = {
        let uiImage = UIImageView()
        uiImage.image = UIImage(named: "topViewLastImage")
        return uiImage
    }()
    
    
    //image로 넣고 그안에 셀 넣기
    private lazy var topViewLastcollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SecondCustomCollectionCell.self, forCellWithReuseIdentifier: SecondCustomCollectionCell.reuseIdentifier)
        
        return collectionView
    }()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        addSubviews()
        settingNaviItem()
        
    }
    
    private func setupViews(){
        topViewLastcollectionView.register(SecondCustomCollectionCell.self, forCellWithReuseIdentifier:SecondCustomCollectionCell.reuseIdentifier)
    }
    
    
    private func settingNaviItem(){
        let placeText = UIBarButtonItem(title: "우리집", style: .plain, target: self, action: #selector(buttonTapped))
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20), // 16은 원하는 폰트 크기로 변경하세요
            .foregroundColor: UIColor.white // 텍스트 색상을 원하는 색상으로 변경하세요
        ]
        placeText.setTitleTextAttributes(attributes, for: .normal)
        view.backgroundColor = UIColor.logoColor
        
        // 네비게이션 바 오른쪽 상단에 버튼 3개 추가
        let button1 = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(buttonTapped))
        let button2 = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(buttonTapped))
        let button3 = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(buttonTapped))
        
        // 버튼 색상 설정
        placeText.tintColor = .white
        button1.tintColor = .white
        button2.tintColor = .white
        button3.tintColor = .white
        
        navigationController?.navigationBar.barTintColor = UIColor.logoColor
        navigationItem.rightBarButtonItems = [button1, button2, button3]
        navigationItem.leftBarButtonItem = placeText
    }
    
    @objc func buttonTapped() {
        
    }
    
    //MARK: - addSubviews()
    private func addSubviews() {
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(midView)
        
        
        topView.addSubview(searchBarContentView)
        searchBarContentView.addSubview(searchBar)
        
        topView.addSubview(couponBannerView)
        couponBannerView.addSubview(couponBanner)
        
        contentView.addSubview(bottomView)
        
        stackView.addArrangedSubview(customView1)
        stackView.addArrangedSubview(customView2)
        stackView.addArrangedSubview(customView3)
        
        
        topView.addSubview(stackView)
        topView.addSubview(customItemView)
        
        
        topView.addSubview(bannerView)
        
        bannerView.addSubview(bannerViewController.view)
        addChild(bannerViewController)
        bannerViewController.didMove(toParent: self)
        bannerViewController.scrollView.isScrollEnabled = false
        
        topView.addSubview(topViewLastView)
        topViewLastView.addSubview(topViewLastImage)
        
        topViewLastView.addSubview(topViewLastcollectionView)
        configureConstraints()
    }
    
    //MARK: - configureConstraints()
    private func configureConstraints() {
        
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.bottom)
        }
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            
        }
        
        searchBarContentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(searchBar.snp.bottom).offset(10)
        }
        couponBannerView.snp.makeConstraints { make in
            make.top.equalTo(searchBarContentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(couponBannerView.snp.width).multipliedBy(0.22)
        }

        couponBanner.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(topViewLastcollectionView.snp.bottom).offset(20)
        }
        
        midView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(6.3)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(midView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(1.7)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(couponBannerView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(stackView.snp.width).multipliedBy(0.35)
        }
        
        customView1.snp.makeConstraints { make in
            make.top.equalTo(couponBannerView.snp.bottom).offset(30)
            make.height.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
        customView2.snp.makeConstraints { make in
            make.top.equalTo(couponBannerView.snp.bottom).offset(30)
            make.height.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
        customView3.snp.makeConstraints { make in
            make.top.equalTo(couponBannerView.snp.bottom).offset(30)
            make.height.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
        
        customItemView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(customItemView.snp.width).multipliedBy(0.55)
        }
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(customItemView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(bannerView.snp.width).multipliedBy(0.35)
        }
        bannerViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topViewLastView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(bannerView.snp.width).multipliedBy(0.33)
            
        }
        topViewLastImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topViewLastcollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("🍎\(topViewfourDataArray.count)")
        return topViewfourDataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCustomCollectionCell.reuseIdentifier, for: indexPath) as? SecondCustomCollectionCell else {
            return UICollectionViewCell()
        }
        
        let shopItem = topViewfourDataArray[indexPath.item]
        cell.configure(image: shopItem.image!, title: shopItem.text)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 4 - 10, height: collectionView.bounds.height)
    }
}
