import PerfectHTTP
import PerfectHTTPServer
import Foundation

let server = HTTPServer()

var routes = Routes()

extension HTTPResponse {
    func addDateHeader() {
        let dateFormat = DateFormatter()
        dateFormat.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormat.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss z"
        addHeader(.date, value: dateFormat.string(from: .init()))
    }
}

routes.add(method: .get, uri: "/") { _, response in
    response.addDateHeader()
    response.completed()
}

routes.add(method: .get, uri: "/user/{id}") { request, response in
    response.addDateHeader()
    response.setBody(string: request.urlVariables["id"] ?? "")
    response.completed()
}

routes.add(method: .post, uri: "/user") { _, response in
    response.addDateHeader()
    response.completed()
}

server.addRoutes(routes)
server.serverPort = 8003

try! server.start()
