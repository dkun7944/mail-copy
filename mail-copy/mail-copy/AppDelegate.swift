//
//  AppDelegate.swift
//  mail-copy
//
//  Created by Daniel Kuntz on 11/30/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSUserNotificationCenter.default.delegate = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        for url in urls {
            if url.scheme == "mailto" {
                let emailAddress = url.absoluteString.replacingOccurrences(of: "mailto:", with: "").components(separatedBy: "?").first ?? ""
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(emailAddress, forType: .string)
                let notification = NSUserNotification()
                notification.title = "Email Copied"
                notification.informativeText = "\(emailAddress)"
                NSUserNotificationCenter.default.deliver(notification)
            }
        }
        NSApp.terminate(self)
    }
}

extension AppDelegate: NSUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}
