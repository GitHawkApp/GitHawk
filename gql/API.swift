//  This file was automatically generated and should not be edited.

import Apollo

/// Emojis that can be attached to Issues, Pull Requests and Comments.
public enum ReactionContent: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Represents the 👍 emoji.
  case thumbsUp
  /// Represents the 👎 emoji.
  case thumbsDown
  /// Represents the 😄 emoji.
  case laugh
  /// Represents the 🎉 emoji.
  case hooray
  /// Represents the 😕 emoji.
  case confused
  /// Represents the ❤️ emoji.
  case heart
  /// Represents the 🚀 emoji.
  case rocket
  /// Represents the 👀 emoji.
  case eyes
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "THUMBS_UP": self = .thumbsUp
      case "THUMBS_DOWN": self = .thumbsDown
      case "LAUGH": self = .laugh
      case "HOORAY": self = .hooray
      case "CONFUSED": self = .confused
      case "HEART": self = .heart
      case "ROCKET": self = .rocket
      case "EYES": self = .eyes
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .thumbsUp: return "THUMBS_UP"
      case .thumbsDown: return "THUMBS_DOWN"
      case .laugh: return "LAUGH"
      case .hooray: return "HOORAY"
      case .confused: return "CONFUSED"
      case .heart: return "HEART"
      case .rocket: return "ROCKET"
      case .eyes: return "EYES"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ReactionContent, rhs: ReactionContent) -> Bool {
    switch (lhs, rhs) {
      case (.thumbsUp, .thumbsUp): return true
      case (.thumbsDown, .thumbsDown): return true
      case (.laugh, .laugh): return true
      case (.hooray, .hooray): return true
      case (.confused, .confused): return true
      case (.heart, .heart): return true
      case (.rocket, .rocket): return true
      case (.eyes, .eyes): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// The possible commit status states.
public enum StatusState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Status is expected.
  case expected
  /// Status is errored.
  case error
  /// Status is failing.
  case failure
  /// Status is pending.
  case pending
  /// Status is successful.
  case success
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "EXPECTED": self = .expected
      case "ERROR": self = .error
      case "FAILURE": self = .failure
      case "PENDING": self = .pending
      case "SUCCESS": self = .success
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .expected: return "EXPECTED"
      case .error: return "ERROR"
      case .failure: return "FAILURE"
      case .pending: return "PENDING"
      case .success: return "SUCCESS"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: StatusState, rhs: StatusState) -> Bool {
    switch (lhs, rhs) {
      case (.expected, .expected): return true
      case (.error, .error): return true
      case (.failure, .failure): return true
      case (.pending, .pending): return true
      case (.success, .success): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// The possible states of an issue.
public enum IssueState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// An issue that is still open
  case `open`
  /// An issue that has been closed
  case closed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "OPEN": self = .open
      case "CLOSED": self = .closed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .open: return "OPEN"
      case .closed: return "CLOSED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: IssueState, rhs: IssueState) -> Bool {
    switch (lhs, rhs) {
      case (.open, .open): return true
      case (.closed, .closed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// The possible states of a pull request.
public enum PullRequestState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// A pull request that is still open.
  case `open`
  /// A pull request that has been closed without being merged.
  case closed
  /// A pull request that has been closed by being merged.
  case merged
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "OPEN": self = .open
      case "CLOSED": self = .closed
      case "MERGED": self = .merged
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .open: return "OPEN"
      case .closed: return "CLOSED"
      case .merged: return "MERGED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PullRequestState, rhs: PullRequestState) -> Bool {
    switch (lhs, rhs) {
      case (.open, .open): return true
      case (.closed, .closed): return true
      case (.merged, .merged): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// The possible states of a pull request review.
public enum PullRequestReviewState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// A review that has not yet been submitted.
  case pending
  /// An informational review.
  case commented
  /// A review allowing the pull request to merge.
  case approved
  /// A review blocking the pull request from merging.
  case changesRequested
  /// A review that has been dismissed.
  case dismissed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "PENDING": self = .pending
      case "COMMENTED": self = .commented
      case "APPROVED": self = .approved
      case "CHANGES_REQUESTED": self = .changesRequested
      case "DISMISSED": self = .dismissed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .pending: return "PENDING"
      case .commented: return "COMMENTED"
      case .approved: return "APPROVED"
      case .changesRequested: return "CHANGES_REQUESTED"
      case .dismissed: return "DISMISSED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PullRequestReviewState, rhs: PullRequestReviewState) -> Bool {
    switch (lhs, rhs) {
      case (.pending, .pending): return true
      case (.commented, .commented): return true
      case (.approved, .approved): return true
      case (.changesRequested, .changesRequested): return true
      case (.dismissed, .dismissed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// Whether or not a PullRequest can be merged.
public enum MergeableState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// The pull request can be merged.
  case mergeable
  /// The pull request cannot be merged due to merge conflicts.
  case conflicting
  /// The mergeability of the pull request is still being calculated.
  case unknown
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "MERGEABLE": self = .mergeable
      case "CONFLICTING": self = .conflicting
      case "UNKNOWN": self = .unknown
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .mergeable: return "MERGEABLE"
      case .conflicting: return "CONFLICTING"
      case .unknown: return "UNKNOWN"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: MergeableState, rhs: MergeableState) -> Bool {
    switch (lhs, rhs) {
      case (.mergeable, .mergeable): return true
      case (.conflicting, .conflicting): return true
      case (.unknown, .unknown): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// Detailed status information about a pull request merge.
public enum MergeStateStatus: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// The merge commit cannot be cleanly created.
  case dirty
  /// The state cannot currently be determined.
  case unknown
  /// The merge is blocked.
  case blocked
  /// The head ref is out of date.
  case behind
  /// Mergeable with non-passing commit status.
  case unstable
  /// Mergeable with passing commit status and pre-recieve hooks.
  case hasHooks
  /// Mergeable and passing commit status.
  case clean
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "DIRTY": self = .dirty
      case "UNKNOWN": self = .unknown
      case "BLOCKED": self = .blocked
      case "BEHIND": self = .behind
      case "UNSTABLE": self = .unstable
      case "HAS_HOOKS": self = .hasHooks
      case "CLEAN": self = .clean
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .dirty: return "DIRTY"
      case .unknown: return "UNKNOWN"
      case .blocked: return "BLOCKED"
      case .behind: return "BEHIND"
      case .unstable: return "UNSTABLE"
      case .hasHooks: return "HAS_HOOKS"
      case .clean: return "CLEAN"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: MergeStateStatus, rhs: MergeStateStatus) -> Bool {
    switch (lhs, rhs) {
      case (.dirty, .dirty): return true
      case (.unknown, .unknown): return true
      case (.blocked, .blocked): return true
      case (.behind, .behind): return true
      case (.unstable, .unstable): return true
      case (.hasHooks, .hasHooks): return true
      case (.clean, .clean): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class FetchRepositoryBranchesQuery: GraphQLQuery {
  public let operationDefinition =
    "query fetchRepositoryBranches($owner: String!, $name: String!, $after: String) {\n  repository(owner: $owner, name: $name) {\n    __typename\n    refs(first: 50, after: $after, refPrefix: \"refs/heads/\") {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          name\n        }\n      }\n      pageInfo {\n        __typename\n        hasNextPage\n        endCursor\n      }\n    }\n  }\n}"

  public var owner: String
  public var name: String
  public var after: String?

  public init(owner: String, name: String, after: String? = nil) {
    self.owner = owner
    self.name = name
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("refs", arguments: ["first": 50, "after": GraphQLVariable("after"), "refPrefix": "refs/heads/"], type: .object(Ref.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(refs: Ref? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "refs": refs.flatMap { (value: Ref) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Fetch a list of refs from the repository
      public var refs: Ref? {
        get {
          return (resultMap["refs"] as? ResultMap).flatMap { Ref(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "refs")
        }
      }

      public struct Ref: GraphQLSelectionSet {
        public static let possibleTypes = ["RefConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "RefConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["RefEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "RefEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Ref"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Ref", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The ref name.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("endCursor", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(hasNextPage: Bool, endCursor: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "endCursor": endCursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }
        }
      }
    }
  }
}

public final class IssueAutocompleteQuery: GraphQLQuery {
  public let operationDefinition =
    "query IssueAutocomplete($query: String!, $page_size: Int!) {\n  search(type: ISSUE, query: $query, first: $page_size) {\n    __typename\n    nodes {\n      __typename\n      ... on Issue {\n        number\n        title\n      }\n      ... on PullRequest {\n        number\n        title\n      }\n    }\n  }\n}"

  public var query: String
  public var page_size: Int

  public init(query: String, page_size: Int) {
    self.query = query
    self.page_size = page_size
  }

  public var variables: GraphQLMap? {
    return ["query": query, "page_size": page_size]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["type": "ISSUE", "query": GraphQLVariable("query"), "first": GraphQLVariable("page_size")], type: .nonNull(.object(Search.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.resultMap])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(unsafeResultMap: resultMap["search"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization", "MarketplaceListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeRepository() -> Node {
          return Node(unsafeResultMap: ["__typename": "Repository"])
        }

        public static func makeUser() -> Node {
          return Node(unsafeResultMap: ["__typename": "User"])
        }

        public static func makeOrganization() -> Node {
          return Node(unsafeResultMap: ["__typename": "Organization"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(unsafeResultMap: ["__typename": "MarketplaceListing"])
        }

        public static func makeIssue(number: Int, title: String) -> Node {
          return Node(unsafeResultMap: ["__typename": "Issue", "number": number, "title": title])
        }

        public static func makePullRequest(number: Int, title: String) -> Node {
          return Node(unsafeResultMap: ["__typename": "PullRequest", "number": number, "title": title])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asIssue: AsIssue? {
          get {
            if !AsIssue.possibleTypes.contains(__typename) { return nil }
            return AsIssue(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsIssue: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(number: Int, title: String) {
            self.init(unsafeResultMap: ["__typename": "Issue", "number": number, "title": title])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the issue number.
          public var number: Int {
            get {
              return resultMap["number"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the issue title.
          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }
        }

        public var asPullRequest: AsPullRequest? {
          get {
            if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
            return AsPullRequest(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsPullRequest: GraphQLSelectionSet {
          public static let possibleTypes = ["PullRequest"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(number: Int, title: String) {
            self.init(unsafeResultMap: ["__typename": "PullRequest", "number": number, "title": title])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the pull request number.
          public var number: Int {
            get {
              return resultMap["number"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the pull request title.
          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }
        }
      }
    }
  }
}

public final class RepoFileQuery: GraphQLQuery {
  public let operationDefinition =
    "query RepoFile($owner: String!, $name: String!, $branchAndPath: String!) {\n  repository(owner: $owner, name: $name) {\n    __typename\n    object(expression: $branchAndPath) {\n      __typename\n      ... on Blob {\n        text\n      }\n    }\n  }\n}"

  public var owner: String
  public var name: String
  public var branchAndPath: String

  public init(owner: String, name: String, branchAndPath: String) {
    self.owner = owner
    self.name = name
    self.branchAndPath = branchAndPath
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "branchAndPath": branchAndPath]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("object", arguments: ["expression": GraphQLVariable("branchAndPath")], type: .object(Object.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(object: Object? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "object": object.flatMap { (value: Object) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A Git object in the repository
      public var object: Object? {
        get {
          return (resultMap["object"] as? ResultMap).flatMap { Object(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "object")
        }
      }

      public struct Object: GraphQLSelectionSet {
        public static let possibleTypes = ["Commit", "Tree", "Blob", "Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Blob": AsBlob.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeCommit() -> Object {
          return Object(unsafeResultMap: ["__typename": "Commit"])
        }

        public static func makeTree() -> Object {
          return Object(unsafeResultMap: ["__typename": "Tree"])
        }

        public static func makeTag() -> Object {
          return Object(unsafeResultMap: ["__typename": "Tag"])
        }

        public static func makeBlob(text: String? = nil) -> Object {
          return Object(unsafeResultMap: ["__typename": "Blob", "text": text])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asBlob: AsBlob? {
          get {
            if !AsBlob.possibleTypes.contains(__typename) { return nil }
            return AsBlob(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsBlob: GraphQLSelectionSet {
          public static let possibleTypes = ["Blob"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("text", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(text: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Blob", "text": text])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// UTF8 text data or null if the Blob is binary
          public var text: String? {
            get {
              return resultMap["text"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "text")
            }
          }
        }
      }
    }
  }
}

public final class AddCommentMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation AddComment($subject_id: ID!, $body: String!) {\n  addComment(input: {subjectId: $subject_id, body: $body}) {\n    __typename\n    commentEdge {\n      __typename\n      node {\n        __typename\n        ...nodeFields\n        ...reactionFields\n        ...commentFields\n        ...updatableFields\n        ...deletableFields\n      }\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(NodeFields.fragmentDefinition).appending(ReactionFields.fragmentDefinition).appending(CommentFields.fragmentDefinition).appending(UpdatableFields.fragmentDefinition).appending(DeletableFields.fragmentDefinition) }

  public var subject_id: GraphQLID
  public var body: String

  public init(subject_id: GraphQLID, body: String) {
    self.subject_id = subject_id
    self.body = body
  }

  public var variables: GraphQLMap? {
    return ["subject_id": subject_id, "body": body]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addComment", arguments: ["input": ["subjectId": GraphQLVariable("subject_id"), "body": GraphQLVariable("body")]], type: .object(AddComment.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addComment: AddComment? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addComment": addComment.flatMap { (value: AddComment) -> ResultMap in value.resultMap }])
    }

    /// Adds a comment to an Issue or Pull Request.
    public var addComment: AddComment? {
      get {
        return (resultMap["addComment"] as? ResultMap).flatMap { AddComment(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addComment")
      }
    }

    public struct AddComment: GraphQLSelectionSet {
      public static let possibleTypes = ["AddCommentPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("commentEdge", type: .nonNull(.object(CommentEdge.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(commentEdge: CommentEdge) {
        self.init(unsafeResultMap: ["__typename": "AddCommentPayload", "commentEdge": commentEdge.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The edge from the subject's comment connection.
      public var commentEdge: CommentEdge {
        get {
          return CommentEdge(unsafeResultMap: resultMap["commentEdge"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "commentEdge")
        }
      }

      public struct CommentEdge: GraphQLSelectionSet {
        public static let possibleTypes = ["IssueCommentEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node? = nil) {
          self.init(unsafeResultMap: ["__typename": "IssueCommentEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["IssueComment"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(NodeFields.self),
            GraphQLFragmentSpread(ReactionFields.self),
            GraphQLFragmentSpread(CommentFields.self),
            GraphQLFragmentSpread(UpdatableFields.self),
            GraphQLFragmentSpread(DeletableFields.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var deletableFields: DeletableFields {
              get {
                return DeletableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class AddReactionMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation AddReaction($subject_id: ID!, $content: ReactionContent!) {\n  addReaction(input: {subjectId: $subject_id, content: $content}) {\n    __typename\n    subject {\n      __typename\n      ...reactionFields\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ReactionFields.fragmentDefinition) }

  public var subject_id: GraphQLID
  public var content: ReactionContent

  public init(subject_id: GraphQLID, content: ReactionContent) {
    self.subject_id = subject_id
    self.content = content
  }

  public var variables: GraphQLMap? {
    return ["subject_id": subject_id, "content": content]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addReaction", arguments: ["input": ["subjectId": GraphQLVariable("subject_id"), "content": GraphQLVariable("content")]], type: .object(AddReaction.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addReaction: AddReaction? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addReaction": addReaction.flatMap { (value: AddReaction) -> ResultMap in value.resultMap }])
    }

    /// Adds a reaction to a subject.
    public var addReaction: AddReaction? {
      get {
        return (resultMap["addReaction"] as? ResultMap).flatMap { AddReaction(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addReaction")
      }
    }

    public struct AddReaction: GraphQLSelectionSet {
      public static let possibleTypes = ["AddReactionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(subject: Subject) {
        self.init(unsafeResultMap: ["__typename": "AddReactionPayload", "subject": subject.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The reactable subject.
      public var subject: Subject {
        get {
          return Subject(unsafeResultMap: resultMap["subject"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "subject")
        }
      }

      public struct Subject: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ReactionFields.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var reactionFields: ReactionFields {
            get {
              return ReactionFields(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class RepositoryLabelsQuery: GraphQLQuery {
  public let operationDefinition =
    "query RepositoryLabels($owner: String!, $repo: String!) {\n  repository(owner: $owner, name: $repo) {\n    __typename\n    labels(first: 100) {\n      __typename\n      nodes {\n        __typename\n        name\n        color\n      }\n    }\n  }\n}"

  public var owner: String
  public var repo: String

  public init(owner: String, repo: String) {
    self.owner = owner
    self.repo = repo
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "repo": repo]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("repo")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("labels", arguments: ["first": 100], type: .object(Label.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(labels: Label? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "labels": labels.flatMap { (value: Label) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of labels associated with the repository.
      public var labels: Label? {
        get {
          return (resultMap["labels"] as? ResultMap).flatMap { Label(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "labels")
        }
      }

      public struct Label: GraphQLSelectionSet {
        public static let possibleTypes = ["LabelConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Label"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("color", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String, color: String) {
            self.init(unsafeResultMap: ["__typename": "Label", "name": name, "color": color])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the label name.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// Identifies the label color.
          public var color: String {
            get {
              return resultMap["color"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "color")
            }
          }
        }
      }
    }
  }
}

public final class RepoFileHistoryQuery: GraphQLQuery {
  public let operationDefinition =
    "query RepoFileHistory($owner: String!, $name: String!, $branch: String!, $path: String, $after: String, $page_size: Int!) {\n  repository(owner: $owner, name: $name) {\n    __typename\n    object(expression: $branch) {\n      __typename\n      ... on Commit {\n        history(after: $after, path: $path, first: $page_size) {\n          __typename\n          nodes {\n            __typename\n            message\n            oid\n            committedDate\n            url\n            author {\n              __typename\n              user {\n                __typename\n                login\n              }\n            }\n            committer {\n              __typename\n              user {\n                __typename\n                login\n              }\n            }\n          }\n          pageInfo {\n            __typename\n            hasNextPage\n            endCursor\n          }\n        }\n      }\n    }\n  }\n}"

  public var owner: String
  public var name: String
  public var branch: String
  public var path: String?
  public var after: String?
  public var page_size: Int

  public init(owner: String, name: String, branch: String, path: String? = nil, after: String? = nil, page_size: Int) {
    self.owner = owner
    self.name = name
    self.branch = branch
    self.path = path
    self.after = after
    self.page_size = page_size
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "branch": branch, "path": path, "after": after, "page_size": page_size]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("object", arguments: ["expression": GraphQLVariable("branch")], type: .object(Object.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(object: Object? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "object": object.flatMap { (value: Object) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A Git object in the repository
      public var object: Object? {
        get {
          return (resultMap["object"] as? ResultMap).flatMap { Object(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "object")
        }
      }

      public struct Object: GraphQLSelectionSet {
        public static let possibleTypes = ["Commit", "Tree", "Blob", "Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Commit": AsCommit.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeTree() -> Object {
          return Object(unsafeResultMap: ["__typename": "Tree"])
        }

        public static func makeBlob() -> Object {
          return Object(unsafeResultMap: ["__typename": "Blob"])
        }

        public static func makeTag() -> Object {
          return Object(unsafeResultMap: ["__typename": "Tag"])
        }

        public static func makeCommit(history: AsCommit.History) -> Object {
          return Object(unsafeResultMap: ["__typename": "Commit", "history": history.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asCommit: AsCommit? {
          get {
            if !AsCommit.possibleTypes.contains(__typename) { return nil }
            return AsCommit(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsCommit: GraphQLSelectionSet {
          public static let possibleTypes = ["Commit"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("history", arguments: ["after": GraphQLVariable("after"), "path": GraphQLVariable("path"), "first": GraphQLVariable("page_size")], type: .nonNull(.object(History.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(history: History) {
            self.init(unsafeResultMap: ["__typename": "Commit", "history": history.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The linear commit history starting from (and including) this commit, in the same order as `git log`.
          public var history: History {
            get {
              return History(unsafeResultMap: resultMap["history"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "history")
            }
          }

          public struct History: GraphQLSelectionSet {
            public static let possibleTypes = ["CommitHistoryConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
              self.init(unsafeResultMap: ["__typename": "CommitHistoryConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            /// Information to aid in pagination.
            public var pageInfo: PageInfo {
              get {
                return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Commit"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("message", type: .nonNull(.scalar(String.self))),
                GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                GraphQLField("committedDate", type: .nonNull(.scalar(String.self))),
                GraphQLField("url", type: .nonNull(.scalar(String.self))),
                GraphQLField("author", type: .object(Author.selections)),
                GraphQLField("committer", type: .object(Committer.selections)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(message: String, oid: String, committedDate: String, url: String, author: Author? = nil, committer: Committer? = nil) {
                self.init(unsafeResultMap: ["__typename": "Commit", "message": message, "oid": oid, "committedDate": committedDate, "url": url, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "committer": committer.flatMap { (value: Committer) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The Git commit message
              public var message: String {
                get {
                  return resultMap["message"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "message")
                }
              }

              /// The Git object ID
              public var oid: String {
                get {
                  return resultMap["oid"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "oid")
                }
              }

              /// The datetime when this commit was committed.
              public var committedDate: String {
                get {
                  return resultMap["committedDate"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "committedDate")
                }
              }

              /// The HTTP URL for this commit
              public var url: String {
                get {
                  return resultMap["url"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "url")
                }
              }

              /// Authorship details of the commit.
              public var author: Author? {
                get {
                  return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "author")
                }
              }

              /// Committership details of the commit.
              public var committer: Committer? {
                get {
                  return (resultMap["committer"] as? ResultMap).flatMap { Committer(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "committer")
                }
              }

              public struct Author: GraphQLSelectionSet {
                public static let possibleTypes = ["GitActor"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(user: User? = nil) {
                  self.init(unsafeResultMap: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The GitHub user corresponding to the email field. Null if no such user exists.
                public var user: User? {
                  get {
                    return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "user")
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(login: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public struct Committer: GraphQLSelectionSet {
                public static let possibleTypes = ["GitActor"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(user: User? = nil) {
                  self.init(unsafeResultMap: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The GitHub user corresponding to the email field. Null if no such user exists.
                public var user: User? {
                  get {
                    return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "user")
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(login: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }
            }

            public struct PageInfo: GraphQLSelectionSet {
              public static let possibleTypes = ["PageInfo"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("endCursor", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(hasNextPage: Bool, endCursor: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "endCursor": endCursor])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// When paginating forwards, are there more items?
              public var hasNextPage: Bool {
                get {
                  return resultMap["hasNextPage"]! as! Bool
                }
                set {
                  resultMap.updateValue(newValue, forKey: "hasNextPage")
                }
              }

              /// When paginating forwards, the cursor to continue.
              public var endCursor: String? {
                get {
                  return resultMap["endCursor"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "endCursor")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class RepositoryInfoQuery: GraphQLQuery {
  public let operationDefinition =
    "query RepositoryInfo($owner: String!, $name: String!) {\n  repository(owner: $owner, name: $name) {\n    __typename\n    id\n    defaultBranchRef {\n      __typename\n      name\n    }\n    hasIssuesEnabled\n  }\n}"

  public var owner: String
  public var name: String

  public init(owner: String, name: String) {
    self.owner = owner
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("defaultBranchRef", type: .object(DefaultBranchRef.selections)),
        GraphQLField("hasIssuesEnabled", type: .nonNull(.scalar(Bool.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, defaultBranchRef: DefaultBranchRef? = nil, hasIssuesEnabled: Bool) {
        self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "defaultBranchRef": defaultBranchRef.flatMap { (value: DefaultBranchRef) -> ResultMap in value.resultMap }, "hasIssuesEnabled": hasIssuesEnabled])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The Ref associated with the repository's default branch.
      public var defaultBranchRef: DefaultBranchRef? {
        get {
          return (resultMap["defaultBranchRef"] as? ResultMap).flatMap { DefaultBranchRef(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "defaultBranchRef")
        }
      }

      /// Indicates if the repository has issues feature enabled.
      public var hasIssuesEnabled: Bool {
        get {
          return resultMap["hasIssuesEnabled"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasIssuesEnabled")
        }
      }

      public struct DefaultBranchRef: GraphQLSelectionSet {
        public static let possibleTypes = ["Ref"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "Ref", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The ref name.
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class SearchReposQuery: GraphQLQuery {
  public let operationDefinition =
    "query SearchRepos($search: String!, $before: String) {\n  search(first: 100, query: $search, type: REPOSITORY, before: $before) {\n    __typename\n    nodes {\n      __typename\n      ... on Repository {\n        id\n        name\n        hasIssuesEnabled\n        owner {\n          __typename\n          login\n        }\n        description\n        pushedAt\n        primaryLanguage {\n          __typename\n          name\n          color\n        }\n        stargazers {\n          __typename\n          totalCount\n        }\n        defaultBranchRef {\n          __typename\n          name\n        }\n      }\n    }\n    pageInfo {\n      __typename\n      endCursor\n      hasNextPage\n    }\n    repositoryCount\n  }\n}"

  public var search: String
  public var before: String?

  public init(search: String, before: String? = nil) {
    self.search = search
    self.before = before
  }

  public var variables: GraphQLMap? {
    return ["search": search, "before": before]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["first": 100, "query": GraphQLVariable("search"), "type": "REPOSITORY", "before": GraphQLVariable("before")], type: .nonNull(.object(Search.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.resultMap])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(unsafeResultMap: resultMap["search"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
        GraphQLField("repositoryCount", type: .nonNull(.scalar(Int.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil, pageInfo: PageInfo, repositoryCount: Int) {
        self.init(unsafeResultMap: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap, "repositoryCount": repositoryCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
        }
      }

      /// The number of repositories that matched the search query.
      public var repositoryCount: Int {
        get {
          return resultMap["repositoryCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "repositoryCount")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization", "MarketplaceListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Repository": AsRepository.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeIssue() -> Node {
          return Node(unsafeResultMap: ["__typename": "Issue"])
        }

        public static func makePullRequest() -> Node {
          return Node(unsafeResultMap: ["__typename": "PullRequest"])
        }

        public static func makeUser() -> Node {
          return Node(unsafeResultMap: ["__typename": "User"])
        }

        public static func makeOrganization() -> Node {
          return Node(unsafeResultMap: ["__typename": "Organization"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(unsafeResultMap: ["__typename": "MarketplaceListing"])
        }

        public static func makeRepository(id: GraphQLID, name: String, hasIssuesEnabled: Bool, owner: AsRepository.Owner, description: String? = nil, pushedAt: String? = nil, primaryLanguage: AsRepository.PrimaryLanguage? = nil, stargazers: AsRepository.Stargazer, defaultBranchRef: AsRepository.DefaultBranchRef? = nil) -> Node {
          return Node(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "hasIssuesEnabled": hasIssuesEnabled, "owner": owner.resultMap, "description": description, "pushedAt": pushedAt, "primaryLanguage": primaryLanguage.flatMap { (value: AsRepository.PrimaryLanguage) -> ResultMap in value.resultMap }, "stargazers": stargazers.resultMap, "defaultBranchRef": defaultBranchRef.flatMap { (value: AsRepository.DefaultBranchRef) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asRepository: AsRepository? {
          get {
            if !AsRepository.possibleTypes.contains(__typename) { return nil }
            return AsRepository(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsRepository: GraphQLSelectionSet {
          public static let possibleTypes = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasIssuesEnabled", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("pushedAt", type: .scalar(String.self)),
            GraphQLField("primaryLanguage", type: .object(PrimaryLanguage.selections)),
            GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
            GraphQLField("defaultBranchRef", type: .object(DefaultBranchRef.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, hasIssuesEnabled: Bool, owner: Owner, description: String? = nil, pushedAt: String? = nil, primaryLanguage: PrimaryLanguage? = nil, stargazers: Stargazer, defaultBranchRef: DefaultBranchRef? = nil) {
            self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "hasIssuesEnabled": hasIssuesEnabled, "owner": owner.resultMap, "description": description, "pushedAt": pushedAt, "primaryLanguage": primaryLanguage.flatMap { (value: PrimaryLanguage) -> ResultMap in value.resultMap }, "stargazers": stargazers.resultMap, "defaultBranchRef": defaultBranchRef.flatMap { (value: DefaultBranchRef) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// Indicates if the repository has issues feature enabled.
          public var hasIssuesEnabled: Bool {
            get {
              return resultMap["hasIssuesEnabled"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasIssuesEnabled")
            }
          }

          /// The User owner of the repository.
          public var owner: Owner {
            get {
              return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "owner")
            }
          }

          /// The description of the repository.
          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          /// Identifies when the repository was last pushed to.
          public var pushedAt: String? {
            get {
              return resultMap["pushedAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "pushedAt")
            }
          }

          /// The primary language of the repository's code.
          public var primaryLanguage: PrimaryLanguage? {
            get {
              return (resultMap["primaryLanguage"] as? ResultMap).flatMap { PrimaryLanguage(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "primaryLanguage")
            }
          }

          /// A list of users who have starred this starrable.
          public var stargazers: Stargazer {
            get {
              return Stargazer(unsafeResultMap: resultMap["stargazers"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "stargazers")
            }
          }

          /// The Ref associated with the repository's default branch.
          public var defaultBranchRef: DefaultBranchRef? {
            get {
              return (resultMap["defaultBranchRef"] as? ResultMap).flatMap { DefaultBranchRef(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "defaultBranchRef")
            }
          }

          public struct Owner: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeOrganization(login: String) -> Owner {
              return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Owner {
              return Owner(unsafeResultMap: ["__typename": "User", "login": login])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                return resultMap["login"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "login")
              }
            }
          }

          public struct PrimaryLanguage: GraphQLSelectionSet {
            public static let possibleTypes = ["Language"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("color", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String, color: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Language", "name": name, "color": color])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the current language.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// The color defined for the current language.
            public var color: String? {
              get {
                return resultMap["color"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "color")
              }
            }
          }

          public struct Stargazer: GraphQLSelectionSet {
            public static let possibleTypes = ["StargazerConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalCount: Int) {
              self.init(unsafeResultMap: ["__typename": "StargazerConnection", "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return resultMap["totalCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalCount")
              }
            }
          }

          public struct DefaultBranchRef: GraphQLSelectionSet {
            public static let possibleTypes = ["Ref"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Ref", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The ref name.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }

      public struct PageInfo: GraphQLSelectionSet {
        public static let possibleTypes = ["PageInfo"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("endCursor", type: .scalar(String.self)),
          GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(endCursor: String? = nil, hasNextPage: Bool) {
          self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? {
          get {
            return resultMap["endCursor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "endCursor")
          }
        }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool {
          get {
            return resultMap["hasNextPage"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasNextPage")
          }
        }
      }
    }
  }
}

public final class BookmarkNodesQuery: GraphQLQuery {
  public let operationDefinition =
    "query BookmarkNodes($ids: [ID!]!) {\n  nodes(ids: $ids) {\n    __typename\n    ... on Issue {\n      title\n      number\n      issueState: state\n      repository {\n        __typename\n        owner {\n          __typename\n          login\n        }\n        name\n      }\n    }\n    ... on PullRequest {\n      title\n      number\n      pullRequestState: state\n      repository {\n        __typename\n        owner {\n          __typename\n          login\n        }\n        name\n      }\n    }\n    ... on Repository {\n      owner {\n        __typename\n        login\n      }\n      name\n    }\n  }\n}"

  public var ids: [GraphQLID]

  public init(ids: [GraphQLID]) {
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("nodes", arguments: ["ids": GraphQLVariable("ids")], type: .nonNull(.list(.object(Node.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(nodes: [Node?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "nodes": nodes.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } }])
    }

    /// Lookup nodes by a list of IDs.
    public var nodes: [Node?] {
      get {
        return (resultMap["nodes"] as! [ResultMap?]).map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } }, forKey: "nodes")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes = ["License", "MarketplaceCategory", "MarketplaceListing", "Organization", "Project", "ProjectColumn", "ProjectCard", "Issue", "User", "Repository", "CommitComment", "UserContentEdit", "Reaction", "Commit", "Status", "StatusContext", "Tree", "Ref", "PullRequest", "Label", "IssueComment", "PullRequestCommit", "Milestone", "ReviewRequest", "Team", "OrganizationInvitation", "PullRequestReview", "PullRequestReviewComment", "CommitCommentThread", "PullRequestReviewThread", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "MergedEvent", "ReferencedEvent", "CrossReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent", "DeployedEvent", "Deployment", "DeploymentStatus", "HeadRefDeletedEvent", "HeadRefRestoredEvent", "HeadRefForcePushedEvent", "BaseRefForcePushedEvent", "ReviewRequestedEvent", "ReviewRequestRemovedEvent", "ReviewDismissedEvent", "DeployKey", "Language", "ProtectedBranch", "PushAllowance", "ReviewDismissalAllowance", "Release", "ReleaseAsset", "RepositoryTopic", "Topic", "Gist", "GistComment", "PublicKey", "OrganizationIdentityProvider", "ExternalIdentity", "Bot", "RepositoryInvitation", "Blob", "BaseRefChangedEvent", "AddedToProjectEvent", "CommentDeletedEvent", "ConvertedNoteToIssueEvent", "MentionedEvent", "MovedColumnsInProjectEvent", "RemovedFromProjectEvent", "Tag"]

      public static let selections: [GraphQLSelection] = [
        GraphQLTypeCase(
          variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections, "Repository": AsRepository.selections],
          default: [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          ]
        )
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makeLicense() -> Node {
        return Node(unsafeResultMap: ["__typename": "License"])
      }

      public static func makeMarketplaceCategory() -> Node {
        return Node(unsafeResultMap: ["__typename": "MarketplaceCategory"])
      }

      public static func makeMarketplaceListing() -> Node {
        return Node(unsafeResultMap: ["__typename": "MarketplaceListing"])
      }

      public static func makeOrganization() -> Node {
        return Node(unsafeResultMap: ["__typename": "Organization"])
      }

      public static func makeProject() -> Node {
        return Node(unsafeResultMap: ["__typename": "Project"])
      }

      public static func makeProjectColumn() -> Node {
        return Node(unsafeResultMap: ["__typename": "ProjectColumn"])
      }

      public static func makeProjectCard() -> Node {
        return Node(unsafeResultMap: ["__typename": "ProjectCard"])
      }

      public static func makeUser() -> Node {
        return Node(unsafeResultMap: ["__typename": "User"])
      }

      public static func makeCommitComment() -> Node {
        return Node(unsafeResultMap: ["__typename": "CommitComment"])
      }

      public static func makeUserContentEdit() -> Node {
        return Node(unsafeResultMap: ["__typename": "UserContentEdit"])
      }

      public static func makeReaction() -> Node {
        return Node(unsafeResultMap: ["__typename": "Reaction"])
      }

      public static func makeCommit() -> Node {
        return Node(unsafeResultMap: ["__typename": "Commit"])
      }

      public static func makeStatus() -> Node {
        return Node(unsafeResultMap: ["__typename": "Status"])
      }

      public static func makeStatusContext() -> Node {
        return Node(unsafeResultMap: ["__typename": "StatusContext"])
      }

      public static func makeTree() -> Node {
        return Node(unsafeResultMap: ["__typename": "Tree"])
      }

      public static func makeRef() -> Node {
        return Node(unsafeResultMap: ["__typename": "Ref"])
      }

      public static func makeLabel() -> Node {
        return Node(unsafeResultMap: ["__typename": "Label"])
      }

      public static func makeIssueComment() -> Node {
        return Node(unsafeResultMap: ["__typename": "IssueComment"])
      }

      public static func makePullRequestCommit() -> Node {
        return Node(unsafeResultMap: ["__typename": "PullRequestCommit"])
      }

      public static func makeMilestone() -> Node {
        return Node(unsafeResultMap: ["__typename": "Milestone"])
      }

      public static func makeReviewRequest() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReviewRequest"])
      }

      public static func makeTeam() -> Node {
        return Node(unsafeResultMap: ["__typename": "Team"])
      }

      public static func makeOrganizationInvitation() -> Node {
        return Node(unsafeResultMap: ["__typename": "OrganizationInvitation"])
      }

      public static func makePullRequestReview() -> Node {
        return Node(unsafeResultMap: ["__typename": "PullRequestReview"])
      }

      public static func makePullRequestReviewComment() -> Node {
        return Node(unsafeResultMap: ["__typename": "PullRequestReviewComment"])
      }

      public static func makeCommitCommentThread() -> Node {
        return Node(unsafeResultMap: ["__typename": "CommitCommentThread"])
      }

      public static func makePullRequestReviewThread() -> Node {
        return Node(unsafeResultMap: ["__typename": "PullRequestReviewThread"])
      }

      public static func makeClosedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "ClosedEvent"])
      }

      public static func makeReopenedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReopenedEvent"])
      }

      public static func makeSubscribedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "SubscribedEvent"])
      }

      public static func makeUnsubscribedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "UnsubscribedEvent"])
      }

      public static func makeMergedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "MergedEvent"])
      }

      public static func makeReferencedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReferencedEvent"])
      }

      public static func makeCrossReferencedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "CrossReferencedEvent"])
      }

      public static func makeAssignedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "AssignedEvent"])
      }

      public static func makeUnassignedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "UnassignedEvent"])
      }

      public static func makeLabeledEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "LabeledEvent"])
      }

      public static func makeUnlabeledEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "UnlabeledEvent"])
      }

      public static func makeMilestonedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "MilestonedEvent"])
      }

      public static func makeDemilestonedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "DemilestonedEvent"])
      }

      public static func makeRenamedTitleEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "RenamedTitleEvent"])
      }

      public static func makeLockedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "LockedEvent"])
      }

      public static func makeUnlockedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "UnlockedEvent"])
      }

      public static func makeDeployedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "DeployedEvent"])
      }

      public static func makeDeployment() -> Node {
        return Node(unsafeResultMap: ["__typename": "Deployment"])
      }

      public static func makeDeploymentStatus() -> Node {
        return Node(unsafeResultMap: ["__typename": "DeploymentStatus"])
      }

      public static func makeHeadRefDeletedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "HeadRefDeletedEvent"])
      }

      public static func makeHeadRefRestoredEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "HeadRefRestoredEvent"])
      }

      public static func makeHeadRefForcePushedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "HeadRefForcePushedEvent"])
      }

      public static func makeBaseRefForcePushedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "BaseRefForcePushedEvent"])
      }

      public static func makeReviewRequestedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReviewRequestedEvent"])
      }

      public static func makeReviewRequestRemovedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReviewRequestRemovedEvent"])
      }

      public static func makeReviewDismissedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReviewDismissedEvent"])
      }

      public static func makeDeployKey() -> Node {
        return Node(unsafeResultMap: ["__typename": "DeployKey"])
      }

      public static func makeLanguage() -> Node {
        return Node(unsafeResultMap: ["__typename": "Language"])
      }

      public static func makeProtectedBranch() -> Node {
        return Node(unsafeResultMap: ["__typename": "ProtectedBranch"])
      }

      public static func makePushAllowance() -> Node {
        return Node(unsafeResultMap: ["__typename": "PushAllowance"])
      }

      public static func makeReviewDismissalAllowance() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReviewDismissalAllowance"])
      }

      public static func makeRelease() -> Node {
        return Node(unsafeResultMap: ["__typename": "Release"])
      }

      public static func makeReleaseAsset() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReleaseAsset"])
      }

      public static func makeRepositoryTopic() -> Node {
        return Node(unsafeResultMap: ["__typename": "RepositoryTopic"])
      }

      public static func makeTopic() -> Node {
        return Node(unsafeResultMap: ["__typename": "Topic"])
      }

      public static func makeGist() -> Node {
        return Node(unsafeResultMap: ["__typename": "Gist"])
      }

      public static func makeGistComment() -> Node {
        return Node(unsafeResultMap: ["__typename": "GistComment"])
      }

      public static func makePublicKey() -> Node {
        return Node(unsafeResultMap: ["__typename": "PublicKey"])
      }

      public static func makeOrganizationIdentityProvider() -> Node {
        return Node(unsafeResultMap: ["__typename": "OrganizationIdentityProvider"])
      }

      public static func makeExternalIdentity() -> Node {
        return Node(unsafeResultMap: ["__typename": "ExternalIdentity"])
      }

      public static func makeBot() -> Node {
        return Node(unsafeResultMap: ["__typename": "Bot"])
      }

      public static func makeRepositoryInvitation() -> Node {
        return Node(unsafeResultMap: ["__typename": "RepositoryInvitation"])
      }

      public static func makeBlob() -> Node {
        return Node(unsafeResultMap: ["__typename": "Blob"])
      }

      public static func makeBaseRefChangedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "BaseRefChangedEvent"])
      }

      public static func makeAddedToProjectEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "AddedToProjectEvent"])
      }

      public static func makeCommentDeletedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "CommentDeletedEvent"])
      }

      public static func makeConvertedNoteToIssueEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "ConvertedNoteToIssueEvent"])
      }

      public static func makeMentionedEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "MentionedEvent"])
      }

      public static func makeMovedColumnsInProjectEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "MovedColumnsInProjectEvent"])
      }

      public static func makeRemovedFromProjectEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "RemovedFromProjectEvent"])
      }

      public static func makeTag() -> Node {
        return Node(unsafeResultMap: ["__typename": "Tag"])
      }

      public static func makeIssue(title: String, number: Int, issueState: IssueState, repository: AsIssue.Repository) -> Node {
        return Node(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "issueState": issueState, "repository": repository.resultMap])
      }

      public static func makePullRequest(title: String, number: Int, pullRequestState: PullRequestState, repository: AsPullRequest.Repository) -> Node {
        return Node(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "pullRequestState": pullRequestState, "repository": repository.resultMap])
      }

      public static func makeRepository(owner: AsRepository.Owner, name: String) -> Node {
        return Node(unsafeResultMap: ["__typename": "Repository", "owner": owner.resultMap, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var asIssue: AsIssue? {
        get {
          if !AsIssue.possibleTypes.contains(__typename) { return nil }
          return AsIssue(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsIssue: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("number", type: .nonNull(.scalar(Int.self))),
          GraphQLField("state", alias: "issueState", type: .nonNull(.scalar(IssueState.self))),
          GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String, number: Int, issueState: IssueState, repository: Repository) {
          self.init(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "issueState": issueState, "repository": repository.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the issue title.
        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        /// Identifies the issue number.
        public var number: Int {
          get {
            return resultMap["number"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "number")
          }
        }

        /// Identifies the state of the issue.
        public var issueState: IssueState {
          get {
            return resultMap["issueState"]! as! IssueState
          }
          set {
            resultMap.updateValue(newValue, forKey: "issueState")
          }
        }

        /// The repository associated with this node.
        public var repository: Repository {
          get {
            return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "repository")
          }
        }

        public struct Repository: GraphQLSelectionSet {
          public static let possibleTypes = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(owner: Owner, name: String) {
            self.init(unsafeResultMap: ["__typename": "Repository", "owner": owner.resultMap, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The User owner of the repository.
          public var owner: Owner {
            get {
              return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "owner")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public struct Owner: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeOrganization(login: String) -> Owner {
              return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Owner {
              return Owner(unsafeResultMap: ["__typename": "User", "login": login])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                return resultMap["login"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "login")
              }
            }
          }
        }
      }

      public var asPullRequest: AsPullRequest? {
        get {
          if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
          return AsPullRequest(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsPullRequest: GraphQLSelectionSet {
        public static let possibleTypes = ["PullRequest"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("number", type: .nonNull(.scalar(Int.self))),
          GraphQLField("state", alias: "pullRequestState", type: .nonNull(.scalar(PullRequestState.self))),
          GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String, number: Int, pullRequestState: PullRequestState, repository: Repository) {
          self.init(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "pullRequestState": pullRequestState, "repository": repository.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the pull request title.
        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        /// Identifies the pull request number.
        public var number: Int {
          get {
            return resultMap["number"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "number")
          }
        }

        /// Identifies the state of the pull request.
        public var pullRequestState: PullRequestState {
          get {
            return resultMap["pullRequestState"]! as! PullRequestState
          }
          set {
            resultMap.updateValue(newValue, forKey: "pullRequestState")
          }
        }

        /// The repository associated with this node.
        public var repository: Repository {
          get {
            return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "repository")
          }
        }

        public struct Repository: GraphQLSelectionSet {
          public static let possibleTypes = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(owner: Owner, name: String) {
            self.init(unsafeResultMap: ["__typename": "Repository", "owner": owner.resultMap, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The User owner of the repository.
          public var owner: Owner {
            get {
              return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "owner")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public struct Owner: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeOrganization(login: String) -> Owner {
              return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Owner {
              return Owner(unsafeResultMap: ["__typename": "User", "login": login])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                return resultMap["login"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "login")
              }
            }
          }
        }
      }

      public var asRepository: AsRepository? {
        get {
          if !AsRepository.possibleTypes.contains(__typename) { return nil }
          return AsRepository(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsRepository: GraphQLSelectionSet {
        public static let possibleTypes = ["Repository"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(owner: Owner, name: String) {
          self.init(unsafeResultMap: ["__typename": "Repository", "owner": owner.resultMap, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The User owner of the repository.
        public var owner: Owner {
          get {
            return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "owner")
          }
        }

        /// The name of the repository.
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public struct Owner: GraphQLSelectionSet {
          public static let possibleTypes = ["Organization", "User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("login", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public static func makeOrganization(login: String) -> Owner {
            return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
          }

          public static func makeUser(login: String) -> Owner {
            return Owner(unsafeResultMap: ["__typename": "User", "login": login])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The username used to login.
          public var login: String {
            get {
              return resultMap["login"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "login")
            }
          }
        }
      }
    }
  }
}

public final class RemoveReactionMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation RemoveReaction($subject_id: ID!, $content: ReactionContent!) {\n  removeReaction(input: {subjectId: $subject_id, content: $content}) {\n    __typename\n    subject {\n      __typename\n      ...reactionFields\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ReactionFields.fragmentDefinition) }

  public var subject_id: GraphQLID
  public var content: ReactionContent

  public init(subject_id: GraphQLID, content: ReactionContent) {
    self.subject_id = subject_id
    self.content = content
  }

  public var variables: GraphQLMap? {
    return ["subject_id": subject_id, "content": content]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("removeReaction", arguments: ["input": ["subjectId": GraphQLVariable("subject_id"), "content": GraphQLVariable("content")]], type: .object(RemoveReaction.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(removeReaction: RemoveReaction? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "removeReaction": removeReaction.flatMap { (value: RemoveReaction) -> ResultMap in value.resultMap }])
    }

    /// Removes a reaction from a subject.
    public var removeReaction: RemoveReaction? {
      get {
        return (resultMap["removeReaction"] as? ResultMap).flatMap { RemoveReaction(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "removeReaction")
      }
    }

    public struct RemoveReaction: GraphQLSelectionSet {
      public static let possibleTypes = ["RemoveReactionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(subject: Subject) {
        self.init(unsafeResultMap: ["__typename": "RemoveReactionPayload", "subject": subject.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The reactable subject.
      public var subject: Subject {
        get {
          return Subject(unsafeResultMap: resultMap["subject"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "subject")
        }
      }

      public struct Subject: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ReactionFields.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var reactionFields: ReactionFields {
            get {
              return ReactionFields(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class IssueOrPullRequestQuery: GraphQLQuery {
  public let operationDefinition =
    "query IssueOrPullRequest($owner: String!, $repo: String!, $number: Int!, $page_size: Int!, $before: String) {\n  repository(owner: $owner, name: $repo) {\n    __typename\n    name\n    hasIssuesEnabled\n    viewerCanAdminister\n    mergeCommitAllowed\n    rebaseMergeAllowed\n    squashMergeAllowed\n    mentionableUsers(first: 50) {\n      __typename\n      nodes {\n        __typename\n        avatarUrl\n        login\n      }\n    }\n    defaultBranchRef {\n      __typename\n      name\n    }\n    issueOrPullRequest(number: $number) {\n      __typename\n      ... on Issue {\n        timeline(last: $page_size, before: $before) {\n          __typename\n          pageInfo {\n            __typename\n            ...headPaging\n          }\n          nodes {\n            __typename\n            ... on Commit {\n              ...nodeFields\n              author {\n                __typename\n                user {\n                  __typename\n                  login\n                  avatarUrl\n                }\n              }\n              oid\n              messageHeadline\n            }\n            ... on IssueComment {\n              ...nodeFields\n              ...reactionFields\n              ...commentFields\n              ...updatableFields\n              ...deletableFields\n            }\n            ... on LabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on UnlabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on ClosedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              closer {\n                __typename\n                ... on Commit {\n                  oid\n                }\n                ... on PullRequest {\n                  mergeCommit {\n                    __typename\n                    oid\n                  }\n                }\n              }\n            }\n            ... on ReopenedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              currentTitle\n            }\n            ... on LockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on UnlockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on CrossReferencedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              source {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n              }\n            }\n            ... on ReferencedEvent {\n              createdAt\n              ...nodeFields\n              refCommit: commit {\n                __typename\n                oid\n              }\n              actor {\n                __typename\n                login\n              }\n              commitRepository {\n                __typename\n                ...referencedRepositoryFields\n              }\n              subject {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                }\n              }\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              createdAt\n              currentTitle\n              previousTitle\n              actor {\n                __typename\n                login\n              }\n            }\n            ... on AssignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on UnassignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on MilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n            ... on DemilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n          }\n        }\n        milestone {\n          __typename\n          ...milestoneFields\n        }\n        ...reactionFields\n        ...commentFields\n        ...lockableFields\n        ...closableFields\n        ...labelableFields\n        ...updatableFields\n        ...nodeFields\n        ...assigneeFields\n        number\n        title\n      }\n      ... on PullRequest {\n        timeline(last: $page_size, before: $before) {\n          __typename\n          pageInfo {\n            __typename\n            ...headPaging\n          }\n          nodes {\n            __typename\n            ... on Commit {\n              ...nodeFields\n              author {\n                __typename\n                user {\n                  __typename\n                  login\n                  avatarUrl\n                }\n              }\n              oid\n              messageHeadline\n            }\n            ... on IssueComment {\n              ...nodeFields\n              ...reactionFields\n              ...commentFields\n              ...updatableFields\n              ...deletableFields\n            }\n            ... on LabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on UnlabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on ClosedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              closer {\n                __typename\n                ... on Commit {\n                  oid\n                }\n                ... on PullRequest {\n                  mergeCommit {\n                    __typename\n                    oid\n                  }\n                }\n              }\n            }\n            ... on ReopenedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              currentTitle\n            }\n            ... on LockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on UnlockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on MergedEvent {\n              ...nodeFields\n              mergedCommit: commit {\n                __typename\n                oid\n              }\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on PullRequestReviewThread {\n              comments(first: $page_size) {\n                __typename\n                nodes {\n                  __typename\n                  ...reactionFields\n                  ...nodeFields\n                  ...commentFields\n                  path\n                  diffHunk\n                }\n              }\n            }\n            ... on PullRequestReview {\n              ...nodeFields\n              ...commentFields\n              state\n              submittedAt\n              author {\n                __typename\n                login\n              }\n              comments {\n                __typename\n                totalCount\n              }\n            }\n            ... on CrossReferencedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              source {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n              }\n            }\n            ... on ReferencedEvent {\n              createdAt\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              commitRepository {\n                __typename\n                ...referencedRepositoryFields\n              }\n              subject {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                }\n              }\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              createdAt\n              currentTitle\n              previousTitle\n              actor {\n                __typename\n                login\n              }\n            }\n            ... on AssignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on UnassignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on ReviewRequestedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              requestedReviewer {\n                __typename\n                ... on Actor {\n                  login\n                }\n              }\n            }\n            ... on ReviewRequestRemovedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              requestedReviewer {\n                __typename\n                ... on Actor {\n                  login\n                }\n              }\n            }\n            ... on MilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n            ... on DemilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n          }\n        }\n        reviewRequests(first: $page_size) {\n          __typename\n          nodes {\n            __typename\n            requestedReviewer {\n              __typename\n              ... on Actor {\n                login\n                avatarUrl\n              }\n            }\n          }\n        }\n        commits(last: 1) {\n          __typename\n          nodes {\n            __typename\n            commit {\n              __typename\n              ...commitContext\n            }\n          }\n        }\n        milestone {\n          __typename\n          ...milestoneFields\n        }\n        ...reactionFields\n        ...commentFields\n        ...lockableFields\n        ...closableFields\n        ...labelableFields\n        ...updatableFields\n        ...nodeFields\n        ...assigneeFields\n        number\n        title\n        merged\n        baseRefName\n        changedFiles\n        additions\n        deletions\n        mergeable\n        mergeStateStatus\n      }\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(HeadPaging.fragmentDefinition).appending(NodeFields.fragmentDefinition).appending(ReactionFields.fragmentDefinition).appending(CommentFields.fragmentDefinition).appending(UpdatableFields.fragmentDefinition).appending(DeletableFields.fragmentDefinition).appending(ReferencedRepositoryFields.fragmentDefinition).appending(MilestoneFields.fragmentDefinition).appending(LockableFields.fragmentDefinition).appending(ClosableFields.fragmentDefinition).appending(LabelableFields.fragmentDefinition).appending(AssigneeFields.fragmentDefinition).appending(CommitContext.fragmentDefinition) }

  public var owner: String
  public var repo: String
  public var number: Int
  public var page_size: Int
  public var before: String?

  public init(owner: String, repo: String, number: Int, page_size: Int, before: String? = nil) {
    self.owner = owner
    self.repo = repo
    self.number = number
    self.page_size = page_size
    self.before = before
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "repo": repo, "number": number, "page_size": page_size, "before": before]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("repo")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("hasIssuesEnabled", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("viewerCanAdminister", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("mergeCommitAllowed", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("rebaseMergeAllowed", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("squashMergeAllowed", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("mentionableUsers", arguments: ["first": 50], type: .nonNull(.object(MentionableUser.selections))),
        GraphQLField("defaultBranchRef", type: .object(DefaultBranchRef.selections)),
        GraphQLField("issueOrPullRequest", arguments: ["number": GraphQLVariable("number")], type: .object(IssueOrPullRequest.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, hasIssuesEnabled: Bool, viewerCanAdminister: Bool, mergeCommitAllowed: Bool, rebaseMergeAllowed: Bool, squashMergeAllowed: Bool, mentionableUsers: MentionableUser, defaultBranchRef: DefaultBranchRef? = nil, issueOrPullRequest: IssueOrPullRequest? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "hasIssuesEnabled": hasIssuesEnabled, "viewerCanAdminister": viewerCanAdminister, "mergeCommitAllowed": mergeCommitAllowed, "rebaseMergeAllowed": rebaseMergeAllowed, "squashMergeAllowed": squashMergeAllowed, "mentionableUsers": mentionableUsers.resultMap, "defaultBranchRef": defaultBranchRef.flatMap { (value: DefaultBranchRef) -> ResultMap in value.resultMap }, "issueOrPullRequest": issueOrPullRequest.flatMap { (value: IssueOrPullRequest) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The name of the repository.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Indicates if the repository has issues feature enabled.
      public var hasIssuesEnabled: Bool {
        get {
          return resultMap["hasIssuesEnabled"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasIssuesEnabled")
        }
      }

      /// Indicates whether the viewer has admin permissions on this repository.
      public var viewerCanAdminister: Bool {
        get {
          return resultMap["viewerCanAdminister"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "viewerCanAdminister")
        }
      }

      /// Whether or not PRs are merged with a merge commit on this repository.
      public var mergeCommitAllowed: Bool {
        get {
          return resultMap["mergeCommitAllowed"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "mergeCommitAllowed")
        }
      }

      /// Whether or not rebase-merging is enabled on this repository.
      public var rebaseMergeAllowed: Bool {
        get {
          return resultMap["rebaseMergeAllowed"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "rebaseMergeAllowed")
        }
      }

      /// Whether or not squash-merging is enabled on this repository.
      public var squashMergeAllowed: Bool {
        get {
          return resultMap["squashMergeAllowed"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "squashMergeAllowed")
        }
      }

      /// A list of Users that can be mentioned in the context of the repository.
      public var mentionableUsers: MentionableUser {
        get {
          return MentionableUser(unsafeResultMap: resultMap["mentionableUsers"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "mentionableUsers")
        }
      }

      /// The Ref associated with the repository's default branch.
      public var defaultBranchRef: DefaultBranchRef? {
        get {
          return (resultMap["defaultBranchRef"] as? ResultMap).flatMap { DefaultBranchRef(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "defaultBranchRef")
        }
      }

      /// Returns a single issue-like object from the current repository by number.
      public var issueOrPullRequest: IssueOrPullRequest? {
        get {
          return (resultMap["issueOrPullRequest"] as? ResultMap).flatMap { IssueOrPullRequest(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "issueOrPullRequest")
        }
      }

      public struct MentionableUser: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
            GraphQLField("login", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(avatarUrl: String, login: String) {
            self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A URL pointing to the user's public avatar.
          public var avatarUrl: String {
            get {
              return resultMap["avatarUrl"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "avatarUrl")
            }
          }

          /// The username used to login.
          public var login: String {
            get {
              return resultMap["login"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "login")
            }
          }
        }
      }

      public struct DefaultBranchRef: GraphQLSelectionSet {
        public static let possibleTypes = ["Ref"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "Ref", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The ref name.
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct IssueOrPullRequest: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "PullRequest"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asIssue: AsIssue? {
          get {
            if !AsIssue.possibleTypes.contains(__typename) { return nil }
            return AsIssue(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsIssue: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("timeline", arguments: ["last": GraphQLVariable("page_size"), "before": GraphQLVariable("before")], type: .nonNull(.object(Timeline.selections))),
            GraphQLField("milestone", type: .object(Milestone.selections)),
            GraphQLFragmentSpread(ReactionFields.self),
            GraphQLFragmentSpread(CommentFields.self),
            GraphQLFragmentSpread(LockableFields.self),
            GraphQLFragmentSpread(ClosableFields.self),
            GraphQLFragmentSpread(LabelableFields.self),
            GraphQLFragmentSpread(UpdatableFields.self),
            GraphQLFragmentSpread(NodeFields.self),
            GraphQLFragmentSpread(AssigneeFields.self),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of events, comments, commits, etc. associated with the issue.
          public var timeline: Timeline {
            get {
              return Timeline(unsafeResultMap: resultMap["timeline"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "timeline")
            }
          }

          /// Identifies the milestone associated with the issue.
          public var milestone: Milestone? {
            get {
              return (resultMap["milestone"] as? ResultMap).flatMap { Milestone(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "milestone")
            }
          }

          /// Identifies the issue number.
          public var number: Int {
            get {
              return resultMap["number"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the issue title.
          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var lockableFields: LockableFields {
              get {
                return LockableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var closableFields: ClosableFields {
              get {
                return ClosableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var assigneeFields: AssigneeFields {
              get {
                return AssigneeFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct Timeline: GraphQLSelectionSet {
            public static let possibleTypes = ["IssueTimelineConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "IssueTimelineConnection", "pageInfo": pageInfo.resultMap, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Information to aid in pagination.
            public var pageInfo: PageInfo {
              get {
                return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct PageInfo: GraphQLSelectionSet {
              public static let possibleTypes = ["PageInfo"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(HeadPaging.self),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(hasPreviousPage: Bool, startCursor: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "PageInfo", "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var headPaging: HeadPaging {
                  get {
                    return HeadPaging(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Commit", "IssueComment", "CrossReferencedEvent", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "ReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent"]

              public static let selections: [GraphQLSelection] = [
                GraphQLTypeCase(
                  variants: ["Commit": AsCommit.selections, "IssueComment": AsIssueComment.selections, "LabeledEvent": AsLabeledEvent.selections, "UnlabeledEvent": AsUnlabeledEvent.selections, "ClosedEvent": AsClosedEvent.selections, "ReopenedEvent": AsReopenedEvent.selections, "RenamedTitleEvent": AsRenamedTitleEvent.selections, "LockedEvent": AsLockedEvent.selections, "UnlockedEvent": AsUnlockedEvent.selections, "CrossReferencedEvent": AsCrossReferencedEvent.selections, "ReferencedEvent": AsReferencedEvent.selections, "AssignedEvent": AsAssignedEvent.selections, "UnassignedEvent": AsUnassignedEvent.selections, "MilestonedEvent": AsMilestonedEvent.selections, "DemilestonedEvent": AsDemilestonedEvent.selections],
                  default: [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  ]
                )
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public static func makeSubscribedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "SubscribedEvent"])
              }

              public static func makeUnsubscribedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "UnsubscribedEvent"])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var asCommit: AsCommit? {
                get {
                  if !AsCommit.possibleTypes.contains(__typename) { return nil }
                  return AsCommit(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsCommit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("messageHeadline", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Authorship details of the commit.
                public var author: Author? {
                  get {
                    return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "author")
                  }
                }

                /// The Git object ID
                public var oid: String {
                  get {
                    return resultMap["oid"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "oid")
                  }
                }

                /// The Git commit message headline
                public var messageHeadline: String {
                  get {
                    return resultMap["messageHeadline"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "messageHeadline")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["GitActor"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("user", type: .object(User.selections)),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(user: User? = nil) {
                    self.init(unsafeResultMap: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The GitHub user corresponding to the email field. Null if no such user exists.
                  public var user: User? {
                    get {
                      return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                    }
                    set {
                      resultMap.updateValue(newValue?.resultMap, forKey: "user")
                    }
                  }

                  public struct User: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(login: String, avatarUrl: String) {
                      self.init(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return resultMap["login"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "login")
                      }
                    }

                    /// A URL pointing to the user's public avatar.
                    public var avatarUrl: String {
                      get {
                        return resultMap["avatarUrl"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "avatarUrl")
                      }
                    }
                  }
                }
              }

              public var asIssueComment: AsIssueComment? {
                get {
                  if !AsIssueComment.possibleTypes.contains(__typename) { return nil }
                  return AsIssueComment(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsIssueComment: GraphQLSelectionSet {
                public static let possibleTypes = ["IssueComment"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLFragmentSpread(ReactionFields.self),
                  GraphQLFragmentSpread(CommentFields.self),
                  GraphQLFragmentSpread(UpdatableFields.self),
                  GraphQLFragmentSpread(DeletableFields.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var reactionFields: ReactionFields {
                    get {
                      return ReactionFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var updatableFields: UpdatableFields {
                    get {
                      return UpdatableFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var deletableFields: DeletableFields {
                    get {
                      return DeletableFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public var asLabeledEvent: AsLabeledEvent? {
                get {
                  if !AsLabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLabeledEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsLabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'labeled' event.
                public var label: Label {
                  get {
                    return Label(unsafeResultMap: resultMap["label"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Label: GraphQLSelectionSet {
                  public static let possibleTypes = ["Label"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("color", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(color: String, name: String) {
                    self.init(unsafeResultMap: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return resultMap["color"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asUnlabeledEvent: AsUnlabeledEvent? {
                get {
                  if !AsUnlabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlabeledEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsUnlabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'unlabeled' event.
                public var label: Label {
                  get {
                    return Label(unsafeResultMap: resultMap["label"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Label: GraphQLSelectionSet {
                  public static let possibleTypes = ["Label"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("color", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(color: String, name: String) {
                    self.init(unsafeResultMap: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return resultMap["color"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asClosedEvent: AsClosedEvent? {
                get {
                  if !AsClosedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsClosedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsClosedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ClosedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("closer", type: .object(Closer.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Object which triggered the creation of this event.
                public var closer: Closer? {
                  get {
                    return (resultMap["closer"] as? ResultMap).flatMap { Closer(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "closer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Closer: GraphQLSelectionSet {
                  public static let possibleTypes = ["Commit", "PullRequest"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["Commit": AsCommit.selections, "PullRequest": AsPullRequest.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeCommit(oid: String) -> Closer {
                    return Closer(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                  }

                  public static func makePullRequest(mergeCommit: AsPullRequest.MergeCommit? = nil) -> Closer {
                    return Closer(unsafeResultMap: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: AsPullRequest.MergeCommit) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asCommit: AsCommit? {
                    get {
                      if !AsCommit.possibleTypes.contains(__typename) { return nil }
                      return AsCommit(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsCommit: GraphQLSelectionSet {
                    public static let possibleTypes = ["Commit"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(oid: String) {
                      self.init(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The Git object ID
                    public var oid: String {
                      get {
                        return resultMap["oid"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "oid")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("mergeCommit", type: .object(MergeCommit.selections)),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(mergeCommit: MergeCommit? = nil) {
                      self.init(unsafeResultMap: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: MergeCommit) -> ResultMap in value.resultMap }])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The commit that was created when this pull request was merged.
                    public var mergeCommit: MergeCommit? {
                      get {
                        return (resultMap["mergeCommit"] as? ResultMap).flatMap { MergeCommit(unsafeResultMap: $0) }
                      }
                      set {
                        resultMap.updateValue(newValue?.resultMap, forKey: "mergeCommit")
                      }
                    }

                    public struct MergeCommit: GraphQLSelectionSet {
                      public static let possibleTypes = ["Commit"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                      ]

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(oid: String) {
                        self.init(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The Git object ID
                      public var oid: String {
                        get {
                          return resultMap["oid"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "oid")
                        }
                      }
                    }
                  }
                }
              }

              public var asReopenedEvent: AsReopenedEvent? {
                get {
                  if !AsReopenedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReopenedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsReopenedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReopenedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asRenamedTitleEvent: AsRenamedTitleEvent? {
                get {
                  if !AsRenamedTitleEvent.possibleTypes.contains(__typename) { return nil }
                  return AsRenamedTitleEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsRenamedTitleEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["RenamedTitleEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("previousTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the current title of the issue or pull request.
                public var currentTitle: String {
                  get {
                    return resultMap["currentTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "currentTitle")
                  }
                }

                /// Identifies the previous title of the issue or pull request.
                public var previousTitle: String {
                  get {
                    return resultMap["previousTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "previousTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asLockedEvent: AsLockedEvent? {
                get {
                  if !AsLockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLockedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsLockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnlockedEvent: AsUnlockedEvent? {
                get {
                  if !AsUnlockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlockedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsUnlockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asCrossReferencedEvent: AsCrossReferencedEvent? {
                get {
                  if !AsCrossReferencedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsCrossReferencedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsCrossReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["CrossReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("source", type: .nonNull(.object(Source.selections))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Issue or pull request that made the reference.
                public var source: Source {
                  get {
                    return Source(unsafeResultMap: resultMap["source"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "source")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Source: GraphQLSelectionSet {
                  public static let possibleTypes = ["Issue", "PullRequest"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool, repository: AsIssue.Repository) -> Source {
                    return Source(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.resultMap])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool, repository: AsPullRequest.Repository) -> Source {
                    return Source(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.resultMap])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsIssue: GraphQLSelectionSet {
                    public static let possibleTypes = ["Issue"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool, repository: Repository) {
                      self.init(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.resultMap])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
                      }
                      set {
                        resultMap.updateValue(newValue.resultMap, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(name: String, owner: Owner) {
                        self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "owner": owner.resultMap])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return resultMap["name"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
                        }
                        set {
                          resultMap.updateValue(newValue.resultMap, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public private(set) var resultMap: ResultMap

                        public init(unsafeResultMap: ResultMap) {
                          self.resultMap = unsafeResultMap
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return resultMap["__typename"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return resultMap["login"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "login")
                          }
                        }
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("merged", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool, repository: Repository) {
                      self.init(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.resultMap])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return resultMap["merged"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "merged")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
                      }
                      set {
                        resultMap.updateValue(newValue.resultMap, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(name: String, owner: Owner) {
                        self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "owner": owner.resultMap])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return resultMap["name"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
                        }
                        set {
                          resultMap.updateValue(newValue.resultMap, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public private(set) var resultMap: ResultMap

                        public init(unsafeResultMap: ResultMap) {
                          self.resultMap = unsafeResultMap
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return resultMap["__typename"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return resultMap["login"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "login")
                          }
                        }
                      }
                    }
                  }
                }
              }

              public var asReferencedEvent: AsReferencedEvent? {
                get {
                  if !AsReferencedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReferencedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("commit", alias: "refCommit", type: .object(RefCommit.selections)),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("commitRepository", type: .nonNull(.object(CommitRepository.selections))),
                  GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the commit associated with the 'referenced' event.
                public var refCommit: RefCommit? {
                  get {
                    return (resultMap["refCommit"] as? ResultMap).flatMap { RefCommit(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "refCommit")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the repository associated with the 'referenced' event.
                public var commitRepository: CommitRepository {
                  get {
                    return CommitRepository(unsafeResultMap: resultMap["commitRepository"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "commitRepository")
                  }
                }

                /// Object referenced by event.
                public var subject: Subject {
                  get {
                    return Subject(unsafeResultMap: resultMap["subject"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "subject")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct RefCommit: GraphQLSelectionSet {
                  public static let possibleTypes = ["Commit"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(oid: String) {
                    self.init(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The Git object ID
                  public var oid: String {
                    get {
                      return resultMap["oid"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "oid")
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct CommitRepository: GraphQLSelectionSet {
                  public static let possibleTypes = ["Repository"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(ReferencedRepositoryFields.self),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var fragments: Fragments {
                    get {
                      return Fragments(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public struct Fragments {
                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public var referencedRepositoryFields: ReferencedRepositoryFields {
                      get {
                        return ReferencedRepositoryFields(unsafeResultMap: resultMap)
                      }
                      set {
                        resultMap += newValue.resultMap
                      }
                    }
                  }
                }

                public struct Subject: GraphQLSelectionSet {
                  public static let possibleTypes = ["Issue", "PullRequest"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool) -> Subject {
                    return Subject(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool) -> Subject {
                    return Subject(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsIssue: GraphQLSelectionSet {
                    public static let possibleTypes = ["Issue"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool) {
                      self.init(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("merged", type: .nonNull(.scalar(Bool.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool) {
                      self.init(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return resultMap["merged"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "merged")
                      }
                    }
                  }
                }
              }

              public var asAssignedEvent: AsAssignedEvent? {
                get {
                  if !AsAssignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsAssignedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsAssignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["AssignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the user who was assigned.
                public var user: User? {
                  get {
                    return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(login: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnassignedEvent: AsUnassignedEvent? {
                get {
                  if !AsUnassignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnassignedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsUnassignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnassignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the subject (user) who was unassigned.
                public var user: User? {
                  get {
                    return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(login: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asMilestonedEvent: AsMilestonedEvent? {
                get {
                  if !AsMilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsMilestonedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsMilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["MilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'milestoned' event.
                public var milestoneTitle: String {
                  get {
                    return resultMap["milestoneTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asDemilestonedEvent: AsDemilestonedEvent? {
                get {
                  if !AsDemilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsDemilestonedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsDemilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["DemilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'demilestoned' event.
                public var milestoneTitle: String {
                  get {
                    return resultMap["milestoneTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }
            }
          }

          public struct Milestone: GraphQLSelectionSet {
            public static let possibleTypes = ["Milestone"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(MilestoneFields.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var milestoneFields: MilestoneFields {
                get {
                  return MilestoneFields(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }

        public var asPullRequest: AsPullRequest? {
          get {
            if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
            return AsPullRequest(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsPullRequest: GraphQLSelectionSet {
          public static let possibleTypes = ["PullRequest"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("timeline", arguments: ["last": GraphQLVariable("page_size"), "before": GraphQLVariable("before")], type: .nonNull(.object(Timeline.selections))),
            GraphQLField("reviewRequests", arguments: ["first": GraphQLVariable("page_size")], type: .object(ReviewRequest.selections)),
            GraphQLField("commits", arguments: ["last": 1], type: .nonNull(.object(Commit.selections))),
            GraphQLField("milestone", type: .object(Milestone.selections)),
            GraphQLFragmentSpread(ReactionFields.self),
            GraphQLFragmentSpread(CommentFields.self),
            GraphQLFragmentSpread(LockableFields.self),
            GraphQLFragmentSpread(ClosableFields.self),
            GraphQLFragmentSpread(LabelableFields.self),
            GraphQLFragmentSpread(UpdatableFields.self),
            GraphQLFragmentSpread(NodeFields.self),
            GraphQLFragmentSpread(AssigneeFields.self),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("merged", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("baseRefName", type: .nonNull(.scalar(String.self))),
            GraphQLField("changedFiles", type: .nonNull(.scalar(Int.self))),
            GraphQLField("additions", type: .nonNull(.scalar(Int.self))),
            GraphQLField("deletions", type: .nonNull(.scalar(Int.self))),
            GraphQLField("mergeable", type: .nonNull(.scalar(MergeableState.self))),
            GraphQLField("mergeStateStatus", type: .nonNull(.scalar(MergeStateStatus.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of events, comments, commits, etc. associated with the pull request.
          public var timeline: Timeline {
            get {
              return Timeline(unsafeResultMap: resultMap["timeline"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "timeline")
            }
          }

          /// A list of review requests associated with the pull request.
          public var reviewRequests: ReviewRequest? {
            get {
              return (resultMap["reviewRequests"] as? ResultMap).flatMap { ReviewRequest(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "reviewRequests")
            }
          }

          /// A list of commits present in this pull request's head branch not present in the base branch.
          public var commits: Commit {
            get {
              return Commit(unsafeResultMap: resultMap["commits"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "commits")
            }
          }

          /// Identifies the milestone associated with the pull request.
          public var milestone: Milestone? {
            get {
              return (resultMap["milestone"] as? ResultMap).flatMap { Milestone(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "milestone")
            }
          }

          /// Identifies the pull request number.
          public var number: Int {
            get {
              return resultMap["number"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the pull request title.
          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          /// Whether or not the pull request was merged.
          public var merged: Bool {
            get {
              return resultMap["merged"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "merged")
            }
          }

          /// Identifies the name of the base Ref associated with the pull request, even if the ref has been deleted.
          public var baseRefName: String {
            get {
              return resultMap["baseRefName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "baseRefName")
            }
          }

          /// The number of changed files in this pull request.
          public var changedFiles: Int {
            get {
              return resultMap["changedFiles"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "changedFiles")
            }
          }

          /// The number of additions in this pull request.
          public var additions: Int {
            get {
              return resultMap["additions"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "additions")
            }
          }

          /// The number of deletions in this pull request.
          public var deletions: Int {
            get {
              return resultMap["deletions"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "deletions")
            }
          }

          /// Whether or not the pull request can be merged based on the existence of merge conflicts.
          public var mergeable: MergeableState {
            get {
              return resultMap["mergeable"]! as! MergeableState
            }
            set {
              resultMap.updateValue(newValue, forKey: "mergeable")
            }
          }

          /// Detailed information about the current pull request merge state status.
          public var mergeStateStatus: MergeStateStatus {
            get {
              return resultMap["mergeStateStatus"]! as! MergeStateStatus
            }
            set {
              resultMap.updateValue(newValue, forKey: "mergeStateStatus")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var lockableFields: LockableFields {
              get {
                return LockableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var closableFields: ClosableFields {
              get {
                return ClosableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var assigneeFields: AssigneeFields {
              get {
                return AssigneeFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct Timeline: GraphQLSelectionSet {
            public static let possibleTypes = ["PullRequestTimelineConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "PullRequestTimelineConnection", "pageInfo": pageInfo.resultMap, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Information to aid in pagination.
            public var pageInfo: PageInfo {
              get {
                return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct PageInfo: GraphQLSelectionSet {
              public static let possibleTypes = ["PageInfo"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(HeadPaging.self),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(hasPreviousPage: Bool, startCursor: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "PageInfo", "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var headPaging: HeadPaging {
                  get {
                    return HeadPaging(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Commit", "CommitCommentThread", "PullRequestReview", "PullRequestReviewThread", "PullRequestReviewComment", "IssueComment", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "MergedEvent", "ReferencedEvent", "CrossReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent", "DeployedEvent", "HeadRefDeletedEvent", "HeadRefRestoredEvent", "HeadRefForcePushedEvent", "BaseRefForcePushedEvent", "ReviewRequestedEvent", "ReviewRequestRemovedEvent", "ReviewDismissedEvent"]

              public static let selections: [GraphQLSelection] = [
                GraphQLTypeCase(
                  variants: ["Commit": AsCommit.selections, "IssueComment": AsIssueComment.selections, "LabeledEvent": AsLabeledEvent.selections, "UnlabeledEvent": AsUnlabeledEvent.selections, "ClosedEvent": AsClosedEvent.selections, "ReopenedEvent": AsReopenedEvent.selections, "RenamedTitleEvent": AsRenamedTitleEvent.selections, "LockedEvent": AsLockedEvent.selections, "UnlockedEvent": AsUnlockedEvent.selections, "MergedEvent": AsMergedEvent.selections, "PullRequestReviewThread": AsPullRequestReviewThread.selections, "PullRequestReview": AsPullRequestReview.selections, "CrossReferencedEvent": AsCrossReferencedEvent.selections, "ReferencedEvent": AsReferencedEvent.selections, "AssignedEvent": AsAssignedEvent.selections, "UnassignedEvent": AsUnassignedEvent.selections, "ReviewRequestedEvent": AsReviewRequestedEvent.selections, "ReviewRequestRemovedEvent": AsReviewRequestRemovedEvent.selections, "MilestonedEvent": AsMilestonedEvent.selections, "DemilestonedEvent": AsDemilestonedEvent.selections],
                  default: [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  ]
                )
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public static func makeCommitCommentThread() -> Node {
                return Node(unsafeResultMap: ["__typename": "CommitCommentThread"])
              }

              public static func makePullRequestReviewComment() -> Node {
                return Node(unsafeResultMap: ["__typename": "PullRequestReviewComment"])
              }

              public static func makeSubscribedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "SubscribedEvent"])
              }

              public static func makeUnsubscribedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "UnsubscribedEvent"])
              }

              public static func makeDeployedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "DeployedEvent"])
              }

              public static func makeHeadRefDeletedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "HeadRefDeletedEvent"])
              }

              public static func makeHeadRefRestoredEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "HeadRefRestoredEvent"])
              }

              public static func makeHeadRefForcePushedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "HeadRefForcePushedEvent"])
              }

              public static func makeBaseRefForcePushedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "BaseRefForcePushedEvent"])
              }

              public static func makeReviewDismissedEvent() -> Node {
                return Node(unsafeResultMap: ["__typename": "ReviewDismissedEvent"])
              }

              public static func makePullRequestReviewThread(comments: AsPullRequestReviewThread.Comment) -> Node {
                return Node(unsafeResultMap: ["__typename": "PullRequestReviewThread", "comments": comments.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var asCommit: AsCommit? {
                get {
                  if !AsCommit.possibleTypes.contains(__typename) { return nil }
                  return AsCommit(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsCommit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("messageHeadline", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Authorship details of the commit.
                public var author: Author? {
                  get {
                    return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "author")
                  }
                }

                /// The Git object ID
                public var oid: String {
                  get {
                    return resultMap["oid"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "oid")
                  }
                }

                /// The Git commit message headline
                public var messageHeadline: String {
                  get {
                    return resultMap["messageHeadline"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "messageHeadline")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["GitActor"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("user", type: .object(User.selections)),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(user: User? = nil) {
                    self.init(unsafeResultMap: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The GitHub user corresponding to the email field. Null if no such user exists.
                  public var user: User? {
                    get {
                      return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                    }
                    set {
                      resultMap.updateValue(newValue?.resultMap, forKey: "user")
                    }
                  }

                  public struct User: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(login: String, avatarUrl: String) {
                      self.init(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return resultMap["login"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "login")
                      }
                    }

                    /// A URL pointing to the user's public avatar.
                    public var avatarUrl: String {
                      get {
                        return resultMap["avatarUrl"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "avatarUrl")
                      }
                    }
                  }
                }
              }

              public var asIssueComment: AsIssueComment? {
                get {
                  if !AsIssueComment.possibleTypes.contains(__typename) { return nil }
                  return AsIssueComment(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsIssueComment: GraphQLSelectionSet {
                public static let possibleTypes = ["IssueComment"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLFragmentSpread(ReactionFields.self),
                  GraphQLFragmentSpread(CommentFields.self),
                  GraphQLFragmentSpread(UpdatableFields.self),
                  GraphQLFragmentSpread(DeletableFields.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var reactionFields: ReactionFields {
                    get {
                      return ReactionFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var updatableFields: UpdatableFields {
                    get {
                      return UpdatableFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var deletableFields: DeletableFields {
                    get {
                      return DeletableFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public var asLabeledEvent: AsLabeledEvent? {
                get {
                  if !AsLabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLabeledEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsLabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'labeled' event.
                public var label: Label {
                  get {
                    return Label(unsafeResultMap: resultMap["label"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Label: GraphQLSelectionSet {
                  public static let possibleTypes = ["Label"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("color", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(color: String, name: String) {
                    self.init(unsafeResultMap: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return resultMap["color"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asUnlabeledEvent: AsUnlabeledEvent? {
                get {
                  if !AsUnlabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlabeledEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsUnlabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'unlabeled' event.
                public var label: Label {
                  get {
                    return Label(unsafeResultMap: resultMap["label"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Label: GraphQLSelectionSet {
                  public static let possibleTypes = ["Label"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("color", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(color: String, name: String) {
                    self.init(unsafeResultMap: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return resultMap["color"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asClosedEvent: AsClosedEvent? {
                get {
                  if !AsClosedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsClosedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsClosedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ClosedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("closer", type: .object(Closer.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Object which triggered the creation of this event.
                public var closer: Closer? {
                  get {
                    return (resultMap["closer"] as? ResultMap).flatMap { Closer(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "closer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Closer: GraphQLSelectionSet {
                  public static let possibleTypes = ["Commit", "PullRequest"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["Commit": AsCommit.selections, "PullRequest": AsPullRequest.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeCommit(oid: String) -> Closer {
                    return Closer(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                  }

                  public static func makePullRequest(mergeCommit: AsPullRequest.MergeCommit? = nil) -> Closer {
                    return Closer(unsafeResultMap: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: AsPullRequest.MergeCommit) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asCommit: AsCommit? {
                    get {
                      if !AsCommit.possibleTypes.contains(__typename) { return nil }
                      return AsCommit(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsCommit: GraphQLSelectionSet {
                    public static let possibleTypes = ["Commit"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(oid: String) {
                      self.init(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The Git object ID
                    public var oid: String {
                      get {
                        return resultMap["oid"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "oid")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("mergeCommit", type: .object(MergeCommit.selections)),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(mergeCommit: MergeCommit? = nil) {
                      self.init(unsafeResultMap: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: MergeCommit) -> ResultMap in value.resultMap }])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The commit that was created when this pull request was merged.
                    public var mergeCommit: MergeCommit? {
                      get {
                        return (resultMap["mergeCommit"] as? ResultMap).flatMap { MergeCommit(unsafeResultMap: $0) }
                      }
                      set {
                        resultMap.updateValue(newValue?.resultMap, forKey: "mergeCommit")
                      }
                    }

                    public struct MergeCommit: GraphQLSelectionSet {
                      public static let possibleTypes = ["Commit"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                      ]

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(oid: String) {
                        self.init(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The Git object ID
                      public var oid: String {
                        get {
                          return resultMap["oid"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "oid")
                        }
                      }
                    }
                  }
                }
              }

              public var asReopenedEvent: AsReopenedEvent? {
                get {
                  if !AsReopenedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReopenedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsReopenedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReopenedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asRenamedTitleEvent: AsRenamedTitleEvent? {
                get {
                  if !AsRenamedTitleEvent.possibleTypes.contains(__typename) { return nil }
                  return AsRenamedTitleEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsRenamedTitleEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["RenamedTitleEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("previousTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the current title of the issue or pull request.
                public var currentTitle: String {
                  get {
                    return resultMap["currentTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "currentTitle")
                  }
                }

                /// Identifies the previous title of the issue or pull request.
                public var previousTitle: String {
                  get {
                    return resultMap["previousTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "previousTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asLockedEvent: AsLockedEvent? {
                get {
                  if !AsLockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLockedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsLockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnlockedEvent: AsUnlockedEvent? {
                get {
                  if !AsUnlockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlockedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsUnlockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asMergedEvent: AsMergedEvent? {
                get {
                  if !AsMergedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsMergedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsMergedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["MergedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("commit", alias: "mergedCommit", type: .object(MergedCommit.selections)),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the commit associated with the `merge` event.
                public var mergedCommit: MergedCommit? {
                  get {
                    return (resultMap["mergedCommit"] as? ResultMap).flatMap { MergedCommit(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "mergedCommit")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct MergedCommit: GraphQLSelectionSet {
                  public static let possibleTypes = ["Commit"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(oid: String) {
                    self.init(unsafeResultMap: ["__typename": "Commit", "oid": oid])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The Git object ID
                  public var oid: String {
                    get {
                      return resultMap["oid"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "oid")
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asPullRequestReviewThread: AsPullRequestReviewThread? {
                get {
                  if !AsPullRequestReviewThread.possibleTypes.contains(__typename) { return nil }
                  return AsPullRequestReviewThread(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsPullRequestReviewThread: GraphQLSelectionSet {
                public static let possibleTypes = ["PullRequestReviewThread"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("comments", arguments: ["first": GraphQLVariable("page_size")], type: .nonNull(.object(Comment.selections))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(comments: Comment) {
                  self.init(unsafeResultMap: ["__typename": "PullRequestReviewThread", "comments": comments.resultMap])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A list of pull request comments associated with the thread.
                public var comments: Comment {
                  get {
                    return Comment(unsafeResultMap: resultMap["comments"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "comments")
                  }
                }

                public struct Comment: GraphQLSelectionSet {
                  public static let possibleTypes = ["PullRequestReviewCommentConnection"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("nodes", type: .list(.object(Node.selections))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(nodes: [Node?]? = nil) {
                    self.init(unsafeResultMap: ["__typename": "PullRequestReviewCommentConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// A list of nodes.
                  public var nodes: [Node?]? {
                    get {
                      return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                    }
                    set {
                      resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                    }
                  }

                  public struct Node: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequestReviewComment"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLFragmentSpread(ReactionFields.self),
                      GraphQLFragmentSpread(NodeFields.self),
                      GraphQLFragmentSpread(CommentFields.self),
                      GraphQLField("path", type: .nonNull(.scalar(String.self))),
                      GraphQLField("diffHunk", type: .nonNull(.scalar(String.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The path to which the comment applies.
                    public var path: String {
                      get {
                        return resultMap["path"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "path")
                      }
                    }

                    /// The diff hunk to which the comment applies.
                    public var diffHunk: String {
                      get {
                        return resultMap["diffHunk"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "diffHunk")
                      }
                    }

                    public var fragments: Fragments {
                      get {
                        return Fragments(unsafeResultMap: resultMap)
                      }
                      set {
                        resultMap += newValue.resultMap
                      }
                    }

                    public struct Fragments {
                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public var reactionFields: ReactionFields {
                        get {
                          return ReactionFields(unsafeResultMap: resultMap)
                        }
                        set {
                          resultMap += newValue.resultMap
                        }
                      }

                      public var nodeFields: NodeFields {
                        get {
                          return NodeFields(unsafeResultMap: resultMap)
                        }
                        set {
                          resultMap += newValue.resultMap
                        }
                      }

                      public var commentFields: CommentFields {
                        get {
                          return CommentFields(unsafeResultMap: resultMap)
                        }
                        set {
                          resultMap += newValue.resultMap
                        }
                      }
                    }
                  }
                }
              }

              public var asPullRequestReview: AsPullRequestReview? {
                get {
                  if !AsPullRequestReview.possibleTypes.contains(__typename) { return nil }
                  return AsPullRequestReview(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsPullRequestReview: GraphQLSelectionSet {
                public static let possibleTypes = ["PullRequestReview"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLFragmentSpread(CommentFields.self),
                  GraphQLField("state", type: .nonNull(.scalar(PullRequestReviewState.self))),
                  GraphQLField("submittedAt", type: .scalar(String.self)),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("comments", type: .nonNull(.object(Comment.selections))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the current state of the pull request review.
                public var state: PullRequestReviewState {
                  get {
                    return resultMap["state"]! as! PullRequestReviewState
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "state")
                  }
                }

                /// Identifies when the Pull Request Review was submitted
                public var submittedAt: String? {
                  get {
                    return resultMap["submittedAt"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "submittedAt")
                  }
                }

                /// The actor who authored the comment.
                public var author: Author? {
                  get {
                    return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "author")
                  }
                }

                /// A list of review comments for the current pull request review.
                public var comments: Comment {
                  get {
                    return Comment(unsafeResultMap: resultMap["comments"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "comments")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Author {
                    return Author(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Author {
                    return Author(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Author {
                    return Author(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Comment: GraphQLSelectionSet {
                  public static let possibleTypes = ["PullRequestReviewCommentConnection"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(totalCount: Int) {
                    self.init(unsafeResultMap: ["__typename": "PullRequestReviewCommentConnection", "totalCount": totalCount])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the total count of items in the connection.
                  public var totalCount: Int {
                    get {
                      return resultMap["totalCount"]! as! Int
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "totalCount")
                    }
                  }
                }
              }

              public var asCrossReferencedEvent: AsCrossReferencedEvent? {
                get {
                  if !AsCrossReferencedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsCrossReferencedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsCrossReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["CrossReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("source", type: .nonNull(.object(Source.selections))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Issue or pull request that made the reference.
                public var source: Source {
                  get {
                    return Source(unsafeResultMap: resultMap["source"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "source")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Source: GraphQLSelectionSet {
                  public static let possibleTypes = ["Issue", "PullRequest"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool, repository: AsIssue.Repository) -> Source {
                    return Source(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.resultMap])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool, repository: AsPullRequest.Repository) -> Source {
                    return Source(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.resultMap])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsIssue: GraphQLSelectionSet {
                    public static let possibleTypes = ["Issue"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool, repository: Repository) {
                      self.init(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.resultMap])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
                      }
                      set {
                        resultMap.updateValue(newValue.resultMap, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(name: String, owner: Owner) {
                        self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "owner": owner.resultMap])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return resultMap["name"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
                        }
                        set {
                          resultMap.updateValue(newValue.resultMap, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public private(set) var resultMap: ResultMap

                        public init(unsafeResultMap: ResultMap) {
                          self.resultMap = unsafeResultMap
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return resultMap["__typename"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return resultMap["login"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "login")
                          }
                        }
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("merged", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool, repository: Repository) {
                      self.init(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.resultMap])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return resultMap["merged"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "merged")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
                      }
                      set {
                        resultMap.updateValue(newValue.resultMap, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(name: String, owner: Owner) {
                        self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "owner": owner.resultMap])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return resultMap["name"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
                        }
                        set {
                          resultMap.updateValue(newValue.resultMap, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public private(set) var resultMap: ResultMap

                        public init(unsafeResultMap: ResultMap) {
                          self.resultMap = unsafeResultMap
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(unsafeResultMap: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return resultMap["__typename"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return resultMap["login"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "login")
                          }
                        }
                      }
                    }
                  }
                }
              }

              public var asReferencedEvent: AsReferencedEvent? {
                get {
                  if !AsReferencedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReferencedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("commitRepository", type: .nonNull(.object(CommitRepository.selections))),
                  GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the repository associated with the 'referenced' event.
                public var commitRepository: CommitRepository {
                  get {
                    return CommitRepository(unsafeResultMap: resultMap["commitRepository"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "commitRepository")
                  }
                }

                /// Object referenced by event.
                public var subject: Subject {
                  get {
                    return Subject(unsafeResultMap: resultMap["subject"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "subject")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct CommitRepository: GraphQLSelectionSet {
                  public static let possibleTypes = ["Repository"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(ReferencedRepositoryFields.self),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var fragments: Fragments {
                    get {
                      return Fragments(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }

                  public struct Fragments {
                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public var referencedRepositoryFields: ReferencedRepositoryFields {
                      get {
                        return ReferencedRepositoryFields(unsafeResultMap: resultMap)
                      }
                      set {
                        resultMap += newValue.resultMap
                      }
                    }
                  }
                }

                public struct Subject: GraphQLSelectionSet {
                  public static let possibleTypes = ["Issue", "PullRequest"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool) -> Subject {
                    return Subject(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool) -> Subject {
                    return Subject(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsIssue: GraphQLSelectionSet {
                    public static let possibleTypes = ["Issue"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool) {
                      self.init(unsafeResultMap: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
                      GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("merged", type: .nonNull(.scalar(Bool.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool) {
                      self.init(unsafeResultMap: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return resultMap["title"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return resultMap["number"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return resultMap["closed"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return resultMap["merged"]! as! Bool
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "merged")
                      }
                    }
                  }
                }
              }

              public var asAssignedEvent: AsAssignedEvent? {
                get {
                  if !AsAssignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsAssignedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsAssignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["AssignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the user who was assigned.
                public var user: User? {
                  get {
                    return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(login: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnassignedEvent: AsUnassignedEvent? {
                get {
                  if !AsUnassignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnassignedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsUnassignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnassignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the subject (user) who was unassigned.
                public var user: User? {
                  get {
                    return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(login: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asReviewRequestedEvent: AsReviewRequestedEvent? {
                get {
                  if !AsReviewRequestedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReviewRequestedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsReviewRequestedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReviewRequestedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the reviewer whose review was requested.
                public var requestedReviewer: RequestedReviewer? {
                  get {
                    return (resultMap["requestedReviewer"] as? ResultMap).flatMap { RequestedReviewer(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "requestedReviewer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct RequestedReviewer: GraphQLSelectionSet {
                  public static let possibleTypes = ["User", "Team"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["User": AsUser.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeTeam() -> RequestedReviewer {
                    return RequestedReviewer(unsafeResultMap: ["__typename": "Team"])
                  }

                  public static func makeUser(login: String) -> RequestedReviewer {
                    return RequestedReviewer(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asUser: AsUser? {
                    get {
                      if !AsUser.possibleTypes.contains(__typename) { return nil }
                      return AsUser(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsUser: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(login: String) {
                      self.init(unsafeResultMap: ["__typename": "User", "login": login])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return resultMap["login"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "login")
                      }
                    }
                  }
                }
              }

              public var asReviewRequestRemovedEvent: AsReviewRequestRemovedEvent? {
                get {
                  if !AsReviewRequestRemovedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReviewRequestRemovedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsReviewRequestRemovedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReviewRequestRemovedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the reviewer whose review request was removed.
                public var requestedReviewer: RequestedReviewer? {
                  get {
                    return (resultMap["requestedReviewer"] as? ResultMap).flatMap { RequestedReviewer(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "requestedReviewer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct RequestedReviewer: GraphQLSelectionSet {
                  public static let possibleTypes = ["User", "Team"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLTypeCase(
                      variants: ["User": AsUser.selections],
                      default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      ]
                    )
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeTeam() -> RequestedReviewer {
                    return RequestedReviewer(unsafeResultMap: ["__typename": "Team"])
                  }

                  public static func makeUser(login: String) -> RequestedReviewer {
                    return RequestedReviewer(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asUser: AsUser? {
                    get {
                      if !AsUser.possibleTypes.contains(__typename) { return nil }
                      return AsUser(unsafeResultMap: resultMap)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      resultMap = newValue.resultMap
                    }
                  }

                  public struct AsUser: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(login: String) {
                      self.init(unsafeResultMap: ["__typename": "User", "login": login])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return resultMap["login"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "login")
                      }
                    }
                  }
                }
              }

              public var asMilestonedEvent: AsMilestonedEvent? {
                get {
                  if !AsMilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsMilestonedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsMilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["MilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'milestoned' event.
                public var milestoneTitle: String {
                  get {
                    return resultMap["milestoneTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asDemilestonedEvent: AsDemilestonedEvent? {
                get {
                  if !AsDemilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsDemilestonedEvent(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap = newValue.resultMap
                }
              }

              public struct AsDemilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["DemilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(NodeFields.self),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (resultMap["actor"] as? ResultMap).flatMap { Actor(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'demilestoned' event.
                public var milestoneTitle: String {
                  get {
                    return resultMap["milestoneTitle"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(unsafeResultMap: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }
            }
          }

          public struct ReviewRequest: GraphQLSelectionSet {
            public static let possibleTypes = ["ReviewRequestConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "ReviewRequestConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["ReviewRequest"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(requestedReviewer: RequestedReviewer? = nil) {
                self.init(unsafeResultMap: ["__typename": "ReviewRequest", "requestedReviewer": requestedReviewer.flatMap { (value: RequestedReviewer) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The reviewer that is requested.
              public var requestedReviewer: RequestedReviewer? {
                get {
                  return (resultMap["requestedReviewer"] as? ResultMap).flatMap { RequestedReviewer(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "requestedReviewer")
                }
              }

              public struct RequestedReviewer: GraphQLSelectionSet {
                public static let possibleTypes = ["User", "Team"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLTypeCase(
                    variants: ["User": AsUser.selections],
                    default: [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    ]
                  )
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public static func makeTeam() -> RequestedReviewer {
                  return RequestedReviewer(unsafeResultMap: ["__typename": "Team"])
                }

                public static func makeUser(login: String, avatarUrl: String) -> RequestedReviewer {
                  return RequestedReviewer(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var asUser: AsUser? {
                  get {
                    if !AsUser.possibleTypes.contains(__typename) { return nil }
                    return AsUser(unsafeResultMap: resultMap)
                  }
                  set {
                    guard let newValue = newValue else { return }
                    resultMap = newValue.resultMap
                  }
                }

                public struct AsUser: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(login: String, avatarUrl: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return resultMap["login"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "login")
                    }
                  }

                  /// A URL pointing to the user's public avatar.
                  public var avatarUrl: String {
                    get {
                      return resultMap["avatarUrl"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "avatarUrl")
                    }
                  }
                }
              }
            }
          }

          public struct Commit: GraphQLSelectionSet {
            public static let possibleTypes = ["PullRequestCommitConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "PullRequestCommitConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["PullRequestCommit"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("commit", type: .nonNull(.object(Commit.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(commit: Commit) {
                self.init(unsafeResultMap: ["__typename": "PullRequestCommit", "commit": commit.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The Git commit object
              public var commit: Commit {
                get {
                  return Commit(unsafeResultMap: resultMap["commit"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "commit")
                }
              }

              public struct Commit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(CommitContext.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var commitContext: CommitContext {
                    get {
                      return CommitContext(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }
            }
          }

          public struct Milestone: GraphQLSelectionSet {
            public static let possibleTypes = ["Milestone"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(MilestoneFields.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var milestoneFields: MilestoneFields {
                get {
                  return MilestoneFields(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class RepoFilesQuery: GraphQLQuery {
  public let operationDefinition =
    "query RepoFiles($owner: String!, $name: String!, $branchAndPath: String!) {\n  repository(owner: $owner, name: $name) {\n    __typename\n    object(expression: $branchAndPath) {\n      __typename\n      ... on Tree {\n        entries {\n          __typename\n          name\n          type\n        }\n      }\n    }\n  }\n}"

  public var owner: String
  public var name: String
  public var branchAndPath: String

  public init(owner: String, name: String, branchAndPath: String) {
    self.owner = owner
    self.name = name
    self.branchAndPath = branchAndPath
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "branchAndPath": branchAndPath]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("object", arguments: ["expression": GraphQLVariable("branchAndPath")], type: .object(Object.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(object: Object? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "object": object.flatMap { (value: Object) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A Git object in the repository
      public var object: Object? {
        get {
          return (resultMap["object"] as? ResultMap).flatMap { Object(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "object")
        }
      }

      public struct Object: GraphQLSelectionSet {
        public static let possibleTypes = ["Commit", "Tree", "Blob", "Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Tree": AsTree.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeCommit() -> Object {
          return Object(unsafeResultMap: ["__typename": "Commit"])
        }

        public static func makeBlob() -> Object {
          return Object(unsafeResultMap: ["__typename": "Blob"])
        }

        public static func makeTag() -> Object {
          return Object(unsafeResultMap: ["__typename": "Tag"])
        }

        public static func makeTree(entries: [AsTree.Entry]? = nil) -> Object {
          return Object(unsafeResultMap: ["__typename": "Tree", "entries": entries.flatMap { (value: [AsTree.Entry]) -> [ResultMap] in value.map { (value: AsTree.Entry) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asTree: AsTree? {
          get {
            if !AsTree.possibleTypes.contains(__typename) { return nil }
            return AsTree(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsTree: GraphQLSelectionSet {
          public static let possibleTypes = ["Tree"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("entries", type: .list(.nonNull(.object(Entry.selections)))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(entries: [Entry]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Tree", "entries": entries.flatMap { (value: [Entry]) -> [ResultMap] in value.map { (value: Entry) -> ResultMap in value.resultMap } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of tree entries.
          public var entries: [Entry]? {
            get {
              return (resultMap["entries"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Entry] in value.map { (value: ResultMap) -> Entry in Entry(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Entry]) -> [ResultMap] in value.map { (value: Entry) -> ResultMap in value.resultMap } }, forKey: "entries")
            }
          }

          public struct Entry: GraphQLSelectionSet {
            public static let possibleTypes = ["TreeEntry"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String, type: String) {
              self.init(unsafeResultMap: ["__typename": "TreeEntry", "name": name, "type": type])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Entry file name.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// Entry file type.
            public var type: String {
              get {
                return resultMap["type"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "type")
              }
            }
          }
        }
      }
    }
  }
}

public final class RepoSearchPagesQuery: GraphQLQuery {
  public let operationDefinition =
    "query RepoSearchPages($query: String!, $after: String, $page_size: Int!) {\n  search(query: $query, type: ISSUE, after: $after, first: $page_size) {\n    __typename\n    nodes {\n      __typename\n      ... on Issue {\n        ...repoEventFields\n        ...nodeFields\n        ...labelableFields\n        title\n        number\n        issueState: state\n      }\n      ... on PullRequest {\n        ...repoEventFields\n        ...nodeFields\n        ...labelableFields\n        title\n        number\n        pullRequestState: state\n        commits(last: 1) {\n          __typename\n          nodes {\n            __typename\n            commit {\n              __typename\n              status {\n                __typename\n                state\n              }\n            }\n          }\n        }\n      }\n    }\n    pageInfo {\n      __typename\n      hasNextPage\n      endCursor\n    }\n    issueCount\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(RepoEventFields.fragmentDefinition).appending(NodeFields.fragmentDefinition).appending(LabelableFields.fragmentDefinition) }

  public var query: String
  public var after: String?
  public var page_size: Int

  public init(query: String, after: String? = nil, page_size: Int) {
    self.query = query
    self.after = after
    self.page_size = page_size
  }

  public var variables: GraphQLMap? {
    return ["query": query, "after": after, "page_size": page_size]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["query": GraphQLVariable("query"), "type": "ISSUE", "after": GraphQLVariable("after"), "first": GraphQLVariable("page_size")], type: .nonNull(.object(Search.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.resultMap])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(unsafeResultMap: resultMap["search"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
        GraphQLField("issueCount", type: .nonNull(.scalar(Int.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil, pageInfo: PageInfo, issueCount: Int) {
        self.init(unsafeResultMap: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap, "issueCount": issueCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
        }
      }

      /// The number of issues that matched the search query.
      public var issueCount: Int {
        get {
          return resultMap["issueCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "issueCount")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization", "MarketplaceListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Issue": AsIssue.selections, "PullRequest": AsPullRequest.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeRepository() -> Node {
          return Node(unsafeResultMap: ["__typename": "Repository"])
        }

        public static func makeUser() -> Node {
          return Node(unsafeResultMap: ["__typename": "User"])
        }

        public static func makeOrganization() -> Node {
          return Node(unsafeResultMap: ["__typename": "Organization"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(unsafeResultMap: ["__typename": "MarketplaceListing"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asIssue: AsIssue? {
          get {
            if !AsIssue.possibleTypes.contains(__typename) { return nil }
            return AsIssue(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsIssue: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepoEventFields.self),
            GraphQLFragmentSpread(NodeFields.self),
            GraphQLFragmentSpread(LabelableFields.self),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", alias: "issueState", type: .nonNull(.scalar(IssueState.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the issue title.
          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          /// Identifies the issue number.
          public var number: Int {
            get {
              return resultMap["number"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the state of the issue.
          public var issueState: IssueState {
            get {
              return resultMap["issueState"]! as! IssueState
            }
            set {
              resultMap.updateValue(newValue, forKey: "issueState")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repoEventFields: RepoEventFields {
              get {
                return RepoEventFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }

        public var asPullRequest: AsPullRequest? {
          get {
            if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
            return AsPullRequest(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsPullRequest: GraphQLSelectionSet {
          public static let possibleTypes = ["PullRequest"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepoEventFields.self),
            GraphQLFragmentSpread(NodeFields.self),
            GraphQLFragmentSpread(LabelableFields.self),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", alias: "pullRequestState", type: .nonNull(.scalar(PullRequestState.self))),
            GraphQLField("commits", arguments: ["last": 1], type: .nonNull(.object(Commit.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the pull request title.
          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          /// Identifies the pull request number.
          public var number: Int {
            get {
              return resultMap["number"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the state of the pull request.
          public var pullRequestState: PullRequestState {
            get {
              return resultMap["pullRequestState"]! as! PullRequestState
            }
            set {
              resultMap.updateValue(newValue, forKey: "pullRequestState")
            }
          }

          /// A list of commits present in this pull request's head branch not present in the base branch.
          public var commits: Commit {
            get {
              return Commit(unsafeResultMap: resultMap["commits"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "commits")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repoEventFields: RepoEventFields {
              get {
                return RepoEventFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct Commit: GraphQLSelectionSet {
            public static let possibleTypes = ["PullRequestCommitConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "PullRequestCommitConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["PullRequestCommit"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("commit", type: .nonNull(.object(Commit.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(commit: Commit) {
                self.init(unsafeResultMap: ["__typename": "PullRequestCommit", "commit": commit.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The Git commit object
              public var commit: Commit {
                get {
                  return Commit(unsafeResultMap: resultMap["commit"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "commit")
                }
              }

              public struct Commit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("status", type: .object(Status.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(status: Status? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Commit", "status": status.flatMap { (value: Status) -> ResultMap in value.resultMap }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Status information for this commit
                public var status: Status? {
                  get {
                    return (resultMap["status"] as? ResultMap).flatMap { Status(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "status")
                  }
                }

                public struct Status: GraphQLSelectionSet {
                  public static let possibleTypes = ["Status"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(state: StatusState) {
                    self.init(unsafeResultMap: ["__typename": "Status", "state": state])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The combined commit status.
                  public var state: StatusState {
                    get {
                      return resultMap["state"]! as! StatusState
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "state")
                    }
                  }
                }
              }
            }
          }
        }
      }

      public struct PageInfo: GraphQLSelectionSet {
        public static let possibleTypes = ["PageInfo"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("endCursor", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(hasNextPage: Bool, endCursor: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "endCursor": endCursor])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool {
          get {
            return resultMap["hasNextPage"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasNextPage")
          }
        }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? {
          get {
            return resultMap["endCursor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "endCursor")
          }
        }
      }
    }
  }
}

public struct ReactionFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment reactionFields on Reactable {\n  __typename\n  viewerCanReact\n  reactionGroups {\n    __typename\n    viewerHasReacted\n    users(first: 3) {\n      __typename\n      nodes {\n        __typename\n        login\n      }\n      totalCount\n    }\n    content\n  }\n}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeIssue(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(unsafeResultMap: ["__typename": "Issue", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [ResultMap] in value.map { (value: ReactionGroup) -> ResultMap in value.resultMap } }])
  }

  public static func makeCommitComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(unsafeResultMap: ["__typename": "CommitComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [ResultMap] in value.map { (value: ReactionGroup) -> ResultMap in value.resultMap } }])
  }

  public static func makePullRequest(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(unsafeResultMap: ["__typename": "PullRequest", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [ResultMap] in value.map { (value: ReactionGroup) -> ResultMap in value.resultMap } }])
  }

  public static func makeIssueComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(unsafeResultMap: ["__typename": "IssueComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [ResultMap] in value.map { (value: ReactionGroup) -> ResultMap in value.resultMap } }])
  }

  public static func makePullRequestReviewComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(unsafeResultMap: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [ResultMap] in value.map { (value: ReactionGroup) -> ResultMap in value.resultMap } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Can user react to this subject
  public var viewerCanReact: Bool {
    get {
      return resultMap["viewerCanReact"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerCanReact")
    }
  }

  /// A list of reactions grouped by content left on the subject.
  public var reactionGroups: [ReactionGroup]? {
    get {
      return (resultMap["reactionGroups"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [ReactionGroup] in value.map { (value: ResultMap) -> ReactionGroup in ReactionGroup(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [ResultMap] in value.map { (value: ReactionGroup) -> ResultMap in value.resultMap } }, forKey: "reactionGroups")
    }
  }

  public struct ReactionGroup: GraphQLSelectionSet {
    public static let possibleTypes = ["ReactionGroup"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.selections))),
      GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
      self.init(unsafeResultMap: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.resultMap, "content": content])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Whether or not the authenticated user has left a reaction on the subject.
    public var viewerHasReacted: Bool {
      get {
        return resultMap["viewerHasReacted"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "viewerHasReacted")
      }
    }

    /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
    public var users: User {
      get {
        return User(unsafeResultMap: resultMap["users"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "users")
      }
    }

    /// Identifies the emoji reaction.
    public var content: ReactionContent {
      get {
        return resultMap["content"]! as! ReactionContent
      }
      set {
        resultMap.updateValue(newValue, forKey: "content")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["ReactingUserConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil, totalCount: Int) {
        self.init(unsafeResultMap: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "totalCount": totalCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      /// Identifies the total count of items in the connection.
      public var totalCount: Int {
        get {
          return resultMap["totalCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "totalCount")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(login: String) {
          self.init(unsafeResultMap: ["__typename": "User", "login": login])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The username used to login.
        public var login: String {
          get {
            return resultMap["login"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "login")
          }
        }
      }
    }
  }
}

public struct CommentFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment commentFields on Comment {\n  __typename\n  author {\n    __typename\n    login\n    avatarUrl\n  }\n  editor {\n    __typename\n    login\n  }\n  lastEditedAt\n  body\n  createdAt\n  viewerDidAuthor\n}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("author", type: .object(Author.selections)),
    GraphQLField("editor", type: .object(Editor.selections)),
    GraphQLField("lastEditedAt", type: .scalar(String.self)),
    GraphQLField("body", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeIssue(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(unsafeResultMap: ["__typename": "Issue", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "editor": editor.flatMap { (value: Editor) -> ResultMap in value.resultMap }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeCommitComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(unsafeResultMap: ["__typename": "CommitComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "editor": editor.flatMap { (value: Editor) -> ResultMap in value.resultMap }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequest(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(unsafeResultMap: ["__typename": "PullRequest", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "editor": editor.flatMap { (value: Editor) -> ResultMap in value.resultMap }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeIssueComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(unsafeResultMap: ["__typename": "IssueComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "editor": editor.flatMap { (value: Editor) -> ResultMap in value.resultMap }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReview(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(unsafeResultMap: ["__typename": "PullRequestReview", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "editor": editor.flatMap { (value: Editor) -> ResultMap in value.resultMap }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReviewComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(unsafeResultMap: ["__typename": "PullRequestReviewComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "editor": editor.flatMap { (value: Editor) -> ResultMap in value.resultMap }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeGistComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(unsafeResultMap: ["__typename": "GistComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "editor": editor.flatMap { (value: Editor) -> ResultMap in value.resultMap }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// The actor who edited the comment.
  public var editor: Editor? {
    get {
      return (resultMap["editor"] as? ResultMap).flatMap { Editor(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "editor")
    }
  }

  /// The moment the editor made the last edit
  public var lastEditedAt: String? {
    get {
      return resultMap["lastEditedAt"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastEditedAt")
    }
  }

  /// The body as Markdown.
  public var body: String {
    get {
      return resultMap["body"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "body")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// Did the viewer author this comment.
  public var viewerDidAuthor: Bool {
    get {
      return resultMap["viewerDidAuthor"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerDidAuthor")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User", "Bot"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeUser(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeBot(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }

    /// A URL pointing to the actor's public avatar.
    public var avatarUrl: String {
      get {
        return resultMap["avatarUrl"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
      }
    }
  }

  public struct Editor: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User", "Bot"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(login: String) -> Editor {
      return Editor(unsafeResultMap: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Editor {
      return Editor(unsafeResultMap: ["__typename": "User", "login": login])
    }

    public static func makeBot(login: String) -> Editor {
      return Editor(unsafeResultMap: ["__typename": "Bot", "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }
}

public struct LockableFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment lockableFields on Lockable {\n  __typename\n  locked\n}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("locked", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeIssue(locked: Bool) -> LockableFields {
    return LockableFields(unsafeResultMap: ["__typename": "Issue", "locked": locked])
  }

  public static func makePullRequest(locked: Bool) -> LockableFields {
    return LockableFields(unsafeResultMap: ["__typename": "PullRequest", "locked": locked])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// `true` if the object is locked
  public var locked: Bool {
    get {
      return resultMap["locked"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "locked")
    }
  }
}

public struct ClosableFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment closableFields on Closable {\n  __typename\n  closed\n}"

  public static let possibleTypes = ["Project", "Issue", "PullRequest", "Milestone"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeProject(closed: Bool) -> ClosableFields {
    return ClosableFields(unsafeResultMap: ["__typename": "Project", "closed": closed])
  }

  public static func makeIssue(closed: Bool) -> ClosableFields {
    return ClosableFields(unsafeResultMap: ["__typename": "Issue", "closed": closed])
  }

  public static func makePullRequest(closed: Bool) -> ClosableFields {
    return ClosableFields(unsafeResultMap: ["__typename": "PullRequest", "closed": closed])
  }

  public static func makeMilestone(closed: Bool) -> ClosableFields {
    return ClosableFields(unsafeResultMap: ["__typename": "Milestone", "closed": closed])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// `true` if the object is closed (definition of closed may depend on type)
  public var closed: Bool {
    get {
      return resultMap["closed"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "closed")
    }
  }
}

public struct LabelableFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment labelableFields on Labelable {\n  __typename\n  labels(first: 30) {\n    __typename\n    nodes {\n      __typename\n      color\n      name\n    }\n  }\n}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("labels", arguments: ["first": 30], type: .object(Label.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeIssue(labels: Label? = nil) -> LabelableFields {
    return LabelableFields(unsafeResultMap: ["__typename": "Issue", "labels": labels.flatMap { (value: Label) -> ResultMap in value.resultMap }])
  }

  public static func makePullRequest(labels: Label? = nil) -> LabelableFields {
    return LabelableFields(unsafeResultMap: ["__typename": "PullRequest", "labels": labels.flatMap { (value: Label) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A list of labels associated with the object.
  public var labels: Label? {
    get {
      return (resultMap["labels"] as? ResultMap).flatMap { Label(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "labels")
    }
  }

  public struct Label: GraphQLSelectionSet {
    public static let possibleTypes = ["LabelConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("nodes", type: .list(.object(Node.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(nodes: [Node?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A list of nodes.
    public var nodes: [Node?]? {
      get {
        return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes = ["Label"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("color", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(color: String, name: String) {
        self.init(unsafeResultMap: ["__typename": "Label", "color": color, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Identifies the label color.
      public var color: String {
        get {
          return resultMap["color"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "color")
        }
      }

      /// Identifies the label name.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

public struct UpdatableFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment updatableFields on Updatable {\n  __typename\n  viewerCanUpdate\n}"

  public static let possibleTypes = ["Project", "Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeProject(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "Project", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeIssue(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "Issue", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeCommitComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "CommitComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makePullRequest(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "PullRequest", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeIssueComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "IssueComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makePullRequestReview(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "PullRequestReview", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makePullRequestReviewComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "PullRequestReviewComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeGistComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(unsafeResultMap: ["__typename": "GistComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Check if the current viewer can update this object.
  public var viewerCanUpdate: Bool {
    get {
      return resultMap["viewerCanUpdate"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerCanUpdate")
    }
  }
}

public struct DeletableFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment deletableFields on Deletable {\n  __typename\n  viewerCanDelete\n}"

  public static let possibleTypes = ["CommitComment", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerCanDelete", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeCommitComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(unsafeResultMap: ["__typename": "CommitComment", "viewerCanDelete": viewerCanDelete])
  }

  public static func makeIssueComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(unsafeResultMap: ["__typename": "IssueComment", "viewerCanDelete": viewerCanDelete])
  }

  public static func makePullRequestReview(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(unsafeResultMap: ["__typename": "PullRequestReview", "viewerCanDelete": viewerCanDelete])
  }

  public static func makePullRequestReviewComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(unsafeResultMap: ["__typename": "PullRequestReviewComment", "viewerCanDelete": viewerCanDelete])
  }

  public static func makeGistComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(unsafeResultMap: ["__typename": "GistComment", "viewerCanDelete": viewerCanDelete])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Check if the current viewer can delete this object.
  public var viewerCanDelete: Bool {
    get {
      return resultMap["viewerCanDelete"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerCanDelete")
    }
  }
}

public struct NodeFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment nodeFields on Node {\n  __typename\n  id\n}"

  public static let possibleTypes = ["License", "MarketplaceCategory", "MarketplaceListing", "Organization", "Project", "ProjectColumn", "ProjectCard", "Issue", "User", "Repository", "CommitComment", "UserContentEdit", "Reaction", "Commit", "Status", "StatusContext", "Tree", "Ref", "PullRequest", "Label", "IssueComment", "PullRequestCommit", "Milestone", "ReviewRequest", "Team", "OrganizationInvitation", "PullRequestReview", "PullRequestReviewComment", "CommitCommentThread", "PullRequestReviewThread", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "MergedEvent", "ReferencedEvent", "CrossReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent", "DeployedEvent", "Deployment", "DeploymentStatus", "HeadRefDeletedEvent", "HeadRefRestoredEvent", "HeadRefForcePushedEvent", "BaseRefForcePushedEvent", "ReviewRequestedEvent", "ReviewRequestRemovedEvent", "ReviewDismissedEvent", "DeployKey", "Language", "ProtectedBranch", "PushAllowance", "ReviewDismissalAllowance", "Release", "ReleaseAsset", "RepositoryTopic", "Topic", "Gist", "GistComment", "PublicKey", "OrganizationIdentityProvider", "ExternalIdentity", "Bot", "RepositoryInvitation", "Blob", "BaseRefChangedEvent", "AddedToProjectEvent", "CommentDeletedEvent", "ConvertedNoteToIssueEvent", "MentionedEvent", "MovedColumnsInProjectEvent", "RemovedFromProjectEvent", "Tag"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeLicense(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "License", "id": id])
  }

  public static func makeMarketplaceCategory(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "MarketplaceCategory", "id": id])
  }

  public static func makeMarketplaceListing(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "MarketplaceListing", "id": id])
  }

  public static func makeOrganization(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Organization", "id": id])
  }

  public static func makeProject(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Project", "id": id])
  }

  public static func makeProjectColumn(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ProjectColumn", "id": id])
  }

  public static func makeProjectCard(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ProjectCard", "id": id])
  }

  public static func makeIssue(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Issue", "id": id])
  }

  public static func makeUser(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "User", "id": id])
  }

  public static func makeRepository(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Repository", "id": id])
  }

  public static func makeCommitComment(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "CommitComment", "id": id])
  }

  public static func makeUserContentEdit(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "UserContentEdit", "id": id])
  }

  public static func makeReaction(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Reaction", "id": id])
  }

  public static func makeCommit(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Commit", "id": id])
  }

  public static func makeStatus(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Status", "id": id])
  }

  public static func makeStatusContext(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "StatusContext", "id": id])
  }

  public static func makeTree(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Tree", "id": id])
  }

  public static func makeRef(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Ref", "id": id])
  }

  public static func makePullRequest(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "PullRequest", "id": id])
  }

  public static func makeLabel(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Label", "id": id])
  }

  public static func makeIssueComment(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "IssueComment", "id": id])
  }

  public static func makePullRequestCommit(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "PullRequestCommit", "id": id])
  }

  public static func makeMilestone(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Milestone", "id": id])
  }

  public static func makeReviewRequest(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReviewRequest", "id": id])
  }

  public static func makeTeam(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Team", "id": id])
  }

  public static func makeOrganizationInvitation(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "OrganizationInvitation", "id": id])
  }

  public static func makePullRequestReview(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "PullRequestReview", "id": id])
  }

  public static func makePullRequestReviewComment(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "PullRequestReviewComment", "id": id])
  }

  public static func makeCommitCommentThread(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "CommitCommentThread", "id": id])
  }

  public static func makePullRequestReviewThread(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "PullRequestReviewThread", "id": id])
  }

  public static func makeClosedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ClosedEvent", "id": id])
  }

  public static func makeReopenedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReopenedEvent", "id": id])
  }

  public static func makeSubscribedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "SubscribedEvent", "id": id])
  }

  public static func makeUnsubscribedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "UnsubscribedEvent", "id": id])
  }

  public static func makeMergedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "MergedEvent", "id": id])
  }

  public static func makeReferencedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReferencedEvent", "id": id])
  }

  public static func makeCrossReferencedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "CrossReferencedEvent", "id": id])
  }

  public static func makeAssignedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "AssignedEvent", "id": id])
  }

  public static func makeUnassignedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "UnassignedEvent", "id": id])
  }

  public static func makeLabeledEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "LabeledEvent", "id": id])
  }

  public static func makeUnlabeledEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "UnlabeledEvent", "id": id])
  }

  public static func makeMilestonedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "MilestonedEvent", "id": id])
  }

  public static func makeDemilestonedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "DemilestonedEvent", "id": id])
  }

  public static func makeRenamedTitleEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "RenamedTitleEvent", "id": id])
  }

  public static func makeLockedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "LockedEvent", "id": id])
  }

  public static func makeUnlockedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "UnlockedEvent", "id": id])
  }

  public static func makeDeployedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "DeployedEvent", "id": id])
  }

  public static func makeDeployment(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Deployment", "id": id])
  }

  public static func makeDeploymentStatus(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "DeploymentStatus", "id": id])
  }

  public static func makeHeadRefDeletedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "HeadRefDeletedEvent", "id": id])
  }

  public static func makeHeadRefRestoredEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "HeadRefRestoredEvent", "id": id])
  }

  public static func makeHeadRefForcePushedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "HeadRefForcePushedEvent", "id": id])
  }

  public static func makeBaseRefForcePushedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "BaseRefForcePushedEvent", "id": id])
  }

  public static func makeReviewRequestedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReviewRequestedEvent", "id": id])
  }

  public static func makeReviewRequestRemovedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReviewRequestRemovedEvent", "id": id])
  }

  public static func makeReviewDismissedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReviewDismissedEvent", "id": id])
  }

  public static func makeDeployKey(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "DeployKey", "id": id])
  }

  public static func makeLanguage(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Language", "id": id])
  }

  public static func makeProtectedBranch(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ProtectedBranch", "id": id])
  }

  public static func makePushAllowance(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "PushAllowance", "id": id])
  }

  public static func makeReviewDismissalAllowance(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReviewDismissalAllowance", "id": id])
  }

  public static func makeRelease(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Release", "id": id])
  }

  public static func makeReleaseAsset(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ReleaseAsset", "id": id])
  }

  public static func makeRepositoryTopic(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "RepositoryTopic", "id": id])
  }

  public static func makeTopic(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Topic", "id": id])
  }

  public static func makeGist(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Gist", "id": id])
  }

  public static func makeGistComment(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "GistComment", "id": id])
  }

  public static func makePublicKey(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "PublicKey", "id": id])
  }

  public static func makeOrganizationIdentityProvider(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "OrganizationIdentityProvider", "id": id])
  }

  public static func makeExternalIdentity(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ExternalIdentity", "id": id])
  }

  public static func makeBot(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Bot", "id": id])
  }

  public static func makeRepositoryInvitation(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "RepositoryInvitation", "id": id])
  }

  public static func makeBlob(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Blob", "id": id])
  }

  public static func makeBaseRefChangedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "BaseRefChangedEvent", "id": id])
  }

  public static func makeAddedToProjectEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "AddedToProjectEvent", "id": id])
  }

  public static func makeCommentDeletedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "CommentDeletedEvent", "id": id])
  }

  public static func makeConvertedNoteToIssueEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "ConvertedNoteToIssueEvent", "id": id])
  }

  public static func makeMentionedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "MentionedEvent", "id": id])
  }

  public static func makeMovedColumnsInProjectEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "MovedColumnsInProjectEvent", "id": id])
  }

  public static func makeRemovedFromProjectEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "RemovedFromProjectEvent", "id": id])
  }

  public static func makeTag(id: GraphQLID) -> NodeFields {
    return NodeFields(unsafeResultMap: ["__typename": "Tag", "id": id])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// ID of the object.
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct ReferencedRepositoryFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment referencedRepositoryFields on RepositoryInfo {\n  __typename\n  name\n  owner {\n    __typename\n    login\n  }\n}"

  public static let possibleTypes = ["Repository"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(name: String, owner: Owner) {
    self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "owner": owner.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The name of the repository.
  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// The User owner of the repository.
  public var owner: Owner {
    get {
      return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "owner")
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "User", "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username used to login.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }
}

public struct AssigneeFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment assigneeFields on Assignable {\n  __typename\n  assignees(first: $page_size) {\n    __typename\n    nodes {\n      __typename\n      login\n      avatarUrl\n    }\n  }\n}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("assignees", arguments: ["first": GraphQLVariable("page_size")], type: .nonNull(.object(Assignee.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeIssue(assignees: Assignee) -> AssigneeFields {
    return AssigneeFields(unsafeResultMap: ["__typename": "Issue", "assignees": assignees.resultMap])
  }

  public static func makePullRequest(assignees: Assignee) -> AssigneeFields {
    return AssigneeFields(unsafeResultMap: ["__typename": "PullRequest", "assignees": assignees.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A list of Users assigned to this object.
  public var assignees: Assignee {
    get {
      return Assignee(unsafeResultMap: resultMap["assignees"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "assignees")
    }
  }

  public struct Assignee: GraphQLSelectionSet {
    public static let possibleTypes = ["UserConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("nodes", type: .list(.object(Node.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(nodes: [Node?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "UserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A list of nodes.
    public var nodes: [Node?]? {
      get {
        return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("login", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(login: String, avatarUrl: String) {
        self.init(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return resultMap["avatarUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}

public struct HeadPaging: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment headPaging on PageInfo {\n  __typename\n  hasPreviousPage\n  startCursor\n}"

  public static let possibleTypes = ["PageInfo"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("startCursor", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(hasPreviousPage: Bool, startCursor: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "PageInfo", "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// When paginating backwards, are there more items?
  public var hasPreviousPage: Bool {
    get {
      return resultMap["hasPreviousPage"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "hasPreviousPage")
    }
  }

  /// When paginating backwards, the cursor to continue.
  public var startCursor: String? {
    get {
      return resultMap["startCursor"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "startCursor")
    }
  }
}

public struct MilestoneFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment milestoneFields on Milestone {\n  __typename\n  number\n  title\n  url\n  dueOn\n  openCount: issues(states: [OPEN]) {\n    __typename\n    totalCount\n  }\n  totalCount: issues {\n    __typename\n    totalCount\n  }\n}"

  public static let possibleTypes = ["Milestone"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("number", type: .nonNull(.scalar(Int.self))),
    GraphQLField("title", type: .nonNull(.scalar(String.self))),
    GraphQLField("url", type: .nonNull(.scalar(String.self))),
    GraphQLField("dueOn", type: .scalar(String.self)),
    GraphQLField("issues", alias: "openCount", arguments: ["states": ["OPEN"]], type: .nonNull(.object(OpenCount.selections))),
    GraphQLField("issues", alias: "totalCount", type: .nonNull(.object(TotalCount.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(number: Int, title: String, url: String, dueOn: String? = nil, openCount: OpenCount, totalCount: TotalCount) {
    self.init(unsafeResultMap: ["__typename": "Milestone", "number": number, "title": title, "url": url, "dueOn": dueOn, "openCount": openCount.resultMap, "totalCount": totalCount.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Identifies the number of the milestone.
  public var number: Int {
    get {
      return resultMap["number"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "number")
    }
  }

  /// Identifies the title of the milestone.
  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  /// The HTTP URL for this milestone
  public var url: String {
    get {
      return resultMap["url"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "url")
    }
  }

  /// Identifies the due date of the milestone.
  public var dueOn: String? {
    get {
      return resultMap["dueOn"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "dueOn")
    }
  }

  /// A list of issues associated with the milestone.
  public var openCount: OpenCount {
    get {
      return OpenCount(unsafeResultMap: resultMap["openCount"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "openCount")
    }
  }

  /// A list of issues associated with the milestone.
  public var totalCount: TotalCount {
    get {
      return TotalCount(unsafeResultMap: resultMap["totalCount"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "totalCount")
    }
  }

  public struct OpenCount: GraphQLSelectionSet {
    public static let possibleTypes = ["IssueConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "IssueConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct TotalCount: GraphQLSelectionSet {
    public static let possibleTypes = ["IssueConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "IssueConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }
}

public struct RepoEventFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment repoEventFields on Comment {\n  __typename\n  createdAt\n  author {\n    __typename\n    login\n  }\n}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("author", type: .object(Author.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeIssue(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(unsafeResultMap: ["__typename": "Issue", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
  }

  public static func makeCommitComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(unsafeResultMap: ["__typename": "CommitComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
  }

  public static func makePullRequest(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(unsafeResultMap: ["__typename": "PullRequest", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
  }

  public static func makeIssueComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(unsafeResultMap: ["__typename": "IssueComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
  }

  public static func makePullRequestReview(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(unsafeResultMap: ["__typename": "PullRequestReview", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
  }

  public static func makePullRequestReviewComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(unsafeResultMap: ["__typename": "PullRequestReviewComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
  }

  public static func makeGistComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(unsafeResultMap: ["__typename": "GistComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User", "Bot"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "login": login])
    }

    public static func makeBot(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }
}

public struct CommitContext: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment commitContext on Commit {\n  __typename\n  id\n  status {\n    __typename\n    contexts {\n      __typename\n      id\n      context\n      state\n      creator {\n        __typename\n        login\n        avatarUrl\n      }\n      description\n      targetUrl\n    }\n    state\n  }\n}"

  public static let possibleTypes = ["Commit"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("status", type: .object(Status.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, status: Status? = nil) {
    self.init(unsafeResultMap: ["__typename": "Commit", "id": id, "status": status.flatMap { (value: Status) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// Status information for this commit
  public var status: Status? {
    get {
      return (resultMap["status"] as? ResultMap).flatMap { Status(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "status")
    }
  }

  public struct Status: GraphQLSelectionSet {
    public static let possibleTypes = ["Status"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("contexts", type: .nonNull(.list(.nonNull(.object(Context.selections))))),
      GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(contexts: [Context], state: StatusState) {
      self.init(unsafeResultMap: ["__typename": "Status", "contexts": contexts.map { (value: Context) -> ResultMap in value.resultMap }, "state": state])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The individual status contexts for this commit.
    public var contexts: [Context] {
      get {
        return (resultMap["contexts"] as! [ResultMap]).map { (value: ResultMap) -> Context in Context(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Context) -> ResultMap in value.resultMap }, forKey: "contexts")
      }
    }

    /// The combined commit status.
    public var state: StatusState {
      get {
        return resultMap["state"]! as! StatusState
      }
      set {
        resultMap.updateValue(newValue, forKey: "state")
      }
    }

    public struct Context: GraphQLSelectionSet {
      public static let possibleTypes = ["StatusContext"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("context", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
        GraphQLField("creator", type: .object(Creator.selections)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("targetUrl", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, context: String, state: StatusState, creator: Creator? = nil, description: String? = nil, targetUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "StatusContext", "id": id, "context": context, "state": state, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "description": description, "targetUrl": targetUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The name of this status context.
      public var context: String {
        get {
          return resultMap["context"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "context")
        }
      }

      /// The state of this status context.
      public var state: StatusState {
        get {
          return resultMap["state"]! as! StatusState
        }
        set {
          resultMap.updateValue(newValue, forKey: "state")
        }
      }

      /// The actor who created this status context.
      public var creator: Creator? {
        get {
          return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "creator")
        }
      }

      /// The description for this status context.
      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// The URL for this status context.
      public var targetUrl: String? {
        get {
          return resultMap["targetUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "targetUrl")
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes = ["Organization", "User", "Bot"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeOrganization(login: String, avatarUrl: String) -> Creator {
          return Creator(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
        }

        public static func makeUser(login: String, avatarUrl: String) -> Creator {
          return Creator(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
        }

        public static func makeBot(login: String, avatarUrl: String) -> Creator {
          return Creator(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The username of the actor.
        public var login: String {
          get {
            return resultMap["login"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "login")
          }
        }

        /// A URL pointing to the actor's public avatar.
        public var avatarUrl: String {
          get {
            return resultMap["avatarUrl"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatarUrl")
          }
        }
      }
    }
  }
}