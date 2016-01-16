//
// Autogenerated by Natalie - Storyboard Generator Script.
// http://blog.krzyzanowskim.com
//

import UIKit

//MARK: - Storyboards

extension UIStoryboard {
    func instantiateViewController<T: UIViewController where T: IdentifiableProtocol>(type: T.Type) -> T? {
        let instance = type.init()
        if let identifier = instance.storyboardIdentifier {
            return self.instantiateViewControllerWithIdentifier(identifier) as? T
        }
        return nil
    }
}


protocol Storyboard {
    static var storyboard: UIStoryboard { get }
    static var identifier: String { get }
}

struct Storyboards {

    struct LaunchScreen: Storyboard {

        static let identifier = "LaunchScreen"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UIViewController {
            return self.storyboard.instantiateInitialViewController()!
        }

        static func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewControllerWithIdentifier(identifier)
        }

        static func instantiateViewController<T: UIViewController where T: IdentifiableProtocol>(type: T.Type) -> T? {
            return self.storyboard.instantiateViewController(type)
        }
    }

    struct Main: Storyboard {

        static let identifier = "Main"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UINavigationController {
            return self.storyboard.instantiateInitialViewController() as! UINavigationController
        }

        static func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewControllerWithIdentifier(identifier)
        }

        static func instantiateViewController<T: UIViewController where T: IdentifiableProtocol>(type: T.Type) -> T? {
            return self.storyboard.instantiateViewController(type)
        }

        static func instantiateDetailRepoModuleView() -> DetailRepoModuleView {
            return self.storyboard.instantiateViewControllerWithIdentifier("DetailRepoModuleView") as! DetailRepoModuleView
        }

        static func instantiateListRepoModuleView() -> ListRepoModuleView {
            return self.storyboard.instantiateViewControllerWithIdentifier("ListRepoModuleView") as! ListRepoModuleView
        }
    }
}

//MARK: - ReusableKind
enum ReusableKind: String, CustomStringConvertible {
    case TableViewCell = "tableViewCell"
    case CollectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

//MARK: - SegueKind
enum SegueKind: String, CustomStringConvertible {    
    case Relationship = "relationship" 
    case Show = "show"                 
    case Presentation = "presentation" 
    case Embed = "embed"               
    case Unwind = "unwind"             
    case Push = "push"                 
    case Modal = "modal"               
    case Popover = "popover"           
    case Replace = "replace"           
    case Custom = "custom"             

    var description: String { return self.rawValue } 
}

//MARK: - IdentifiableProtocol

public protocol IdentifiableProtocol: Equatable {
    var storyboardIdentifier: String? { get }
}

//MARK: - SegueProtocol

public protocol SegueProtocol {
    var identifier: String? { get }
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ==<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ~=<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ==<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

public func ~=<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

//MARK: - ReusableViewProtocol
public protocol ReusableViewProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? { get }
}

public func ==<T: ReusableViewProtocol, U: ReusableViewProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.storyboardIdentifier == rhs.storyboardIdentifier
}

//MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableViewProtocol {
    public var viewType: UIView.Type? { return self.dynamicType }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

extension UITableViewCell: ReusableViewProtocol {
    public var viewType: UIView.Type? { return self.dynamicType }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

//MARK: - UIViewController extension
extension UIViewController {
    func performSegue<T: SegueProtocol>(segue: T, sender: AnyObject?) {
        if let identifier = segue.identifier {
            performSegueWithIdentifier(identifier, sender: sender)
        }
    }

    func performSegue<T: SegueProtocol>(segue: T) {
        performSegue(segue, sender: nil)
    }
}

//MARK: - UICollectionView

extension UICollectionView {

    func dequeueReusableCell<T: ReusableViewProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> UICollectionViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: forIndexPath)
        }
        return nil
    }

    func registerReusableCell<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.storyboardIdentifier {
            registerClass(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableViewProtocol>(elementKind: String, withReusable reusable: T, forIndexPath: NSIndexPath!) -> UICollectionReusableView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: identifier, forIndexPath: forIndexPath)
        }
        return nil
    }

    func registerReusable<T: ReusableViewProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, identifier = reusable.storyboardIdentifier {
            registerClass(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
//MARK: - UITableView

extension UITableView {

    func dequeueReusableCell<T: ReusableViewProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> UITableViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCellWithIdentifier(identifier, forIndexPath: forIndexPath)
        }
        return nil
    }

    func registerReusableCell<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.storyboardIdentifier {
            registerClass(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableViewProtocol>(reusable: T) -> UITableViewHeaderFooterView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableHeaderFooterViewWithIdentifier(identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.storyboardIdentifier {
             registerClass(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}


//MARK: - DetailRepoModuleView
extension DetailRepoModuleView: IdentifiableProtocol { 
    var storyboardIdentifier: String? { return "DetailRepoModuleView" }
    static var storyboardIdentifier: String? { return "DetailRepoModuleView" }
}


//MARK: - ListRepoModuleView
extension ListRepoModuleView: IdentifiableProtocol { 
    var storyboardIdentifier: String? { return "ListRepoModuleView" }
    static var storyboardIdentifier: String? { return "ListRepoModuleView" }
}

