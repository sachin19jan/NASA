//
//  Created by Sachin, Bhardwaj
//

import Foundation
import Network

enum Reachable {
    case yes, no
}

enum Connection {
    case cellular, loopback, wifi, wiredEthernet, other
}

protocol NetworkCheckObserver: AnyObject {
    func statusDidChange(status: NWPath.Status)
}

class NetworkMonitor {
    weak var observer: NetworkCheckObserver?

    private var monitor = NWPathMonitor()
    private static let _sharedInstance = NetworkMonitor()
    var currentStatus: NWPath.Status {
        monitor.currentPath.status
    }

    var connectionStatus = Connection.other

    var isInternetConnected = Reachable.yes

    static let shared = NetworkMonitor()

    init() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}

extension NetworkMonitor {
    func startMonitoring(callBack: @escaping (_ connection: Connection, _ rechable: Reachable) -> Void) {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.observer?.statusDidChange(status: path.status)
            }
            let reachable = (path.status == .unsatisfied || path.status == .requiresConnection) ? Reachable.no : Reachable.yes
            if path.availableInterfaces.count == 0 {
                self?.isInternetConnected = .no
                return callBack(.other, .no)
            } else if path.usesInterfaceType(.wifi) {
                self?.connectionStatus = .wifi
                return callBack(.wifi, reachable)
            } else if path.usesInterfaceType(.cellular) {
                self?.connectionStatus = .cellular
                return callBack(.cellular, reachable)
            } else if path.usesInterfaceType(.loopback) {
                self?.connectionStatus = .loopback
                return callBack(.loopback, reachable)
            } else if path.usesInterfaceType(.wiredEthernet) {
                self?.connectionStatus = .wiredEthernet
                return callBack(.wiredEthernet, reachable)
            } else if path.usesInterfaceType(.other) {
                self?.connectionStatus = .other
                return callBack(.other, reachable)
            }
        }
    }
}

extension NetworkMonitor {
    func cancel() {
        monitor.cancel()
    }
}
