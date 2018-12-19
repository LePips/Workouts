//
//  ExerciseViewController.swift
//  Workouts
//
//  Created by Ethan Pippin on 10/28/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import Kingfisher
import MarqueeLabelSwift

class ExerciseViewController: UIViewController {
    
    var exercise: Exercise
    
    private lazy var scrollView: UIScrollView = self.makeScrollView()
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView.forAutoLayout()
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leftAnchor ⩵ view.leftAnchor + 8,
            scrollView.rightAnchor ⩵ view.rightAnchor,
            scrollView.topAnchor ⩵ view.centerYAnchor,
            scrollView.heightAnchor ⩵ 200
            ])
        
        return scrollView
    }
    
    private lazy var stackView: UIStackView = self.makeStackView()
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView.forAutoLayout()
        
        scrollView.embed(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }
    
    private lazy var titleLabel: MarqueeLabel = self.makeTitleLabel()
    private func makeTitleLabel() -> MarqueeLabel {
        let frame = CGRect(x: 20, y: 20, width: view.bounds.width - 40, height: 50)
        let titleLabel = MarqueeLabel.init(frame: frame, duration: 8, fadeLength: 10)
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        
        return titleLabel
    }
    
    init(with exercise: Exercise) {
        self.exercise = exercise
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        _ = scrollView
        _ = stackView
        _ = titleLabel
        
        setupImageView()
        titleLabel.text = exercise.title
    }
    
    func setupImageView() {
        for imageLink in exercise.imageLinks.reversed() {
            let holderView = UIView.forAutoLayout()
            let imageView = UIImageView.forAutoLayout()
            
            holderView.addSubview(imageView)
            stackView.addArrangedSubview(holderView)
            NSLayoutConstraint.activate([
                holderView.heightAnchor ⩵ 200,
                holderView.widthAnchor ⩵ 200,
                imageView.centerXAnchor ⩵ holderView.centerXAnchor,
                imageView.centerYAnchor ⩵ holderView.centerYAnchor,
                imageView.heightAnchor ⩵ 200,
                imageView.widthAnchor ⩵ 200
                ])
            imageView.kf.setImage(with: URL(string: imageLink)!)
        }
    }
}
