//
//  HomeViewController.swift
//  TradeMe
//
//  Created by will3 on 15/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import UIKit
import AppInjector

class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate, CategoryViewControllerDelegate, UISearchBarDelegate, ListingTableControllerDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var headerContainerTopConstraint: NSLayoutConstraint!
    
    var listingService = ListingService()
    var category: Category?
    var searchBar = UISearchBar()
    var pageSize = 20
    var page = 1
    
    var list = [Listing]()
    
    var listingTableController: ListingTableController!
    
    var categoryPopup: UIViewController?
    
    var searchBarTextThrottle = Throttle<String>()
    
    var viewExpanded = false
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Injector.defaultInjector.injectDependencies(self)
        
        listingTableController.hookTableView(tableView)
        listingTableController.delegate = self
        listingTableController.scrollViewTracker
            .onScrollUp { scrollView in
                if self.viewExpanded {
                    self.collapseView()
                }
            }
            .onScrollDown { scrollView in
                if !self.viewExpanded {
                    self.expandView()
                }
        }
        
        searchBar.frame = CGRectMake(0, 0, 260.0, 30.0)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        navigationController?.navigationBar.barTintColor = Colors.primary
        navigationController?.navigationBar.translucent = false
        
        updateList()
        
        searchBarTextThrottle.next { searchText in
            self.updateList()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Hide "Back"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Colors.secondary
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func onCategoryButtonPressed(sender: UIButton) {
        if let categoryPopup = categoryPopup {
            configurePopover(categoryPopup)
            presentViewController(categoryPopup, animated: true) { }
        } else {
            performSegueWithIdentifier(Segues.category, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.category {
            let viewController = segue.destinationViewController
            configurePopover(viewController)
            
            if let navController = viewController as? UINavigationController,
                let categoryViewController = navController.viewControllers[0] as? CategoryViewController {
                categoryViewController.delegate = self
                categoryViewController.category = category
                
                categoryPopup = viewController
            }
        } else if segue.identifier == Segues.listingDetail {
            guard let viewController = segue.destinationViewController as? ListingDetailViewController else {
                return
            }
            guard let listing = sender as? Listing else { return }
            viewController.listing = listing
        }
    }
    
    // MARK: Keyboard events
    
    func keyboardDidShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().height ?? 0
        
        if keyboardHeight > 0 {
            var insets = tableView.contentInset
            insets.bottom = keyboardHeight
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        tableView.scrollIndicatorInsets = UIEdgeInsetsZero
        tableView.contentInset = UIEdgeInsetsZero
    }
    
    // MARK: Search bar events
    
    func searchBarCancelPressed() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    // MARK: ChoiceViewControllerDelegate
    
    func didChooseCategory(category: Category, viewController: CategoryViewController) {
        self.category = category
        updateSearchbarPlaceholder()
        updateList()
    }
    
    func didFinishChoosingCategory(viewController: CategoryViewController) {
        dismissViewControllerAnimated(true) { }
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        if text.isEmpty { return }
        
        updateList()
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        showSearchbarCancelButton(true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        showSearchbarCancelButton(false)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTextThrottle.input(searchText)
    }
    
    // MARK: ListingTableControllerDelegate
    
    func listingTableController(tableController: ListingTableController, didSelectListing listing: Listing) {
        performSegueWithIdentifier(Segues.listingDetail, sender: listing)        
    }
    
    // MARK: Private
    
    private func updateSearchbarPlaceholder() {
        if category == nil || category?.isRoot == true {
            searchBar.placeholder = NSLocalizedString("Search Trade Me", comment: "")
        } else {
            let format = NSLocalizedString("Search in %@", comment: "")
            searchBar.placeholder = String(format: format, category?.name ?? "")
        }
    }
    
    private func updateList() {
        let request = SearchRequest()
        request.search_string = searchBar.text
        request.category = category?.number
        request.page = page
        request.rows = pageSize
        listingService.search(request).then { result -> Void in
            self.list = result.list
            self.listingTableController.reloadData(self.tableView, list: result.list)
        }
    }
    
    private func configurePopover(popover: UIViewController) {
        popover.modalPresentationStyle = UIModalPresentationStyle.Popover
        popover.popoverPresentationController?.sourceRect = categoryButton.bounds
        popover.popoverPresentationController?.sourceView = self.categoryButton
        popover.popoverPresentationController?.delegate = self
    }
    
    private func showSearchbarCancelButton(flag: Bool) {
        if(flag) {
            let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeViewController.searchBarCancelPressed))
            navigationItem.rightBarButtonItem = cancelButton
            cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName: Colors.secondary], forState: UIControlState.Normal)
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func expandView() {
        viewExpanded = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate {
            self.headerContainer.alpha = 0.0
            self.headerContainerTopConstraint.constant = -Layout.homeHeaderContainerHeight
        }
    }
    
    private func collapseView() {
        viewExpanded = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIView.animate {
            self.headerContainer.alpha = 1.0
            self.headerContainerTopConstraint.constant = 0.0
        }
    }
}