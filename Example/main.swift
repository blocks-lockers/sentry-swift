import Sentry
import Foundation

class ExampleProcessor: EventProcessor {
    public func process(event: inout SentryEvent) -> SentryEvent? {
        var e = event
        e.message = "Processed: \(String(describing:event.message))"
        return e
    }
}
do {
    try Sentry.start(configure: { o in
        o.dsn = "https://82e5a3e0d7044ab582d47d1e4ff1ef2b@o117736.ingest.sentry.io/5414046"
        o.beforeSend = { e in 
            e.message = "BeforeSend: \(String(describing:e.message))"
            return e
        }
    })
} catch {
    print("Couldn't init Sentry: \(error)")
}

Sentry.configure(scope: { o in
    o.add(eventProcessor: ExampleProcessor())
})

// let os = ProcessInfo().operatingSystemVersion
// print(os)


Sentry.capture(message: "hi swift!")

let hey: Int? = nil
// Can't unwrap nil:
// Sentry.capture(message: String(hey!))

Sentry.close()