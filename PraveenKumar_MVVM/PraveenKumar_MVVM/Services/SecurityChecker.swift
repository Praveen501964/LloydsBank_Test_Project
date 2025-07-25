//
//  SecurityChecker.swift
//  PraveenKumar_MVVM
//
//  Created by 1976969 on 24/07/25.
//

import Foundation

class SecurityChecker {
    
    /// Default check for URL added
    /// - Parameter url: URL to test
    /// - Returns: Bool if the URL is passed
    static func isConnectionSecure(url: URL) -> Bool {
        return url.scheme == "https"
    }
    
    /// Test for jailbreak with few random checks
    /// - Returns: Returns true ot false based on data avialable in the give file path
    static func isDeviceJailBroken() -> Bool {
        
        #if targetEnvironment(simulator) // Allowing the simulator as of initial testing
          return false
        #else
        // Test for jail break
        let jailBreakIndicators = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        
        return jailBreakIndicators.contains(where: {FileManager.default.fileExists(atPath: $0)})
        #endif
    }
}
