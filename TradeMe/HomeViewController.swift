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

/**
 HomeViewController is the first screen the user sees

 Use search bar to search by term
 
 Use filter button to filter by category
 
 Tap on any listing to see details
 */
class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate, CategoryViewControllerDelegate, UISearchBarDelegate, ListingTableControllerDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    // MARK: Injected
    
    // Listing service
    var listingService: ListingService!
    // Listing table controller
    var listingTableController: ListingTableControllerProtocol!
    
    // MARK: Properties
    
    // Search bar shown
    var searchBar = UISearchBar()
    // Page size
    var pageSize = 20
    // Current page
    var page = 1
    // Category selected, if any
    var category: Category?
    // List shown
    var list = [Listing]()
    // If set to false , skip property injection, used in tests
    var injectDependencies = true
    
    // Total count of listings
    private var totalCount = 0
    
    private var canLoadMore: Bool {
        return page * pageSize < totalCount
    }
    
    private let refreshControl = UIRefreshControl()
    
    // Throttle used to limit number of api calls down by changing the search bar text
    var searchBarTextThrottle = Throttle<String>()
    
    // Category popup instance to cache, managed internally
    private var categoryPopup: UIViewController?
    // True is navigation bar and filter button is hidden
    private var viewExpanded = false
    // Flag for keyboard shown
    private var keyboardShown = false
    // Flag for loading more
    private var loadingMore = false
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccessibilityIdentifiers.homeView.set(viewController: self)
        
        if injectDependencies {
            Injector.defaultInjector.injectDependencies(self)
            listingTableController = Injector.defaultInjector.resolve("listingTableController") as! ListingTableControllerProtocol
        }
        
        // Set up table view
        listingTableController.hookTableView(tableView)
        listingTableController.delegate = self
        
        // Set up scroll view events
        listingTableController.scrollViewTracker
            .on(.SwipeUp) { _ in
                // Collapse view when swipe up
                if !self.keyboardShown && self.viewExpanded {
                    self.collapseView()
                }
            }
            .on(.SwipeDown) { _ in
                // Expand view when swipe down
                if !self.keyboardShown && !self.viewExpanded {
                    self.expandView()
                }
            }
            .on(.BounceTop) { _ in
                // Collapse view when bounce top
                if !self.keyboardShown && self.viewExpanded {
                    self.collapseView()
                }
            }
            .on(.BounceBottom) { _ in
                if self.canLoadMore && !self.loadingMore {
                    self.loadingMore = true
                    self.loadMore() {
                        self.loadingMore = false
                    }
                }
        }
        
        // Set up navigation title view
        searchBar.frame = CGRectMake(0, 0, 260.0, 30.0)
        searchBar.delegate = self
        AccessibilityIdentifiers.searchBar.set(view: searchBar)
        navigationItem.titleView = searchBar
        updateSearchbarPlaceholder()
        
        // Set up navigation bar color
        navigationController?.navigationBar.barTintColor = Colors.primary
        navigationController?.navigationBar.translucent = false
        
        // Update listing
        updateList()
        
        // Set up search bar throttle
        searchBarTextThrottle.next { searchText in
            self.updateList()
        }
        
        StatusBar.setBackgroundColor(Colors.primary)
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(HomeViewController.onRefreshControl), forControlEvents: UIControlEvents.ValueChanged)
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
    
    // MARK: IBAction
    
    @IBAction func onFilterPressed(sender: UIButton) {
        if let categoryPopup = categoryPopup {
            configurePopover(categoryPopup)
            presentViewController(categoryPopup, animated: true) { }
        } else {
            performSegueWithIdentifier(Segues.category, sender: nil)
        }
    }
    
    // MARK: Refresh control events
    
    func onRefreshControl() {
        listingTableController.scrollViewTracker.lock(true)
        updateList() {
            self.refreshControl.endRefreshing()
            // Gets around an issue when offset is tracked incorrectly when refresh control is minimized
            delay(1.0) {
                self.listingTableController.scrollViewTracker.lock(false)
            }
        }
    }
    
    // MARK: Keyboard events
    
    func keyboardDidShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().height ?? 0
        
        if keyboardHeight > 0 {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
            tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
        }
        
        keyboardShown = true
    }
    
    func keyboardDidHide(notification: NSNotification) {
        tableView.scrollIndicatorInsets = UIEdgeInsetsZero
        tableView.contentInset = UIEdgeInsetsZero
        
        keyboardShown = false
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
    
    private func updateList(completion: (() -> Void)? = nil) {
        // Reset page
        page = 1
        
        let request = buildRequest()
        listingService.search(request).then { result -> Void in
            self.totalCount = result.totalCount
            self.list = result.list
            self.listingTableController.reloadData(self.tableView, list: result.list)
            completion?()
        }
    }
    
    private func loadMore(completion: () -> Void) {
        page += 1
        
        let request = buildRequest()
        
        listingTableController.showLoading(true)
        let start = NSDate()
        // Api is too fast, set a min loading time
        let minLoadingTime = 1000.0
        listingService.search(request).then { result -> Void in
            let end = NSDate()
            let timeTaken = end.timeIntervalSinceDate(start)
            var diff = minLoadingTime - timeTaken
            if diff < 0 { diff = 0 }
            
            // Delay so loading time is at least 1 sec
            delay(diff / 1000.0) {
                
                // Get around an issue where offset is tracked incorrectly when new listings are inserted
                self.listingTableController.scrollViewTracker.lock(true)
                
                self.listingTableController
                    .showLoading(false)
                    .loadMore(self.tableView, list: result.list)
                
                // No offsets tracked for 1 sec
                delay(1.0) {
                    self.listingTableController.scrollViewTracker.lock(false)
                }
                completion()
            }
        }
    }
    
    private func buildRequest() -> SearchRequest {
        let request = SearchRequest()
        request.search_string = searchBar.text
        request.category = category?.number
        request.page = page
        request.rows = pageSize
        request.photo_size = PhotoSize.Medium
        return request
    }
    
    private func configurePopover(popover: UIViewController) {
        popover.modalPresentationStyle = UIModalPresentationStyle.Popover
        popover.popoverPresentationController?.sourceRect = filterButton.bounds
        popover.popoverPresentationController?.sourceView = filterButton
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
            self.filterButton.alpha = 0.0
        }
    }
    
    private func collapseView() {
        viewExpanded = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIView.animate {
            self.filterButton.alpha = 1.0
        }
    }
}