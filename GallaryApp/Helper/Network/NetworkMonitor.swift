//
//  NetworkMonitor.swift
//
//

import Foundation
import Network

//  This singleton class is used to monitor network connection
class NetworkMonitor {
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    //  We need to call this function when app start and whenever network connection changes, a variable will be updated.
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            if path.status == .satisfied {
                CommonUtility.shared.appPrint("We're connected!")
                // post connected notification
            } else {
                CommonUtility.shared.appPrint("No connection.")
                // post disconnected notification
            }
            CommonUtility.shared.appPrint("isExpensive : \(path.isExpensive)")
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
