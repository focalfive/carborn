//
//  CrossNavigationController.swift
//  Carborn
//
//  Created by dev29cm on 2017. 2. 7..
//  Copyright © 2017년 slowslipper. All rights reserved.
//

import UIKit

class CrossNavigationController: UIViewController, UIScrollViewDelegate {
    
    var _scrollWidth: CGFloat = -1
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
    
    var _scrollHeight: CGFloat = -1
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
    
    var _viewWidth: CGFloat = -1
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
    
    var _viewHeight: CGFloat = -1
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
    
    var horizontalScrollView = UIScrollView()
    var verticalScrollView = UIScrollView()
    
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
        
        var contentSize = CGSize.zero
        contentSize.width = viewSize.width * 3
        contentSize.height = viewSize.height
        
        // Horizontal scroll veiw
        self.horizontalScrollView.backgroundColor = .red
        self.horizontalScrollView.frame = frame
        self.horizontalScrollView.isPagingEnabled = true
        self.horizontalScrollView.contentSize = contentSize
        self.horizontalScrollView.contentOffset = CGPoint(x: viewSize.width, y: 0)
        self.horizontalScrollView.delegate = self
        self.view.addSubview(self.horizontalScrollView)
        
        frame.origin.x = viewSize.width
        contentSize.width = viewSize.width
        contentSize.height = viewSize.height * 3
        
        // Vertical scroll view
        self.verticalScrollView.backgroundColor = .blue
        self.verticalScrollView.frame = frame
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
                print("left")
                offset.x += self.scrollWidth
            } else if offset.x > maxX {
                print("right")
                offset.x -= self.scrollWidth
            } else {
                break;
            }
            scrollView.contentOffset = offset
            break
            
        case self.verticalScrollView:
            let half = self.scrollHeight * 0.5
            let center = self.viewHeight
            let minY = center - half
            let maxY = center + half
            var offset = scrollView.contentOffset
            if offset.y <= minY {
                print("up")
                offset.y += self.scrollHeight
            } else if offset.y >= maxY {
                print("down")
                offset.y -= self.scrollHeight
            } else {
                break;
            }
            scrollView.contentOffset = offset
            break
            
        default:
            break
        }
    }
    
}
