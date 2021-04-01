//
//  HomeVC.swift
//  MovieApp-MVVM-RxSwift
//
//  Created by Mahmoud Abdul-Wahab on 29/03/2021.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: UIViewController {

    @IBOutlet weak var albumsContainerView: UIView!
    
    @IBOutlet weak var tracksContainerView: UIView!
    
    let disposeBag    = DisposeBag()
    let homeViewModel = HomeViewModel()
    
    private lazy var ablumsCV: AlbumsCollectionView = {
        //let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
             
        let albumVC =  self.storyboard?.instantiateViewController(withIdentifier: "AlbumsCollectionView") as! AlbumsCollectionView
                
        self.add(asChildViewController: albumVC, to: albumsContainerView)
        
               return albumVC
    }()
    
    private lazy var trackesTableView: TrackesTableView = {
        //let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
             
        let trackesTableView = self.storyboard?.instantiateViewController(withIdentifier: "TrackesTableView") as!  TrackesTableView
                
        self.add(asChildViewController: trackesTableView, to: tracksContainerView)
               return trackesTableView
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        bindingViews()
       
        homeViewModel.getAlbums()
        homeViewModel.getTracks()
    }
    
   
    func  bindingViews(){
        
        // binding loading to vc

        homeViewModel.loading
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        // observing errors to show

        homeViewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                switch error {
                
                case .internetError(let msg):
                    MessageView.sharedInstance.showOnView(message: msg, theme: .error)
                case .serverMessage(let msg):
                    MessageView.sharedInstance.showOnView(message: msg, theme: .warning)
                }
            }).disposed(by: disposeBag)
        
        // binding albums to album container
        
        homeViewModel.albums
            .observeOn(MainScheduler.instance)
            .bind(to: ablumsCV.albums)
            .disposed(by: disposeBag)
        
        // binding tracks to track container
        homeViewModel.traks
            .observeOn(MainScheduler.instance)
            .bind(to: trackesTableView.traks )
            .disposed(by: disposeBag)
    }
    
}

