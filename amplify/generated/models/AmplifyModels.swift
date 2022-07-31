// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "dbb9b2fb16d0af0039697565c9d0e940"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: ContainerData.self)
  }
}