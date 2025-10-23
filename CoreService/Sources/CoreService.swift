import Foundation
import Alamofire
import HTTPTypes

public class CoreService {
    public static func service() {
        Task {
            let response = await AF.request(URL(string: "https://httpbin.org/get")!)
                .serializingString()
                .response

            let status = HTTPResponse.Status(code: response.response?.statusCode ?? 0)
            print(status)
            print(response)
        }
    }
}
