
//
//  ViewController.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import UIKit
import AppInjector

/// CategoryViewController Events
protocol CategoryViewControllerDelegate: class {
    /// Called when a category is chosen
    func didChooseCategory(category: Category, viewController: CategoryViewController)
    /// Called when view is finished
    func didFinishChoosingCategory(viewController: CategoryViewController)
}

/**
 Show current selected category and it's subcategories, show listings count and allow user to drill down
 */
class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    /// Category currently shown
    var category: Category?
    
    /**
     Delegate for view controller events
     
     - see: CategoryViewControllerDelegate
     */
    weak var delegate: CategoryViewControllerDelegate?
    
    /// Fitlered subcategories, only none 0 subcategories are shown
    private var filteredSubcategories = [Category]()
    
    /// Title view shown
    private var titleView = CategoryTitleView().setupSubviews()
    
    /// Flag for loading state
    private var loading = true
    
    // MARK: Injected
    
    /// Listing service used, injected in viewDidLoad
    var listingService: ListingService!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccessibilityIdentifiers.categoryView.set(viewController: self)
        
        Injector.defaultInjector.injectDependencies(self)
        
        // Configure table view
        tableView.registerNibs([CellIdentifiers.categoryCell, CellIdentifiers.loadingCell])
        
        showLoading(true)
        let number = category?.number
        listingService.getCategory(number).then { category -> Void in
            // Hide loading
            self.showLoading(false)
            self.category = category
            self.filteredSubcategories = category.subcategories.filter { $0.count > 0 }
            self.tableView.reloadData()
            }.error { error in
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide "Back"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        if category == nil || category?.isRoot == true {
            navigationController?.setNavigationBarHidden(true, animated: false)
            return
        }
        
        // Navigation item center
        navigationController?.setNavigationBarHidden(false, animated: false)
        titleView.frame = CGRectMake(0, 0, 200.0, 40.0)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.translucent = false
        titleView.titleLabel.text = category?.name
        updateDetailLabel()
        
        // Navigation item right
        let doneButton = UIBarButtonItem(
            title: NSLocalizedString("Done", comment: ""),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: #selector(CategoryViewController.onDonePressed))
        navigationItem.rightBarButtonItem = doneButton
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let navigationController = navigationController {
            // Back was pressed
            if navigationController.viewControllers.indexOf(self) == nil {
                if let categoryViewController = navigationController.viewControllers.last as? CategoryViewController {
                    // Select parent category
                    if let parentCategory = categoryViewController.category {
                        delegate?.didChooseCategory(parentCategory, viewController: categoryViewController)
                    }
                }
            }
        }
    }
    
    // MARK: Done button events
    func onDonePressed() {
        if let category = category {
            delegate?.didChooseCategory(category, viewController: self)
            delegate?.didFinishChoosingCategory(self)
        }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSubcategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = CellIdentifiers.categoryCell.rawValue
        guard let category = category else { return UITableViewCell() }
        guard
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier),
            let categoryCell = cell as? CategoryCell
            else { fatalError("failed to dequeue cell with identifier: \(cellIdentifier)") }
        
        let subcategory = filteredSubcategories[indexPath.row]
        categoryCell.titleLabel.text = subcategory.name
        let format = NSLocalizedString("%li", comment: "")
        categoryCell.detailLabel.text = subcategory.count > 0 ?
            String(format: format, subcategory.count) :
            ""
        categoryCell.accessibilityLabel = subcategory.name
        
        // Assume root subcategories always expandable
        categoryCell.accessoryType = (category.isRoot || subcategory.subcategories.count > 0) ?
            UITableViewCellAccessoryType.DisclosureIndicator :
            UITableViewCellAccessoryType.None
        
        return categoryCell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        guard let category = category else { return }
        
        let subcategory = filteredSubcategories[indexPath.row]
        
        delegate?.didChooseCategory(subcategory, viewController: self)
        
        // If category has no subcategories, dismiss the category view
        // Except when it's root category
        if (!category.isRoot && subcategory.subcategories.count == 0) {
            delegate?.didFinishChoosingCategory(self)
            return
        }
        
        guard let categoryViewController = UIStoryboard(name: Storyboards.main, bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier(ViewControllers.categoryViewController) as? CategoryViewController else {
            fatalError("failed to dequeue view controller with identifier: \(ViewControllers.categoryViewController)")
        }
        
        categoryViewController.category = subcategory
        categoryViewController.delegate = delegate
        navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 42.0
    }
    
    // MARK: Private 
    
    /**
     Show / Hide loading view
     
     - parameter flag: false to hide loading view
     - returns: self for chainability
     */
    func showLoading(flag: Bool) -> Self {
        loading = flag
        updateDetailLabel()
        return self
    }
    
    /**
     Update detail label to show number of listings
     */
    func updateDetailLabel() {
        let format = NSLocalizedString("%li listings", comment: "")
        titleView.detailLabel.text = loading ?
            NSLocalizedString("Loading...", comment: "") :
            String(format: format, category?.count ?? 0)
    }
}

