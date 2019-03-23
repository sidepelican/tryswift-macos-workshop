import Cocoa

final class ImageEmbeddingTransformer: ValueTransformer {
    override init() {
        super.init()
    }

    override class func transformedValueClass() -> AnyClass {
        return NSAttributedString.self
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let v = value as? SystemProcess else { return nil }

        let imageAttachment = NSTextAttachment()
        let iconSize = NSSize(width: 14, height: 14)
        imageAttachment.image = NSImage(size: iconSize, flipped: true) { rect in
            v.icon?.draw(in: rect, from: .zero, operation: .sourceOver, fraction: 1.0)
            return true
        }

        let iconOrigin = CGPoint(x: 0, y: -2)
        imageAttachment.bounds = CGRect(origin: iconOrigin, size: iconSize)

        let ret = NSMutableAttributedString(attachment: imageAttachment)
        ret.append(NSAttributedString(string: " "))
        ret.append(NSAttributedString(string: v.name ?? ""))
        return ret
    }
}
