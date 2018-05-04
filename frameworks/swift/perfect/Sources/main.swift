import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()

var routes = Routes()

routes.add(method: .get, uri: "/") { _, response in
    response.completed()
}

routes.add(method: .get, uri: "/user/{id}") { request, response in
    response.setBody(string: request.urlVariables["id"] ?? "")
    response.completed()
}

routes.add(method: .post, uri: "/user") { _, response in
    response.completed()
}

server.addRoutes(routes)

server.serverPort = 8003

try! server.start()
