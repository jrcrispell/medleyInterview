
import UIKit
import Reachability
/// NetworkStatus encapsulates the network connectivity state of the system.
final class NetworkStatus: NSObject {
    
    static let notificationName = Notification.Name(rawValue: "network_status")
    
    let isConnected: Bool
    let isWifi: Bool
    /// a nil host indicates this is a generic internet connection status
    let host: String?
    
    class var isCurrentlyConnected: Bool {
        guard let reachability = currentReachability else {
            return false
        }
        return reachability.connection != .unavailable
    }
    
    class var isCurrentlyWifi: Bool {
        guard let reachability = currentReachability else {
            return false
        }
        return reachability.connection == .wifi
    }
    
    override var description: String {
        
        var result = "\(String(describing: type(of: self))): "
        result += isConnected ? "Connected" : "Disconnected"
        if isWifi {
            result += " on WiFi"
        }
        return result
    }
    
    init(isConnected: Bool, isWifi: Bool, host: String?) {
        self.isConnected = isConnected
        self.isWifi = isWifi
        self.host = host
        super.init()
    }
    
    private func notify() {
        
        print(description)
        
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: NetworkStatus.notificationName, object: self)
        })
    }
    
    class func registerForNotification(_ observer: AnyObject, selector: Selector) {
        initReachability(forHost: nil)
        NotificationCenter.default.addObserver(observer, selector: selector, name: NetworkStatus.notificationName, object: nil)
    }
    
    class func unregisterForNotification(_ observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer, name: NetworkStatus.notificationName, object: nil)
    }
    
    class func listenForHost(_ host: String) {
        initReachability(forHost: host)
    }
    
    
    // MARK: - Reachability implementation
    
    private static var currentReachability: Reachability? {
        do {
            return try Reachability()
        } catch {
            print("Unable to create Internet Reachability")
            return nil
        }
    }
    
    private static var _internetReachability: Reachability?
    private static var internetReachability: Reachability? {
        if _internetReachability == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: Notification.Name.reachabilityChanged, object: _internetReachability)
            
            createReachability()
        }
        return _internetReachability
    }
    
    private static var refreshedReachability: Reachability?
    private static func createReachability() {

        _internetReachability = currentReachability
        
        do {
            try _internetReachability?.startNotifier()
            
        } catch {
            print("Unable to start Internet Reachability Notifier")
        }
        
        _internetReachability?.whenUnreachable = { _ in
            if refreshedReachability == nil {
                createReachability()
                refreshedReachability = _internetReachability
            }
        }
        
        _internetReachability?.whenReachable = { _ in
            refreshedReachability = nil
        }
    }
    
    private static var hostReachabilities = [String: Reachability]()
    private static var reachabilityHosts = [ObjectIdentifier: String]()
    private static let hostSemaphore = DispatchSemaphore(value: 1)
    
    private class func initReachability(forHost host: String?) {
        
        // reachability can only init on the main thread, ensure we are there
        if !Thread.isMainThread {
            DispatchQueue.main.async(execute: {
                NetworkStatus.initReachability(forHost: host)
            })
            return
        }
        
        hostSemaphore.wait()
        defer {
            hostSemaphore.signal()
        }
        
        if let host = host {
            if hostReachabilities[host] == nil {
                guard let reachability = try? Reachability(hostname: host) else {
                    return
                }
                NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: Notification.Name.reachabilityChanged, object: reachability)
                
                let reachabilityId = ObjectIdentifier(reachability)
                do {
                    try reachability.startNotifier()
                    hostReachabilities[host] = reachability
                    reachabilityHosts[reachabilityId] = host
                } catch {
                    print("Unable to create Reachability for \(host)")
                    return
                }
            }
        } else {
            if self.internetReachability == nil {
                // error will already be logged
                return
            }
        }
    }
    
    @objc class func reachabilityChanged(_ notification: Notification) {
        
        guard let reachability = notification.object as? Reachability else {
            print("Unexpected object for Reachability notification")
            return
        }
        
        let reachabilityId = ObjectIdentifier(reachability)
        
        hostSemaphore.wait()
        defer {
            hostSemaphore.signal()
        }
        
        NetworkStatus(isConnected: reachability.connection != .unavailable, isWifi: reachability.connection == .wifi, host: NetworkStatus.reachabilityHosts[reachabilityId]).notify()
    }
}

extension Reachability: Hashable {

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(description)
    }
    
    public static func == (lhs: Reachability, rhs: Reachability) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
