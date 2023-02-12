//
//  Persistence.swift
//  CountDown
//
//  Created by Fatma Gazwani on 11/06/1444 AH.
//
import SwiftUI
import CoreData

public class SerializableColor: NSObject, NSCoding, NSSecureCoding {
  public static var supportsSecureCoding: Bool = true
  
  public enum SerializableColorSpace: Int {
    case sRGB = 0
    case displayP3 = 1
  }
  
  let colorSpace: SerializableColorSpace
  let r: Float
  let g: Float
  let b: Float
  let a: Float
  
  public func encode(with coder: NSCoder) {
    coder.encode(colorSpace.rawValue, forKey: "colorSpace")
    coder.encode(r, forKey: "red")
    coder.encode(g, forKey: "green")
    coder.encode(b, forKey: "blue")
    coder.encode(a, forKey: "alpha")
  }
  
  required public init?(coder: NSCoder) {
    colorSpace = SerializableColorSpace(rawValue: coder.decodeInteger(forKey: "colorSpace")) ?? .sRGB
    r = coder.decodeFloat(forKey: "red")
    g = coder.decodeFloat(forKey: "green")
    b = coder.decodeFloat(forKey: "blue")
    a = coder.decodeFloat(forKey: "alpha")
  }
  
  init(colorSpace: SerializableColorSpace, red: Float, green: Float, blue: Float, alpha: Float) {
    self.colorSpace = colorSpace
    self.r = red
    self.g = green
    self.b = blue
    self.a = alpha
  }
  
  convenience init(from cgColor: CGColor) {
    var colorSpace: SerializableColorSpace = .sRGB
    var components: [Float] = [0, 0, 0, 0]
    
    // Transform the color into sRGB space
    if cgColor.colorSpace?.name == CGColorSpace.displayP3 {
      if let p3components = cgColor.components?.map({ Float($0) }),
         cgColor.numberOfComponents == 4 {
        colorSpace = .displayP3
        components = p3components
      }
    } else {
      if let sRGB = CGColorSpace(name: CGColorSpace.sRGB),
         let sRGBColor = cgColor.converted(to: sRGB, intent: .defaultIntent, options: nil),
         let sRGBcomponents = sRGBColor.components?.map({ Float($0) }),
         sRGBColor.numberOfComponents == 4 {
        components = sRGBcomponents
      }
    }
    self.init(colorSpace: colorSpace, red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
  
  convenience init(from color: Color) {
    self.init(from: UIColor(color))
  }
  
  convenience init(from uiColor: UIColor) {
    self.init(from: uiColor.cgColor)
  }
  
  var cgColor: CGColor {
    return uiColor.cgColor
  }
  
  var color: Color {
    return Color(self.uiColor)
  }
  
  var uiColor: UIColor {
    if colorSpace == .displayP3 {
      return UIColor(displayP3Red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    } else {
      return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
  }
}

// MARK: Transformer Class
// For CoreData compatibility.

@objc(SerializableColorTransformer)
class SerializableColorTransformer: NSSecureUnarchiveFromDataTransformer {
  override class var allowedTopLevelClasses: [AnyClass] {
    return super.allowedTopLevelClasses + [SerializableColor.self]
  }
  
  public override class func allowsReverseTransformation() -> Bool {
    return true
  }
  
  public override func transformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data else {return nil}
    return try! NSKeyedUnarchiver.unarchivedObject(ofClass: SerializableColor.self, from: data)
  }
  
  public override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let color = value as? SerializableColor else {return nil}
    return try! NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
  }
}

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "Simplify")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError ("Unable to initialize Core Data \(error)")
            }
        }
    }
}



struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Event(context: viewContext)
            newItem.duedate = Date()
        }
        do {
            try viewContext.save()
//            WidgetCenter.shared.reloadAllTimelines()

        } catch {

            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CountDown")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

}




