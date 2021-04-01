//
//  AlbumsCollectionView.swift
//  MovieApp-MVVM-RxSwift
//
//  Created by Mahmoud Abdul-Wahab on 29/03/2021.
//

import UIKit
import RxCocoa
import RxSwift

class AlbumsCollectionView: UICollectionViewController {

    let albums: PublishSubject<[Album]>             = PublishSubject()
    let disposeBag    = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.register(AlbumCell.nib(), forCellWithReuseIdentifier: AlbumCell.identifier)

        bindViews()
    }
    
    func bindViews(){

        albums.bind(to: collectionView.rx.items(cellIdentifier: AlbumCell.identifier, cellType: AlbumCell.self)) {  (row,album,cell) in
            cell.albumImage.image = #imageLiteral(resourceName: "singer_pic")
            cell.albumName.text   = album.title
            }.disposed(by: disposeBag)
        
        
        
        
        collectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
    }
    

}
