import SwiftUI
import Alamofire
import HTTPTypes
import Core
import CoreService
import FeatureService
import Feature

public struct ContentView: View {
    public init() {}

    public var body: some View {
        VStack {
            Button("Request") {
                Core.request()
            }

            Button("Check") {
                CoreService.service()
            }
            Button("Check") {
                FeatureService.service()
            }

            Button("Cancel") {
                Feature.feature()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
