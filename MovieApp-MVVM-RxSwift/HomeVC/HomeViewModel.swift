//
//  HomeViewModel.swift
//  MovieApp-MVVM-RxSwift
//
//  Created by Mahmoud Abdul-Wahab on 31/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum CustomError {
    case internetError(String)
    case serverMessage(String)
}

class HomeViewModel{
    let error: PublishSubject<CustomError>         = PublishSubject()     
    let loading: PublishSubject<Bool>              = PublishSubject()
    let traks: PublishSubject<[Track]>             = PublishSubject()
    let albums: PublishSubject<[Album]>             = PublishSubject()
    let session = URLSession.shared
   
    
   
    func getAlbums(){
        self.loading.onNext(true)
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let request = URLRequest(url: url)
               URLSession.shared.dataTask(with: request) { [weak self] data, response, error  in
                guard let self = self else{return}
               
                   if let data = data {
                       if let albums = try? JSONDecoder().decode(Albums.self, from: data) {
                        self.albums.onNext(albums)
                       }else{
                        self.error.onNext(.serverMessage("can't decode"))
                        
                       }

                   }
               }.resume()
        
    }
    
    
    func getTracks(){
        self.loading.onNext(true)
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let request = URLRequest(url: url)
               URLSession.shared.dataTask(with: request) { [weak self] data, response, error  in
                guard let self = self else{return}
                self.loading.onNext(false)
                   if let data = data {
                       if let albums = try? JSONDecoder().decode(Tracks.self, from: data) {
                        self.traks.onNext(albums)
                       }else{
                        self.error.onNext(.serverMessage("can't decode"))
                        
                       }

                   }
               }.resume()
        
    }
    
    
 
}
