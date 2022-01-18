//
//  ATTrac.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/18.
//
import AppTrackingTransparency
import AdSupport

class ATTrackingHelper: ObservableObject {
    @Published var status = ATTrackingManager.trackingAuthorizationStatus
    @Published var currentUUID = ASIdentifierManager.shared().advertisingIdentifier

    func requestAuth() {
        guard ATTrackingManager.trackingAuthorizationStatus != .authorized else {
            return
        }
        
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async { [unowned self] in
                self.status = status
                if status == .authorized {
                    self.currentUUID = ASIdentifierManager.shared().advertisingIdentifier
                } else {
                    return
                }
            }
        }
    }
}
