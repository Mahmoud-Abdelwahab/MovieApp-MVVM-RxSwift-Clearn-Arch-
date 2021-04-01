//
//  TracksCell.swift
//  MovieApp-MVVM-RxSwift
//
//  Created by Mahmoud Abdul-Wahab on 29/03/2021.
//

import UIKit

class TracksCell: UITableViewCell {


    @IBOutlet weak var trakeDetailsLable: UILabel!
    @IBOutlet weak var trackNameLable: UILabel!
    @IBOutlet weak var trackeImage: UIImageView!
    static var identifier = "TracksCell"
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: Bundle.main)
    }
    override func prepareForReuse() {
        trackeImage.image = UIImage()
    }
    
}
