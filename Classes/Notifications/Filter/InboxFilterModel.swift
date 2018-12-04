//
//  InboxFilterModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

struct InboxFilterModel: ListSwiftDiffable {

    enum FilterType: Equatable {
        case all
        case assigned
        case created
        case mentioned
        case repo(owner: String, name: String)

        var title: String {
            switch self {
            case .all: return Constants.Strings.inbox
            case .assigned: return NSLocalizedString("Assigned", comment: "")
            case .created: return NSLocalizedString("Created", comment: "")
            case .mentioned: return NSLocalizedString("Mentioned", comment: "")
            case let .repo(_, name): return name
            }
        }

        var subtitle: String? {
            switch self {
            case .all, .assigned, .created, .mentioned: return nil
            case let .repo(owner, _): return owner
            }
        }

        var iconName: String? {
            switch self {
            case .all: return "inbox"
            case .assigned: return "person"
            case .created: return "plus"
            case .mentioned: return "mention"
            case .repo: return nil
            }
        }

        // MARK: Equatable

        static func == (lhs: FilterType, rhs: FilterType) -> Bool {
            return lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
        }

    }

    let type: FilterType

    // MARK: ListSwiftDiffable

    var identifier: String {
        return "\(type.title).\(type.subtitle ?? "")"
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return value is InboxFilterModel
    }

}
