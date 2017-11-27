//
//  MoreInfoRouteCardView.swift
//  Maps
//
//  Created by Alex on 26/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

protocol MoreInfoRouteCardViewDelegate {
    func moreInfoRouteCardViewTapped(view: MoreInfoRouteCardView)
}

@IBDesignable class MoreInfoRouteCardView: CustomView {

    // MARK: - IBOutlets
    @IBOutlet private var labelTitle: UILabel!
    @IBOutlet private var textViewDescription: UITextView!
    
    // MARK: - Properties
    public var delegate: MoreInfoRouteCardViewDelegate?
    
    // MARK: - Initialize View
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        self.initialize()
    }
    
    func initialize() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! CustomView
        
        return view
    }
    
    // MARK: - Public Functions
    public func setTitle(text: String) {
        labelTitle.text = text
    }
    
    public func setDescription(text: String) {
        textViewDescription.text = text
    }
    
    // MARK: - IBActions
    @IBAction func tapViewAction(_ sender: UITapGestureRecognizer) {
        delegate?.moreInfoRouteCardViewTapped(view: self)
    }
}
