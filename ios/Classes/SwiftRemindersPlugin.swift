import Flutter

public class SwiftRemindersPlugin: NSObject, FlutterPlugin {

  let reminders = Reminders()
  let calendars = Events()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "reminders", binaryMessenger: registrar.messenger())
    let instance = SwiftRemindersPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {

      case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)

      case "hasAccess":
        result(self.reminders.hasAccess)

      case "requestPermission":
        result(self.reminders.requestPermission())

      case "getDefaultListId":
        result(self.reminders.getDefaultListId())

      case "getDefaultList":
        result(self.reminders.getDefaultList())

      case "getAllLists":
        result(self.reminders.getAllLists())

      case "getReminders":
        if let args = call.arguments as? [String: String?] {
          if let id = args["id"] {
            self.reminders.getReminders(id) { (reminders) in
              result(reminders)
            }
          }
        }

      case "saveReminder":
        if let args = call.arguments as? [String: Any] {
          if let reminder = args["reminder"] as? [String: Any] {
            self.reminders.saveReminder(reminder) { (error) in
              result(error)
            }
          }
        }

    case "deleteReminder":
      if let args = call.arguments as? [String: String] {
        if let id = args["id"] {
          self.reminders.deleteReminder(id) { (error) in
            result(error)
          }
        }
      }

      case "requestAccess":
        result (self.calendars.requestAccess())

      case "hasEventsAccess":
        result(self.calendars.hasEventsAccess())

      case "getDefaultCalendar":
        result(self.calendars.getDefaultCalendar())

      case "getAllCalendars":
        result(self.calendars.getAllCalendars())

      case "getEvents":
        result(self.calendars.getEvents() { (event) in
          result(event)
          })

      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
