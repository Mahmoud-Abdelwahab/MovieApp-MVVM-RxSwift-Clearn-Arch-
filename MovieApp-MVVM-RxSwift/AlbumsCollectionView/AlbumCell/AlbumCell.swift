//
//  AlbumCell.swift
//  MovieApp-MVVM-RxSwift
//
//  Created by Mahmoud Abdul-Wahab on 29/03/2021.
//

import UIKit

class AlbumCell: UICollectionViewCell {

    static var identifier = "AlbumCell"
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumImage.layer.cornerRadius = 12
        albumImage.clipsToBounds = true
    }
    
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: Bundle.main)
    }
    
    override func prepareForReuse() {
        albumImage.image = UIImage()
    }

}
