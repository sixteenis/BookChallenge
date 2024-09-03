//
//  BookStorageVC.swift
//  BookChallenge
//
//  Created by 박성민 on 8/16/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

class BookStorageVC: BaseViewController, NavLogoProtocol {
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UnderlineSegmentedControl(items: ["챌린지 중", "혼자 챌린지 중", "종료된 챌린지"])
        return segmentedControl
    }()
    private let vc1: ChallengeingVC = {
        let vc = ChallengeingVC()
        vc.view.backgroundColor = .white
        return vc
    }()
    private let vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    private let vc3: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        return vc
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        return vc
      }()
    var dataViewControllers: [UIViewController] {
        [self.vc1, self.vc2, self.vc3]
      }
    lazy var currentPage: Int = 0 {
       didSet {
         print(oldValue, self.currentPage)
         let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
         self.pageViewController.setViewControllers(
           [dataViewControllers[self.currentPage]],
           direction: direction,
           animated: true,
           completion: nil
         )
       }
     }
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func bindData() {
        vc1.itemSelect = {
            print($0)
            self.pushViewController(view: DetailChallengeingVC())
        }
        self.segmentedControl.rx.selectedSegmentIndex
            .bind(with: self) { owner, index in
                if index == -1 {
                    self.currentPage = 0
                }else {
                    self.currentPage = index
                }
            }.disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(self.segmentedControl)
        view.addSubview(self.pageViewController.view)
    }
    override func setUpLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    override func setUpView() {
        navigationItem.title = "서재"
        self.segmentedControl.setTitleTextAttributes(
              [
                NSAttributedString.Key.foregroundColor: UIColor.font,
                .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
              ],
              for: .selected
            )
        self.segmentedControl.setTitleTextAttributes(
              [
                NSAttributedString.Key.foregroundColor: UIColor.clightGray,
                .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
              ],
              for: .normal
            )
        //세그먼트 버튼 클릭시 뷰 변경해주기
        self.segmentedControl.selectedSegmentIndex = 0
        
        
    }
    
}
// MARK: - 세그먼트 설정 부분
extension BookStorageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard let index = self.dataViewControllers.firstIndex(of: viewController),
      index - 1 >= 0 else { return nil }
    return self.dataViewControllers[index - 1]
  }
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard let index = self.dataViewControllers.firstIndex(of: viewController),
      index + 1 < self.dataViewControllers.count else { return nil }
    return self.dataViewControllers[index + 1]
  }
  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    guard let viewController = pageViewController.viewControllers?[0], let index = self.dataViewControllers.firstIndex(of: viewController) else { return }
    self.currentPage = index
    self.segmentedControl.selectedSegmentIndex = index
  }
}
