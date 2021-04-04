//
//  ViewModelType.swift
//  MovieApp-MVVM-RxSwift
//
//  Created by Mahmoud Abdul-Wahab on 02/04/2021.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input:  Input! {get}
    var output: Output! {get}
}
