//
//  OnbardingCVCell.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell {
    ///set identifies as self name declaring. i.e OnboardingCVCell
    static let identifier = String(describing: OnboardingCVCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    //Adding data to collectionvView cell.
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}
