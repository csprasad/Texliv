//
//  OnboardingVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    ///Empty array of OnboardingSlide Data model
    var slides: [OnboardingSlide] = []
    
    ///Current page count and updating button data as well.
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ///Appending data to empty slides array.
        ///and adding total page count and button shadow as well.
        slides = [
            OnboardingSlide(title: "Fly", description: "Wherever you go, there you are.", image: #imageLiteral(resourceName: "lady-employee-working-in-office")),
            OnboardingSlide(title: "Mindfulness", description: "Mindfulness means being awake. It means knowing what you are doing.", image: #imageLiteral(resourceName: "female-candidate-job-profile")),
            OnboardingSlide(title: "Live", description: "Live the actual moment. Only this actual moment is life.", image: #imageLiteral(resourceName: "woman-looking-at-dating-app"))
        ]
        pageControl.numberOfPages = slides.count
        nextBtn.addShadow(15, radius: 8)
    }
    
    
    ///Next button Action based on conditon
    ///if current page = last slide then it will take to landing login page. if not last page then it will go to next slide.
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

///Extension for collectionview delegate and data source.
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVCell.identifier, for: indexPath) as! OnboardingCVCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
