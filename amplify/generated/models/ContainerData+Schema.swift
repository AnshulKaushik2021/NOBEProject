// swiftlint:disable all
import Amplify
import Foundation

extension ContainerData {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case containernum
    case containerstatus
    case lastDispensedDate
    case lastDispensedTime
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let containerData = ContainerData.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "ContainerData"
    
    model.fields(
      .id(),
      .field(containerData.containernum, is: .required, ofType: .string),
      .field(containerData.containerstatus, is: .required, ofType: .string),
      .field(containerData.lastDispensedDate, is: .required, ofType: .int),
      .field(containerData.lastDispensedTime, is: .required, ofType: .int),
      .field(containerData.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(containerData.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}