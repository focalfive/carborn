//
//  CrossNavigationController.swift
//  Carborn
//
//  Created by dev29cm on 2017. 2. 7..
//  Copyright © 2017년 slowslipper. All rights reserved.
//

import UIKit

protocol CrossNavigationControllerDelegate {
    func navigationDidScrollToHorizontal(page: Int, offset: CGFloat)
    func navigationDidScrollToVertical(page: Int, offset: CGFloat)
}

extension CrossNavigationControllerDelegate {
    func navigationDidScrollToHorizontal(page: Int, offset: CGFloat) {
        
    }
    func navigationDidScrollToVertical(page: Int, offset: CGFloat) {
        
    }
}

class CrossNavigationController: UIViewController, UIScrollViewDelegate {
    
    private var _scrollWidth: CGFloat = -1
    var scrollWidth: CGFloat {
        get {
            return self._scrollWidth
        }
        set {
            if self._scrollWidth != newValue {
                self._scrollWidth = newValue
            }
        }
    }
    
    private var _scrollHeight: CGFloat = -1
    var scrollHeight: CGFloat {
        get {
            return self._scrollHeight
        }
        set {
            if self._scrollHeight != newValue {
                self._scrollHeight = newValue
            }
        }
    }
    
    private var _viewWidth: CGFloat = -1
    var viewWidth: CGFloat {
        get {
            return self._viewWidth
        }
        set {
            if self._viewWidth != newValue {
                self._viewWidth = newValue
            }
        }
    }
    
    private var _viewHeight: CGFloat = -1
    var viewHeight: CGFloat {
        get {
            return self._viewHeight
        }
        set {
            if self._viewHeight != newValue {
                self._viewHeight = newValue
            }
        }
    }
    
    private var _horizontalPage = 0
    var horizontalPage: Int {
        get {
            return _horizontalPage
        }
        set {
            if newValue < self.horizontalPageLimit {
                self._horizontalPage = newValue
                if let delegate = self.delegate {
                    delegate.navigationDidScrollToHorizontal(page: newValue, offset: (CGFloat(newValue) * self.viewWidth))
                }
            }
        }
    }
    
    private var _verticalPage = 0
    var verticalPage: Int {
        get {
            return _verticalPage
        }
        set {
            if newValue < self._verticalPageLimit {
                self._verticalPage = newValue
                if let delegate = self.delegate {
                    delegate.navigationDidScrollToVertical(page: newValue, offset: (CGFloat(newValue) * self.viewHeight))
                }
            }
        }
    }
    
    private var _horizontalPageLimit = 0
    var horizontalPageLimit: Int {
        get {
            return self._horizontalPageLimit
        }
        set {
            self._horizontalPageLimit = newValue
            if self._horizontalPage >= newValue {
                self._horizontalPage = self._horizontalPage % newValue
            }
        }
    }
    
    private var _verticalPageLimit = 0
    var verticalPageLimit: Int {
        get {
            return self._verticalPageLimit
        }
        set {
            self._verticalPageLimit = newValue
            if self._verticalPage >= newValue {
                self._verticalPage = self._verticalPage % newValue
            }
        }
    }
    
    var useHorizontalPageRevers = true
    var useVerticalPageRevers = true
    
    var horizontalScrollBefore: CGFloat = 0
    var verticalScrollBefore: CGFloat = 0
    var horizontalScrollDirection = 0
    var verticalScrollDirection = 0
    
    private var horizontalScrollView = UIScrollView()
    private var verticalScrollView = UIScrollView()
    var contentView = UIView()
    var delegate: CrossNavigationControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewSize = self.view.frame.size
        if self._scrollWidth < 0 {
            self._scrollWidth = viewSize.width
        }
        if self._scrollHeight < 0 {
            self._scrollHeight = viewSize.height
        }
        if self._viewWidth < 0 {
            self._viewWidth = viewSize.width
        }
        if self._viewHeight < 0 {
            self._viewHeight = viewSize.height
        }
        
        var frame = CGRect.zero
        frame.size = viewSize
        
        self.contentView.frame = frame
        self.view.addSubview(self.contentView)
        
        var contentSize = CGSize.zero
        contentSize.width = viewSize.width * 3
        contentSize.height = viewSize.height
        
        // Horizontal scroll veiw
        self.horizontalScrollView.frame = frame
        self.horizontalScrollView.showsVerticalScrollIndicator = false
        self.horizontalScrollView.showsHorizontalScrollIndicator = false
        self.horizontalScrollView.backgroundColor = UIColor.red.withAlphaComponent(0)
        self.horizontalScrollView.isPagingEnabled = true
        self.horizontalScrollView.contentSize = contentSize
        self.horizontalScrollView.contentOffset = CGPoint(x: viewSize.width, y: 0)
        self.horizontalScrollView.delegate = self
        self.view.addSubview(self.horizontalScrollView)
        
        frame.origin.x = viewSize.width
        contentSize.width = viewSize.width
        contentSize.height = viewSize.height * 3
        
        // Vertical scroll view
        self.verticalScrollView.frame = frame
        self.verticalScrollView.showsVerticalScrollIndicator = false
        self.verticalScrollView.showsHorizontalScrollIndicator = false
        self.verticalScrollView.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.verticalScrollView.isPagingEnabled = true
        self.verticalScrollView.contentSize = contentSize
        self.verticalScrollView.contentOffset = CGPoint(x: 0, y: viewSize.height)
        self.verticalScrollView.delegate = self
        self.horizontalScrollView.addSubview(self.verticalScrollView)
        // For center test
//        let block = UIView(frame: CGRect(origin: CGPoint(x: 0, y: viewSize.height), size: viewSize))
//        block.backgroundColor = UIColor.red.withAlphaComponent(0.25)
//        self.verticalScrollView.addSubview(block)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        switch scrollView {
        case self.horizontalScrollView:
            if self.horizontalScrollBefore < offset.x {
                self.horizontalScrollDirection = 1
            } else if self.horizontalScrollBefore > offset.x {
                self.horizontalScrollDirection = -1
            } else {
                self.horizontalScrollDirection = 0
            }
            self.horizontalScrollBefore = offset.x
            let half = self.scrollWidth * 0.5
            let center = self.viewWidth
            let minX = center - half
            let maxX = center + half
            if offset.x <= minX {
                offset.x += self.scrollWidth
                if self.horizontalPageLimit == 0 || self.horizontalPage > 0 {
                    self._horizontalPage -= 1
                } else if self.useHorizontalPageRevers {
                    self._horizontalPage = self.horizontalPageLimit + self.horizontalPage - 1
                } else {
                    offset.x = minX
                    self.horizontalScrollDirection = -1
                }
            } else if offset.x > maxX {
                offset.x -= self.scrollWidth
                if self.horizontalPageLimit == 0 || self.horizontalPage + 1 < self.horizontalPageLimit {
                    self._horizontalPage += 1
                } else if self.useHorizontalPageRevers {
                    self._horizontalPage = (self.horizontalPage + 1) % self.horizontalPageLimit
                } else {
                    offset.x = maxX
                    self.horizontalScrollDirection = 1
                }
            }
            scrollView.contentOffset = offset
            if let delegate = self.delegate {
                delegate.navigationDidScrollToHorizontal(page: self.horizontalPage, offset: (CGFloat(self.horizontalPage) * center) + offset.x - center)
            }
            
        case self.verticalScrollView:
            if self.verticalScrollBefore < offset.y {
                self.verticalScrollDirection = 1
            } else if self.verticalScrollBefore > offset.y {
                self.verticalScrollDirection = -1
            } else {
                self.verticalScrollDirection = 0
            }
            self.verticalScrollBefore = offset.y
            let half = self.scrollHeight * 0.5
            let center = self.viewHeight
            let minY = center - half
            let maxY = center + half
            if offset.y <= minY {
                offset.y += self.scrollHeight
                if self.verticalPageLimit == 0 || self.verticalPage > 0 {
                    self._verticalPage -= 1
                } else if self.useVerticalPageRevers {
                    self._verticalPage = self.verticalPageLimit + self.verticalPage - 1
                } else {
                    offset.y = minY
                    self.verticalScrollDirection = -1
                }
            } else if offset.y > maxY {
                offset.y -= self.scrollHeight
                if self.verticalPageLimit == 0 || self.verticalPage + 1 < self.verticalPageLimit {
                    self._verticalPage += 1
                } else if self.useVerticalPageRevers {
                    self._verticalPage = (self.verticalPage + 1) % self.verticalPageLimit
                } else {
                    offset.y = maxY
                    self.verticalScrollDirection = 1
                }
            }
            scrollView.contentOffset = offset
            if let delegate = self.delegate {
                delegate.navigationDidScrollToVertical(page: self.verticalPage, offset: (CGFloat(self.verticalPage) * center) + offset.y - center)
            }
            
        default:
            break
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        switch scrollView {
        case self.horizontalScrollView:
            if !self.useHorizontalPageRevers {
                if (self.horizontalScrollDirection < 0 && self.horizontalPage == 0) || (self.horizontalScrollDirection > 0 && self.horizontalPage == (self.horizontalPageLimit - 1)) {
                    scrollView.setContentOffset(scrollView.contentOffset, animated: true)
                    self.horizontalScrollToCenter(animated: true)
                }
            }
        case self.verticalScrollView:
            if !self.useVerticalPageRevers {
                if (self.verticalScrollDirection < 0 && self.verticalPage == 0) || (self.verticalScrollDirection > 0 && self.verticalPage == (self.verticalPageLimit - 1)) {
                    scrollView.setContentOffset(scrollView.contentOffset, animated: true)
                    self.verticalScrollToCenter(animated: true)
                }
            }
        default:
            break
        }
        self.verticalScrollBefore = 0
        self.verticalScrollDirection = 0
    }
    
    func stopHorizontalScrollAndScrollToCenter() {
        var offset = self.horizontalScrollView.contentOffset
        offset.x += 1
        self.horizontalScrollView.setContentOffset(offset, animated: false)
        offset.x -= 1
        self.horizontalScrollView.setContentOffset(offset, animated: false)
        self.perform(#selector(horizontalScrollToCenter), with: nil, afterDelay: 0)
    }
    
    func horizontalScrollToCenter(animated: Bool = true) {
        let center = CGPoint(x: self.viewWidth, y: 0)
        self.horizontalScrollView.setContentOffset(center, animated: animated)
    }
    
    func stopVerticalScrollAndScrollToCenter() {
        var offset = self.verticalScrollView.contentOffset
        offset.y += 1
        self.verticalScrollView.setContentOffset(offset, animated: false)
        offset.y -= 1
        self.verticalScrollView.setContentOffset(offset, animated: false)
        self.perform(#selector(verticalScrollToCenter), with: nil, afterDelay: 0)
    }
    
    func verticalScrollToCenter(animated: Bool = true) {
        let center = CGPoint(x: 0, y: self.viewHeight)
        self.verticalScrollView.setContentOffset(center, animated: animated)
    }
    
}
