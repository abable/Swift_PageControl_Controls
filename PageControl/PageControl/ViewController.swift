//
//  ViewController.swift
//  PageControl
//
//  Created by Seungjun Lim on 22/05/2019.
//  Copyright © 2019 Seungjun Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    
    @IBOutlet weak var pager: UIPageControl!
    
    let list = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.black]
    
    // Action 을 연결하고 value changed 를 처리하겠습니다.
    @IBAction func pageChanged(_ sender: UIPageControl) {
        fromTap = true  // 플래그를 트루로 변경..
        // 컬렉션 뷰를 새로운 페이지로 스크롤하도록 구현..
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        listCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // 페이지업데이트가 탭이벤트로 시작되었는지 확인하기 위해 클래스에 플래그 추가.
    var fromTap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pager.numberOfPages = list.count
        pager.currentPage = 0
        
        pager.pageIndicatorTintColor = UIColor.lightGray
        pager.currentPageIndicatorTintColor = UIColor.red
        
        // page 인디케이터가 자동으로 업데이트 되지 않도록 해야한다. 스크롤이 끝난후에 메소드를 호출해서 수동으로 업데이트 해야한다.
        pager.defersCurrentPageDisplay = true
    }
}


// extension...

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // 플래그를 초기화 하고, 페이지 인디케이터를 업데이트 하겠습니다.
        fromTap = false
        pager.updateCurrentPageDisplay()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 플래그가 폴스일때만 실행하도록..
        guard !fromTap else {return}
        
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2.0)
        let newPage = Int(x / width)
        if pager.currentPage != newPage {
            pager.currentPage = newPage
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = list[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

