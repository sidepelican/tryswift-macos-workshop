import Cocoa

/// This is required to properly detect Bindings Errors at runtime
@objc public final class CCApplication: NSApplication {
    @objc func _crashOnException(_ exception: NSException) {
        print("exception: \(exception)")
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        ValueTransformer.setValueTransformer(ImageEmbeddingTransformer(), forName: NSValueTransformerName(rawValue: "ImageEmbeddingTransformer"))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


