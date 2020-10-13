//
//  PhotoCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 11/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import UIKit
import SDWebImage

/// CollectionViewCell for Photo display
class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var viewModel: PhotoViewModel! {
        didSet {
            viewModel.photoImage.bindAndFire { [unowned self] urlString in
                self.photoImageView.sd_setImage(with: URL(string: urlString))
            }
        }
    }
    
}
