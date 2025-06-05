//
//  OnboardingPageViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
   
    var pages : [OnboardingViewController] = []
    let pageControl = CustomPageControl()
    var currentIndex = 0
    lazy var skipButton : UIButton = {
        let button = UIButton()
        button.setTitle("Өткізу", for: .normal)
        button.setTitleColor(UIColor(named: "111827"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        button.backgroundColor = UIColor(named: "F9FAFB")
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Әрі қарай", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        pages = [OnboardingViewController(backgroundImage: "onb1", welcomeImage: "welcomeImage", information: "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"), OnboardingViewController(backgroundImage: "onb2", welcomeImage: "welcomeImage", information: "Кез келген құрылғыдан қара\n Сүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"), OnboardingViewController(backgroundImage: "onb3", welcomeImage: "welcomeImage", information: "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз")]
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            updateButtons(for: 0)
        }
        setupPageControl()
        setupSkipButton()
        setupNextButton()
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingViewController), index > 0 else{
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingViewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleVC = viewControllers?.first,
              let index = pages.firstIndex(of: visibleVC as! OnboardingViewController) {
                updateButtons(for: index)
           }
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
            
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
       }
    
    func setupSkipButton() {
        skipButton.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipButton.widthAnchor.constraint(equalToConstant: 70),
            skipButton.heightAnchor.constraint(equalToConstant: 24)
            ])
    }
    
    func setupNextButton(){
        nextButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 684),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nextButton.widthAnchor.constraint(equalToConstant: 327),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc func loginButton(){
        let loginVC = AuthorizationViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func skipAction(){
        updateButtons(for: 2)
    }
    
    func updateButtons(for index: Int) {
        currentIndex = index
        pageControl.currentPage = index
        if index == pages.count - 1 {
            skipButton.isHidden = true
            nextButton.isHidden = false
        } else {
            skipButton.isHidden = false
            nextButton.isHidden = true
        }
    }

}


class CustomPageControl: UIStackView {
    var numberOfPages = 0 {
        didSet {
            setupDots()
        }
    }
    
    var currentPage = 0 {
        didSet {
            updateDots()
        }
    }
    private var dotViews: [UIView] = []
    private var widthConstraints: [NSLayoutConstraint] = []

    private func setupDots() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        dotViews = []
        widthConstraints = []
        
        for i in 0..<numberOfPages {
            let dot = UIView()
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.backgroundColor = .lightGray
            dot.layer.cornerRadius = 3
            
            dot.heightAnchor.constraint(equalToConstant: 6).isActive = true
            let width = dot.widthAnchor.constraint(equalToConstant: 6)
            width.isActive = true
            widthConstraints.append(width)

            addArrangedSubview(dot)
            dotViews.append(dot)
        }
        
        spacing = 8
        distribution = .fill
        alignment = .center
        axis = .horizontal
        updateDots()
    }

    private func updateDots() {
        for (index, dot) in dotViews.enumerated() {
            let widthConstraint = widthConstraints[index]
            UIView.animate(withDuration: 0.3) {
                if index == self.currentPage {
                    dot.backgroundColor = .systemPurple
                    widthConstraint.constant = 20
                    dot.layer.cornerRadius = 3
                } else {
                    dot.backgroundColor = .lightGray
                    widthConstraint.constant = 6
                    dot.layer.cornerRadius = 3
                }
            }
        }
    }

}

