//
//  RSDestination.swift
//  Rudder
//
//  Created by Pallab Maiti on 17/08/21.
//  Copyright © 2021 Rudder Labs India Pvt Ltd. All rights reserved.
//

import Foundation

// swiftlint:disable inclusive_language

public enum EventFilteringOption: Int, CaseIterable {
    case disabled = 0
    case blackListed
    case whiteListed
}

extension EventFilteringOption {
    internal init?(rawString: String?) {
        switch rawString {
        case "blacklistedEvents":
            self.init(rawValue: 1)
        case "whitelistedEvents":
            self.init(rawValue: 2)
        default:
            self.init(rawValue: 0)
        }
    }
}

public struct Destination: Codable, Equatable {
    public let config: JSON?
    public let secretConfig: JSON?
    
    private let _id: String?
    public var id: String {
        return _id ?? ""
    }

    private let _name: String?
    public var name: String {
        return _name ?? ""
    }

    private let _enabled: Bool?
    public var enabled: Bool {
        return _enabled ?? false
    }
    
    private let _workspaceId: String?
    public var workspaceId: String {
        return _workspaceId ?? ""
    }
    
    private let _deleted: Bool?
    public var deleted: Bool {
        return _deleted ?? false
    }
    
    private let _createdAt: String?
    public var createdAt: String {
        return _createdAt ?? ""
    }
    
    private let _updatedAt: String?
    public var updatedAt: String {
        return _updatedAt ?? ""
    }
    
    public var eventFilteringOption: EventFilteringOption {
        return  EventFilteringOption(rawString: (config?.dictionaryValue?["eventFilteringOption"] as? String)) ?? .disabled
    }
    
    var blackListedEvents: [String]? {
        if let events = config?.dictionaryValue?["blacklistedEvents"] as? [[String: String]] {
            return events.compactMap { dict in
                dict["eventName"]
            }
        }
        return nil
    }
    
    var whiteListedEvents: [String]? {
        if let events = config?.dictionaryValue?["whitelistedEvents"] as? [[String: String]] {
            return events.compactMap { dict in
                dict["eventName"]
            }
        }
        return nil
    }

    public let destinationDefinition: DestinationDefinition?
    
    init(config: JSON?, secretConfig: JSON?, id: String?, name: String?, enabled: Bool?, workspaceId: String?, deleted: Bool?, createdAt: String?, updatedAt: String?, destinationDefinition: DestinationDefinition?) {
        self.config = config
        self.secretConfig = secretConfig
        self._id = id
        self._name = name
        self._enabled = enabled
        self._workspaceId = workspaceId
        self._deleted = deleted
        self._createdAt = createdAt
        self._updatedAt = updatedAt
        self.destinationDefinition = destinationDefinition
    }
    
    enum CodingKeys: String, CodingKey {
        case config, secretConfig
        case _id = "id"
        case _name = "name"
        case _enabled = "enabled"
        case _workspaceId = "workspaceId"
        case _deleted = "deleted"
        case _createdAt = "createdAt"
        case _updatedAt = "updatedAt"
        case destinationDefinition
    }
}
