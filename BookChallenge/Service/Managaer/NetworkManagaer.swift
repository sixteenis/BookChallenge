//
//  NetworkManagaer.swift
//  BookChallenge
//
//  Created by 박성민 on 9/4/24.
//
import UIKit
import Network


final class NetworkMonitor{
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected:Bool = false
    public private(set) var connectionType:ConnectionType = .unknown
    private var networkDisconnectedVC: NetworkConnectedVC?
    /// 연결타입
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init(){
        print("init 호출")
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        print("startMonitoring 호출")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            print("path :\(path)")

            self?.isConnected = path.status == .satisfied
            self?.getConenctionType(path)
            DispatchQueue.main.async {
                guard let self = self else { return }
                if self.isConnected == true{
                    print("연결 상태임!")
                    self.removeNetworkDisconnectedVC()
                }else{
                    print("연결 안된 상태임!")
                    self.showNetworkDisconnectedVC()
                }
            }
        }
    }
    
    public func stopMonitoring(){
        print("stopMonitoring 호출")
        monitor.cancel()
    }
    
    
    private func getConenctionType(_ path:NWPath) {
        print("getConenctionType 호출")
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
            print("wifi에 연결")

        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
            print("cellular에 연결")

        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
            print("wiredEthernet에 연결")

        }else {
            connectionType = .unknown
            print("unknown ..")
        }
    }
    private func showNetworkDisconnectedVC() {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
            
            if networkDisconnectedVC == nil {
                let networkVC = NetworkConnectedVC()
                networkDisconnectedVC = networkVC
                networkVC.modalPresentationStyle = .overFullScreen
                networkVC.modalTransitionStyle = .crossDissolve
                window.rootViewController?.present(networkVC, animated: true, completion: nil)
            }
        }
        
        private func removeNetworkDisconnectedVC() {
            networkDisconnectedVC?.dismiss(animated: true, completion: {
                self.networkDisconnectedVC = nil
            })
        }
}
