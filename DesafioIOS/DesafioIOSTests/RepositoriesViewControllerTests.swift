//
//  RepositoriesViewControllerTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class RepositoriesViewControllerTests: XCTestCase {
    
    fileprivate var vc : MockRepositoriesViewController! = nil
    fileprivate let timeOutInterval : TimeInterval = 5.0
    
    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()
        self.vc = MockRepositoriesViewController()
    }
    
    override func tearDown() {
        self.vc = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testRefresh() {
        
        // Assert View Controller wasn't refreshed yet
        XCTAssertFalse(vc.didRefresh == true, "O View Controller não pode ter sido recarregado nesta fase.")
        
        // Launch
        vc.refresh()
        
        // Assert View Controller was refreshed
        XCTAssert(vc.didRefresh == true, "O View Controller deve ter sido recarregado nesta fase.")
    }
    
    func testTriggerRefreshControl() {
        
        // Init view
        var view : UIView? = vc.view
        
        // Trigger
        vc.triggerRefreshControl()
        
        // Assert
        XCTAssertNotNil(view, "Este View Controller não possui UIView.")
        XCTAssert(vc.refreshControl!.isRefreshing, "UIRefreshControl não foi ativado.")
        XCTAssert(vc.tableView.contentOffset.y != 0, "Content offset da UITableView não está diferente.")
        XCTAssert(vc.didRefresh == true, "O View Controller deve ter sido recarregado nesta fase.")
        
        // Release view
        view = nil
    }
    
    func testAddObservers() {
        
        // Try to Add observers
        vc.addObservers()
        
        // Test proprieties
        XCTAssertNotNil(vc.hasObservers, "Este View Controller não possui Observers.")
        XCTAssert(vc.hasObservers == true, "Não foram adicionados observers neste View Controller")
        
        // Try to Add observers
        vc.removeObservers()
    }
    
    func testRemoveObservers() {
        
        // Try to Add observers
        vc.addObservers()
        // Try to Add observers
        vc.removeObservers()
        
        // Test proprieties
        XCTAssertNotNil(vc.hasObservers, "Este View Controller possui Observers.")
        XCTAssert(vc.hasObservers == false, "Este View Controller possui Observers")
    }
    
    func testNotificationIsReachable() {
        
        // Try to Add observers
        vc.addObservers()
        
        // Launch Notification
        NotificationCenter.default.post(name: NotificationCenter.Name.Reachable, object: nil)
        
        // Test proprieties
        XCTAssertNotNil(vc.notificationReceived, "Este View Controller não recebeu notificações.")
        XCTAssert(vc.notificationReceived == NotificationCenter.Name.Reachable.rawValue, "Este View Controller não recebeu a notificação \"\(NotificationCenter.Name.Reachable.rawValue)\".")
        
        // Try to Add observers
        vc.removeObservers()
    }
    
    func testNotificationNotReachable() {
        
        // Try to Add observers
        vc.addObservers()
        
        // Launch Notification
        NotificationCenter.default.post(name: NotificationCenter.Name.NotReachable, object: nil)
        
        // Test proprieties
        XCTAssertNotNil(vc.notificationReceived, "Este View Controller não recebeu notificações.")
        XCTAssert(vc.notificationReceived == NotificationCenter.Name.NotReachable.rawValue, "Este View Controller não recebeu a notificação \"\(NotificationCenter.Name.NotReachable.rawValue)\".")
        
        // Try to Add observers
        vc.removeObservers()
    }
}

