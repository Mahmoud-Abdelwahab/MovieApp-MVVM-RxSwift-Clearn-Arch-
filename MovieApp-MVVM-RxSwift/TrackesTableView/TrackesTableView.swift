//
//  TrackesTableView.swift
//  MovieApp-MVVM-RxSwift
//
//  Created by Mahmoud Abdul-Wahab on 29/03/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Combine

class TrackesTableView: UITableViewController {

    let traks: PublishSubject<[Track]>             = PublishSubject()
    let disposeBag    = DisposeBag()

    
    var  anyCancalable: AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(TracksCell.nib(), forCellReuseIdentifier: TracksCell.identifier)
        
        bindViews()
        
        
        // how to call api using combine
        anyCancalable =  fechData().receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion{
                case .finished:
                    print("Finished")
                case .failure(_):
                    print("Error")
                }
            } receiveValue: { (array) in
                print(array)
            }

        
    }

    // MARK: - Table view data source

    func bindViews(){
        
        traks.bind(to: tableView.rx.items(cellIdentifier: TracksCell.identifier, cellType: TracksCell.self)){
            (row, track, cell) in
            cell.trackeImage.image = #imageLiteral(resourceName: "singer_pic")
            cell.trackNameLable.text = track.title
            cell.trakeDetailsLable.text = track.thumbnailURL
        }.disposed(by: disposeBag)
        
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
    }

    func fechData()-> Future<[String], Error>{
        return Future{ promise in
            promise(.success(["Mahmoud","Abdelwahab","Abdelsalam","Ahmed","Mohamed"]))
        }
    }
    
}


