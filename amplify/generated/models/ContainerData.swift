// swiftlint:disable all
import Amplify
import Foundation

public struct ContainerData: Model {
  public let id: String
  public var containernum: String
  public var containerstatus: String
  public var lastDispensedDate: Int
  public var lastDispensedTime: Int
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      containernum: String,
      containerstatus: String,
      lastDispensedDate: Int,
      lastDispensedTime: Int) {
    self.init(id: id,
      containernum: containernum,
      containerstatus: containerstatus,
      lastDispensedDate: lastDispensedDate,
      lastDispensedTime: lastDispensedTime,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      containernum: String,
      containerstatus: String,
      lastDispensedDate: Int,
      lastDispensedTime: Int,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.containernum = containernum
      self.containerstatus = containerstatus
      self.lastDispensedDate = lastDispensedDate
      self.lastDispensedTime = lastDispensedTime
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}