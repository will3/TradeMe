
//
//  ViewController.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import UIKit

protocol CategoryViewControllerDelegate: class {
    func didChooseCategory(category: Category, viewController: CategoryViewController)
    func didFinishChoosingCategory(viewController: CategoryViewController)
}

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listingService = ListingService()
    var category: Category?
    var filteredSubcategories = [Category]()
    var titleView = CategoryTitleView().setupSubviews()
    var loading = true
    
    weak var delegate: CategoryViewControllerDelegate?
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCells([CellIdentifiers.categoryCell, CellIdentifiers.loadingCell])
        
        let number = category?.number
        
        showLoading(true)
        listingService.getCategory(number).then { category -> Void in
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
        
        // Center
        navigationController?.setNavigationBarHidden(false, animated: false)
        titleView.frame = CGRectMake(0, 0, 200.0, 40.0)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.translucent = false
        titleView.titleLabel.text = category?.name
        updateDetailLabel()
        
        // Right
        let doneButton = UIBarButtonItem(
            title: NSLocalizedString("Done", comment: ""),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: #selector(CategoryViewController.onDonePressed))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let category = category {
            delegate?.didChooseCategory(category, viewController: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onDonePressed() {
        if let category = category {
            delegate?.didChooseCategory(category, viewController: self)
            delegate?.didFinishChoosingCategory(self)
        }
    }
    
    func showLoading(flag: Bool) -> Self {
        loading = flag
        updateDetailLabel()
        return self
    }
    
    func updateDetailLabel() {
        let format = NSLocalizedString("%li listings", comment: "")
        titleView.detailLabel.text = loading ?
            NSLocalizedString("Loading...", comment: "") :
            String(format: format, category?.count ?? 0)
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
}

