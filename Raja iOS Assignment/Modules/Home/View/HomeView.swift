//
//  HomeView.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit
import SkeletonView
import Kingfisher

class HomeView: BaseView {
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchLayoutButton: UIButton!
    @IBOutlet weak var switchLayoutView: UIView!
    
    // MARK: Variables
    var viewModel: HomeViewModel!
    private var space: CGFloat = 8
    var searchBar: UISearchBar = UISearchBar()
    private var throttler: Throttler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupCollectionView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel
            .state
            .asObserver()
            .subscribe(onNext: { [unowned self] load in
                switch load {
                case .loading:
                    self.view.showAnimatedGradientSkeleton()
                case .finish:
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                case .error: 
                    self.view.hideSkeleton()
                default:
                    return
                }
            }).disposed(by: disposeBag)
        
        viewModel.error
            .asObserver()
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.stopRefreshControll()
                if let msg = error.error {
                    self.showAlert(msg.capitalized, alertStyle: .error)
                }
            }).disposed(by: disposeBag)
        
        self.addRefreshControll(to: self.collectionView) {  [unowned self] in
            self.viewModel.getPhotos()
        }
        
        self.addLoadMore(collectionView: self.collectionView) { [unowned self] in
            self.viewModel.getPhotos(.loadmore)
        }
        
        viewModel.photos.asObservable()
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                if data.count != 0 {
                    self.stopRefreshControll()
                    self.collectionView.reloadData()
                    self.collectionView?.backgroundView?.isHidden = true
                    self.switchLayoutView.isHidden = false
                } else {
                    self.collectionView?.backgroundView?.isHidden = false
                    self.switchLayoutView.isHidden = true
                }
            }).disposed(by: disposeBag)
        
        throttler = Throttler(delay: 0.10) {
            if let text = self.searchBar.text {
                self.viewModel.removeArray()
                self.viewModel.request.search = text
                self.viewModel.getPhotos()
            }
        }
        
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = BaseColor.backgroundView
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.registerReusableCell(HomeCollectionViewCell.self)
        collectionView.registerReusableCell(CardCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let noData = UILabel(frame: CGRect(x: 0, y: 0, width: (collectionView?.bounds.size.width)!, height: (collectionView?.bounds.size.height)!))
        noData.text = "No Data"
        noData.textColor = .white
        noData.textAlignment = .center
        noData.numberOfLines = 0
        noData.sizeToFit()
        collectionView?.backgroundView = noData
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection  = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    private func setupComponent() {
        view.backgroundColor = BaseColor.backgroundView
        navigationController?.navigationBar.barTintColor = BaseColor.backgroundView
        switchLayoutView.isHidden = true
        setupSearchBar(withPlaceHolder: NSLocalizedString("Search ...", comment: ""))
    }
    
    @IBAction func switchLayoutTapped(_ sender: Any) {
        if viewModel.isListView {
            switchLayoutButton.setTitle("Switch to List", for: .normal)
            switchLayoutButton.addTarget(self, action: #selector(switchLayoutTapped(_:)), for: .touchUpInside)
            viewModel.isListView = false
        }else {
            switchLayoutButton.setTitle("Switch to Grid", for: .normal)
            switchLayoutButton.addTarget(self, action: #selector(switchLayoutTapped(_:)), for: .touchUpInside)
            viewModel.isListView = true
        }
        self.collectionView?.reloadData()
    }
    
    private func setupSearchBar(withPlaceHolder placeholder:String) {
        searchBar.placeholder = placeholder
        searchBar.textField?.textColor = .black
        searchBar.delegate = self
        let searchBarContainer = SearchBarView(customSearchBar: searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarContainer
    }
    
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.cellForRowAt(indexPath: indexPath, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.photos.value[indexPath.row]
        viewModel.didTapCardDetail.onNext(data)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    ///Set  size of the cell for collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        
        if viewModel.isListView {
            let size:CGFloat = (collectionView.frame.size.width - space)
            return CGSize(width: size, height: 140)
        }else {
            let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: 350)
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttler.call()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // hides the keyboard.
        searchBar.endEditing(true)
    }
}

// MARK: Shimmering Handler
extension HomeView: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        HomeCollectionViewCell.reuseIdentifier
    }
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
}

extension HomeView: AlertPresentable, Refreshable { }
