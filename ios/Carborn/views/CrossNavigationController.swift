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
    }
    
    private var _verticalPage = 0
    var verticalPage: Int {
        get {
            return _verticalPage
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
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case self.horizontalScrollView:
            let half = self.scrollWidth * 0.5
            let center = self.viewWidth
            let minX = center - half
            let maxX = center + half
            var offset = scrollView.contentOffset
            if offset.x <= minX {
                offset.x += self.scrollWidth
                if self.horizontalPageLimit == 0 || self.horizontalPage > 0 {
                    self._horizontalPage -= 1
                } else if self.useHorizontalPageRevers {
                    self._horizontalPage = self.horizontalPageLimit + self.horizontalPage - 1
                } else {
                    return
                }
                print("left\(self.horizontalPage)")
            } else if offset.x > maxX {
                offset.x -= self.scrollWidth
                if self.horizontalPageLimit == 0 || self.horizontalPage + 1 < self.horizontalPageLimit {
                    self._horizontalPage += 1
                } else if self.useHorizontalPageRevers {
                    self._horizontalPage = (self.horizontalPage + 1) % self.horizontalPageLimit
                } else {
                    return
                }
                print("right\(self.horizontalPage)")
            }
            scrollView.contentOffset = offset
            if let delegate = self.delegate {
                delegate.navigationDidScrollToHorizontal(page: self.horizontalPage, offset: (CGFloat(self.horizontalPage) * center) + offset.x - center)
            }
            break
            
        case self.verticalScrollView:
            let half = self.scrollHeight * 0.5
            let center = self.viewHeight
            let minY = center - half
            let maxY = center + half
            var offset = scrollView.contentOffset
            if offset.y <= minY {
                offset.y += self.scrollHeight
                if self.verticalPageLimit == 0 || self.verticalPage > 0 {
                    self._verticalPage -= 1
                } else if self.useVerticalPageRevers {
                    self._verticalPage = self.verticalPageLimit + self.verticalPage - 1
                } else {
                    return
                }
                print("up\(self.verticalPage)")
            } else if offset.y > maxY {
                offset.y -= self.scrollHeight
                if self.verticalPageLimit == 0 || self.verticalPage + 1 < self.verticalPageLimit {
                    self._verticalPage += 1
                } else if self.useVerticalPageRevers {
                    self._verticalPage = (self.verticalPage + 1) % self.verticalPageLimit
                } else {
                    return
                }
                print("down\(self.verticalPage)")
            }
            scrollView.contentOffset = offset
            if let delegate = self.delegate {
                delegate.navigationDidScrollToVertical(page: self.verticalPage, offset: (CGFloat(self.verticalPage) * center) + offset.y - center)
            }
            break
            
        default:
            break
        }
    }
    
}
