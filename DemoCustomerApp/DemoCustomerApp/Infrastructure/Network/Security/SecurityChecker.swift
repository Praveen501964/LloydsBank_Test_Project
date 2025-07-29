// SecurityChecker.swift

import Foundation

class SecurityChecker {
    
    static func isConnectionSecure(url: URL) -> Bool {
        return url.scheme == "https"
    }
    
    
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
