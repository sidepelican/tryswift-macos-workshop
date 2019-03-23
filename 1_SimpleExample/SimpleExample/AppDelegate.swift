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
    @IBOutlet weak var arrayController: NSArrayController!

    @objc dynamic var selectedDeveloper: NSIndexSet? {
        didSet {
            guard let selectedIndex = selectedDeveloper?.firstIndex,
                let developers = arrayController.content as? NSArray,
                selectedIndex < developers.count,
                let developer = developers.object(at: selectedIndex) as? Developer else {
                    return
            }

            print(developer.username)
        }
    }

    override init() {
        ValueTransformer.setValueTransformer(EmptySelectionMeans(emptyValue: true),
                                             forName: NSValueTransformerName("EmptySelectionMeans"))

        super.init()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        arrayController.content = NSMutableArray(array: Model.developers)
    }
}

