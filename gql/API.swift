//  This file was automatically generated and should not be edited.

import Apollo

/// Emojis that can be attached to Issues, Pull Requests and Comments.
public enum ReactionContent: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// The possible commit status states.
public enum StatusState: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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

/// The possible states of a pull request review.
public enum PullRequestReviewState: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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
public enum MergeableState: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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
public enum MergeStateStatus: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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

/// The possible states of an issue.
public enum IssueState: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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
public enum PullRequestState: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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

public final class AddCommentMutation: GraphQLMutation {
  public static let operationString =
    "mutation AddComment($subject_id: ID!, $body: String!) {\n  addComment(input: {subjectId: $subject_id, body: $body}) {\n    __typename\n    commentEdge {\n      __typename\n      node {\n        __typename\n        ...nodeFields\n        ...reactionFields\n        ...commentFields\n        ...updatableFields\n        ...deletableFields\n      }\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(NodeFields.fragmentString).appending(ReactionFields.fragmentString).appending(CommentFields.fragmentString).appending(UpdatableFields.fragmentString).appending(DeletableFields.fragmentString) }

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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addComment: AddComment? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "addComment": addComment.flatMap { (value: AddComment) -> Snapshot in value.snapshot }])
    }

    /// Adds a comment to an Issue or Pull Request.
    public var addComment: AddComment? {
      get {
        return (snapshot["addComment"] as? Snapshot).flatMap { AddComment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "addComment")
      }
    }

    public struct AddComment: GraphQLSelectionSet {
      public static let possibleTypes = ["AddCommentPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("commentEdge", type: .nonNull(.object(CommentEdge.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(commentEdge: CommentEdge) {
        self.init(snapshot: ["__typename": "AddCommentPayload", "commentEdge": commentEdge.snapshot])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The edge from the subject's comment connection.
      public var commentEdge: CommentEdge {
        get {
          return CommentEdge(snapshot: snapshot["commentEdge"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "commentEdge")
        }
      }

      public struct CommentEdge: GraphQLSelectionSet {
        public static let possibleTypes = ["IssueCommentEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(node: Node? = nil) {
          self.init(snapshot: ["__typename": "IssueCommentEdge", "node": node.flatMap { (value: Node) -> Snapshot in value.snapshot }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (snapshot["node"] as? Snapshot).flatMap { Node(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["IssueComment"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("author", type: .object(Author.selections)),
            GraphQLField("editor", type: .object(Editor.selections)),
            GraphQLField("lastEditedAt", type: .scalar(String.self)),
            GraphQLField("body", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerCanDelete", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool, viewerCanDelete: Bool) {
            self.init(snapshot: ["__typename": "IssueComment", "id": id, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate, "viewerCanDelete": viewerCanDelete])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// ID of the object.
          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// Can user react to this subject
          public var viewerCanReact: Bool {
            get {
              return snapshot["viewerCanReact"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerCanReact")
            }
          }

          /// A list of reactions grouped by content left on the subject.
          public var reactionGroups: [ReactionGroup]? {
            get {
              return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
            }
            set {
              snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// The actor who edited the comment.
          public var editor: Editor? {
            get {
              return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "editor")
            }
          }

          /// The moment the editor made the last edit
          public var lastEditedAt: String? {
            get {
              return snapshot["lastEditedAt"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "lastEditedAt")
            }
          }

          /// The body as Markdown.
          public var body: String {
            get {
              return snapshot["body"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "body")
            }
          }

          /// Identifies the date and time when the object was created.
          public var createdAt: String {
            get {
              return snapshot["createdAt"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "createdAt")
            }
          }

          /// Did the viewer author this comment.
          public var viewerDidAuthor: Bool {
            get {
              return snapshot["viewerDidAuthor"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
            }
          }

          /// Check if the current viewer can update this object.
          public var viewerCanUpdate: Bool {
            get {
              return snapshot["viewerCanUpdate"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerCanUpdate")
            }
          }

          /// Check if the current viewer can delete this object.
          public var viewerCanDelete: Bool {
            get {
              return snapshot["viewerCanDelete"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerCanDelete")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var deletableFields: DeletableFields {
              get {
                return DeletableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
              self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Whether or not the authenticated user has left a reaction on the subject.
            public var viewerHasReacted: Bool {
              get {
                return snapshot["viewerHasReacted"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerHasReacted")
              }
            }

            /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
            public var users: User {
              get {
                return User(snapshot: snapshot["users"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "users")
              }
            }

            /// Identifies the emoji reaction.
            public var content: ReactionContent {
              get {
                return snapshot["content"]! as! ReactionContent
              }
              set {
                snapshot.updateValue(newValue, forKey: "content")
              }
            }

            public struct User: GraphQLSelectionSet {
              public static let possibleTypes = ["ReactingUserConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(nodes: [Node?]? = nil, totalCount: Int) {
                self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of nodes.
              public var nodes: [Node?]? {
                get {
                  return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
                }
                set {
                  snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("login", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(login: String) {
                  self.init(snapshot: ["__typename": "User", "login": login])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The username used to login.
                public var login: String {
                  get {
                    return snapshot["login"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "login")
                  }
                }
              }
            }
          }

          public struct Author: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
              GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
            }

            public static func makeUser(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
            }

            public static func makeBot(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }

            /// A URL pointing to the actor's public avatar.
            public var avatarUrl: String {
              get {
                return snapshot["avatarUrl"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }
          }

          public struct Editor: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "User", "login": login])
            }

            public static func makeBot(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "Bot", "login": login])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }
          }
        }
      }
    }
  }
}

public final class AddReactionMutation: GraphQLMutation {
  public static let operationString =
    "mutation AddReaction($subject_id: ID!, $content: ReactionContent!) {\n  addReaction(input: {subjectId: $subject_id, content: $content}) {\n    __typename\n    subject {\n      __typename\n      ...reactionFields\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(ReactionFields.fragmentString) }

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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addReaction: AddReaction? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "addReaction": addReaction.flatMap { (value: AddReaction) -> Snapshot in value.snapshot }])
    }

    /// Adds a reaction to a subject.
    public var addReaction: AddReaction? {
      get {
        return (snapshot["addReaction"] as? Snapshot).flatMap { AddReaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "addReaction")
      }
    }

    public struct AddReaction: GraphQLSelectionSet {
      public static let possibleTypes = ["AddReactionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(subject: Subject) {
        self.init(snapshot: ["__typename": "AddReactionPayload", "subject": subject.snapshot])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The reactable subject.
      public var subject: Subject {
        get {
          return Subject(snapshot: snapshot["subject"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "subject")
        }
      }

      public struct Subject: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "Issue", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makeCommitComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "CommitComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makePullRequest(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequest", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makeIssueComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "IssueComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makePullRequestReviewComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Can user react to this subject
        public var viewerCanReact: Bool {
          get {
            return snapshot["viewerCanReact"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "viewerCanReact")
          }
        }

        /// A list of reactions grouped by content left on the subject.
        public var reactionGroups: [ReactionGroup]? {
          get {
            return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var reactionFields: ReactionFields {
            get {
              return ReactionFields(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
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

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
            self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Whether or not the authenticated user has left a reaction on the subject.
          public var viewerHasReacted: Bool {
            get {
              return snapshot["viewerHasReacted"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerHasReacted")
            }
          }

          /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
          public var users: User {
            get {
              return User(snapshot: snapshot["users"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "users")
            }
          }

          /// Identifies the emoji reaction.
          public var content: ReactionContent {
            get {
              return snapshot["content"]! as! ReactionContent
            }
            set {
              snapshot.updateValue(newValue, forKey: "content")
            }
          }

          public struct User: GraphQLSelectionSet {
            public static let possibleTypes = ["ReactingUserConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
              GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil, totalCount: Int) {
              self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return snapshot["totalCount"]! as! Int
              }
              set {
                snapshot.updateValue(newValue, forKey: "totalCount")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["User"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("login", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(login: String) {
                self.init(snapshot: ["__typename": "User", "login": login])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The username used to login.
              public var login: String {
                get {
                  return snapshot["login"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "login")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class IssueAutocompleteQuery: GraphQLQuery {
  public static let operationString =
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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search.snapshot])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(snapshot: snapshot["search"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(nodes: [Node?]? = nil) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeRepository() -> Node {
          return Node(snapshot: ["__typename": "Repository"])
        }

        public static func makeUser() -> Node {
          return Node(snapshot: ["__typename": "User"])
        }

        public static func makeOrganization() -> Node {
          return Node(snapshot: ["__typename": "Organization"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(snapshot: ["__typename": "MarketplaceListing"])
        }

        public static func makeIssue(number: Int, title: String) -> Node {
          return Node(snapshot: ["__typename": "Issue", "number": number, "title": title])
        }

        public static func makePullRequest(number: Int, title: String) -> Node {
          return Node(snapshot: ["__typename": "PullRequest", "number": number, "title": title])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asIssue: AsIssue? {
          get {
            if !AsIssue.possibleTypes.contains(__typename) { return nil }
            return AsIssue(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsIssue: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(number: Int, title: String) {
            self.init(snapshot: ["__typename": "Issue", "number": number, "title": title])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the issue number.
          public var number: Int {
            get {
              return snapshot["number"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the issue title.
          public var title: String {
            get {
              return snapshot["title"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }
        }

        public var asPullRequest: AsPullRequest? {
          get {
            if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
            return AsPullRequest(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsPullRequest: GraphQLSelectionSet {
          public static let possibleTypes = ["PullRequest"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(number: Int, title: String) {
            self.init(snapshot: ["__typename": "PullRequest", "number": number, "title": title])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the pull request number.
          public var number: Int {
            get {
              return snapshot["number"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the pull request title.
          public var title: String {
            get {
              return snapshot["title"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }
        }
      }
    }
  }
}

public final class IssueOrPullRequestQuery: GraphQLQuery {
  public static let operationString =
    "query IssueOrPullRequest($owner: String!, $repo: String!, $number: Int!, $page_size: Int!, $before: String) {\n  repository(owner: $owner, name: $repo) {\n    __typename\n    name\n    hasIssuesEnabled\n    viewerCanAdminister\n    mergeCommitAllowed\n    rebaseMergeAllowed\n    squashMergeAllowed\n    mentionableUsers(first: 50) {\n      __typename\n      nodes {\n        __typename\n        avatarUrl\n        login\n      }\n    }\n    defaultBranchRef {\n      __typename\n      name\n    }\n    issueOrPullRequest(number: $number) {\n      __typename\n      ... on Issue {\n        timeline(last: $page_size, before: $before) {\n          __typename\n          pageInfo {\n            __typename\n            ...headPaging\n          }\n          nodes {\n            __typename\n            ... on Commit {\n              ...nodeFields\n              author {\n                __typename\n                user {\n                  __typename\n                  login\n                  avatarUrl\n                }\n              }\n              oid\n              messageHeadline\n            }\n            ... on IssueComment {\n              ...nodeFields\n              ...reactionFields\n              ...commentFields\n              ...updatableFields\n              ...deletableFields\n            }\n            ... on LabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on UnlabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on ClosedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              closer {\n                __typename\n                ... on Commit {\n                  oid\n                }\n                ... on PullRequest {\n                  mergeCommit {\n                    __typename\n                    oid\n                  }\n                }\n              }\n            }\n            ... on ReopenedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              currentTitle\n            }\n            ... on LockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on UnlockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on CrossReferencedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              source {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n              }\n            }\n            ... on ReferencedEvent {\n              createdAt\n              ...nodeFields\n              refCommit: commit {\n                __typename\n                oid\n              }\n              actor {\n                __typename\n                login\n              }\n              commitRepository {\n                __typename\n                ...referencedRepositoryFields\n              }\n              subject {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                }\n              }\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              createdAt\n              currentTitle\n              previousTitle\n              actor {\n                __typename\n                login\n              }\n            }\n            ... on AssignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on UnassignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on MilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n            ... on DemilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n          }\n        }\n        milestone {\n          __typename\n          ...milestoneFields\n        }\n        ...reactionFields\n        ...commentFields\n        ...lockableFields\n        ...closableFields\n        ...labelableFields\n        ...updatableFields\n        ...nodeFields\n        ...assigneeFields\n        number\n        title\n      }\n      ... on PullRequest {\n        timeline(last: $page_size, before: $before) {\n          __typename\n          pageInfo {\n            __typename\n            ...headPaging\n          }\n          nodes {\n            __typename\n            ... on Commit {\n              ...nodeFields\n              author {\n                __typename\n                user {\n                  __typename\n                  login\n                  avatarUrl\n                }\n              }\n              oid\n              messageHeadline\n            }\n            ... on IssueComment {\n              ...nodeFields\n              ...reactionFields\n              ...commentFields\n              ...updatableFields\n              ...deletableFields\n            }\n            ... on LabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on UnlabeledEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              label {\n                __typename\n                color\n                name\n              }\n              createdAt\n            }\n            ... on ClosedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              closer {\n                __typename\n                ... on Commit {\n                  oid\n                }\n                ... on PullRequest {\n                  mergeCommit {\n                    __typename\n                    oid\n                  }\n                }\n              }\n            }\n            ... on ReopenedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              currentTitle\n            }\n            ... on LockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on UnlockedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on MergedEvent {\n              ...nodeFields\n              mergedCommit: commit {\n                __typename\n                oid\n              }\n              actor {\n                __typename\n                login\n              }\n              createdAt\n            }\n            ... on PullRequestReviewThread {\n              comments(first: $page_size) {\n                __typename\n                nodes {\n                  __typename\n                  ...reactionFields\n                  ...nodeFields\n                  ...commentFields\n                  path\n                  diffHunk\n                }\n              }\n            }\n            ... on PullRequestReview {\n              ...nodeFields\n              ...commentFields\n              state\n              submittedAt\n              author {\n                __typename\n                login\n              }\n              comments {\n                __typename\n                totalCount\n              }\n            }\n            ... on CrossReferencedEvent {\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              createdAt\n              source {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                  repository {\n                    __typename\n                    name\n                    owner {\n                      __typename\n                      login\n                    }\n                  }\n                }\n              }\n            }\n            ... on ReferencedEvent {\n              createdAt\n              ...nodeFields\n              actor {\n                __typename\n                login\n              }\n              commitRepository {\n                __typename\n                ...referencedRepositoryFields\n              }\n              subject {\n                __typename\n                ... on Issue {\n                  title\n                  number\n                  closed\n                }\n                ... on PullRequest {\n                  title\n                  number\n                  closed\n                  merged\n                }\n              }\n            }\n            ... on RenamedTitleEvent {\n              ...nodeFields\n              createdAt\n              currentTitle\n              previousTitle\n              actor {\n                __typename\n                login\n              }\n            }\n            ... on AssignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on UnassignedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              user {\n                __typename\n                login\n              }\n            }\n            ... on ReviewRequestedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              requestedReviewer {\n                __typename\n                ... on Actor {\n                  login\n                }\n              }\n            }\n            ... on ReviewRequestRemovedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              requestedReviewer {\n                __typename\n                ... on Actor {\n                  login\n                }\n              }\n            }\n            ... on MilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n            ... on DemilestonedEvent {\n              ...nodeFields\n              createdAt\n              actor {\n                __typename\n                login\n              }\n              milestoneTitle\n            }\n          }\n        }\n        reviewRequests(first: $page_size) {\n          __typename\n          nodes {\n            __typename\n            requestedReviewer {\n              __typename\n              ... on Actor {\n                login\n                avatarUrl\n              }\n            }\n          }\n        }\n        commits(last: 1) {\n          __typename\n          nodes {\n            __typename\n            commit {\n              __typename\n              ...commitContext\n            }\n          }\n        }\n        milestone {\n          __typename\n          ...milestoneFields\n        }\n        ...reactionFields\n        ...commentFields\n        ...lockableFields\n        ...closableFields\n        ...labelableFields\n        ...updatableFields\n        ...nodeFields\n        ...assigneeFields\n        number\n        title\n        merged\n        baseRefName\n        changedFiles\n        additions\n        deletions\n        mergeable\n        mergeStateStatus\n      }\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(HeadPaging.fragmentString).appending(NodeFields.fragmentString).appending(ReactionFields.fragmentString).appending(CommentFields.fragmentString).appending(UpdatableFields.fragmentString).appending(DeletableFields.fragmentString).appending(ReferencedRepositoryFields.fragmentString).appending(MilestoneFields.fragmentString).appending(LockableFields.fragmentString).appending(ClosableFields.fragmentString).appending(LabelableFields.fragmentString).appending(AssigneeFields.fragmentString).appending(CommitContext.fragmentString) }

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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> Snapshot in value.snapshot }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"] as? Snapshot).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
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

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(name: String, hasIssuesEnabled: Bool, viewerCanAdminister: Bool, mergeCommitAllowed: Bool, rebaseMergeAllowed: Bool, squashMergeAllowed: Bool, mentionableUsers: MentionableUser, defaultBranchRef: DefaultBranchRef? = nil, issueOrPullRequest: IssueOrPullRequest? = nil) {
        self.init(snapshot: ["__typename": "Repository", "name": name, "hasIssuesEnabled": hasIssuesEnabled, "viewerCanAdminister": viewerCanAdminister, "mergeCommitAllowed": mergeCommitAllowed, "rebaseMergeAllowed": rebaseMergeAllowed, "squashMergeAllowed": squashMergeAllowed, "mentionableUsers": mentionableUsers.snapshot, "defaultBranchRef": defaultBranchRef.flatMap { (value: DefaultBranchRef) -> Snapshot in value.snapshot }, "issueOrPullRequest": issueOrPullRequest.flatMap { (value: IssueOrPullRequest) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The name of the repository.
      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      /// Indicates if the repository has issues feature enabled.
      public var hasIssuesEnabled: Bool {
        get {
          return snapshot["hasIssuesEnabled"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "hasIssuesEnabled")
        }
      }

      /// Indicates whether the viewer has admin permissions on this repository.
      public var viewerCanAdminister: Bool {
        get {
          return snapshot["viewerCanAdminister"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "viewerCanAdminister")
        }
      }

      /// Whether or not PRs are merged with a merge commit on this repository.
      public var mergeCommitAllowed: Bool {
        get {
          return snapshot["mergeCommitAllowed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "mergeCommitAllowed")
        }
      }

      /// Whether or not rebase-merging is enabled on this repository.
      public var rebaseMergeAllowed: Bool {
        get {
          return snapshot["rebaseMergeAllowed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "rebaseMergeAllowed")
        }
      }

      /// Whether or not squash-merging is enabled on this repository.
      public var squashMergeAllowed: Bool {
        get {
          return snapshot["squashMergeAllowed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "squashMergeAllowed")
        }
      }

      /// A list of Users that can be mentioned in the context of the repository.
      public var mentionableUsers: MentionableUser {
        get {
          return MentionableUser(snapshot: snapshot["mentionableUsers"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "mentionableUsers")
        }
      }

      /// The Ref associated with the repository's default branch.
      public var defaultBranchRef: DefaultBranchRef? {
        get {
          return (snapshot["defaultBranchRef"] as? Snapshot).flatMap { DefaultBranchRef(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "defaultBranchRef")
        }
      }

      /// Returns a single issue-like object from the current repository by number.
      public var issueOrPullRequest: IssueOrPullRequest? {
        get {
          return (snapshot["issueOrPullRequest"] as? Snapshot).flatMap { IssueOrPullRequest(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "issueOrPullRequest")
        }
      }

      public struct MentionableUser: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil) {
          self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
            GraphQLField("login", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(avatarUrl: String, login: String) {
            self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A URL pointing to the user's public avatar.
          public var avatarUrl: String {
            get {
              return snapshot["avatarUrl"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "avatarUrl")
            }
          }

          /// The username used to login.
          public var login: String {
            get {
              return snapshot["login"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "login")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String) {
          self.init(snapshot: ["__typename": "Ref", "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The ref name.
        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue(timeline: AsIssue.Timeline, milestone: AsIssue.Milestone? = nil, viewerCanReact: Bool, reactionGroups: [AsIssue.ReactionGroup]? = nil, author: AsIssue.Author? = nil, editor: AsIssue.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: AsIssue.Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: AsIssue.Assignee, number: Int, title: String) -> IssueOrPullRequest {
          return IssueOrPullRequest(snapshot: ["__typename": "Issue", "timeline": timeline.snapshot, "milestone": milestone.flatMap { (value: AsIssue.Milestone) -> Snapshot in value.snapshot }, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [AsIssue.ReactionGroup]) -> [Snapshot] in value.map { (value: AsIssue.ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: AsIssue.Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: AsIssue.Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels.flatMap { (value: AsIssue.Label) -> Snapshot in value.snapshot }, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees.snapshot, "number": number, "title": title])
        }

        public static func makePullRequest(timeline: AsPullRequest.Timeline, reviewRequests: AsPullRequest.ReviewRequest? = nil, commits: AsPullRequest.Commit, milestone: AsPullRequest.Milestone? = nil, viewerCanReact: Bool, reactionGroups: [AsPullRequest.ReactionGroup]? = nil, author: AsPullRequest.Author? = nil, editor: AsPullRequest.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: AsPullRequest.Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: AsPullRequest.Assignee, number: Int, title: String, merged: Bool, baseRefName: String, changedFiles: Int, additions: Int, deletions: Int, mergeable: MergeableState, mergeStateStatus: MergeStateStatus) -> IssueOrPullRequest {
          return IssueOrPullRequest(snapshot: ["__typename": "PullRequest", "timeline": timeline.snapshot, "reviewRequests": reviewRequests.flatMap { (value: AsPullRequest.ReviewRequest) -> Snapshot in value.snapshot }, "commits": commits.snapshot, "milestone": milestone.flatMap { (value: AsPullRequest.Milestone) -> Snapshot in value.snapshot }, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [AsPullRequest.ReactionGroup]) -> [Snapshot] in value.map { (value: AsPullRequest.ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: AsPullRequest.Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: AsPullRequest.Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels.flatMap { (value: AsPullRequest.Label) -> Snapshot in value.snapshot }, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees.snapshot, "number": number, "title": title, "merged": merged, "baseRefName": baseRefName, "changedFiles": changedFiles, "additions": additions, "deletions": deletions, "mergeable": mergeable, "mergeStateStatus": mergeStateStatus])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asIssue: AsIssue? {
          get {
            if !AsIssue.possibleTypes.contains(__typename) { return nil }
            return AsIssue(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsIssue: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("timeline", arguments: ["last": GraphQLVariable("page_size"), "before": GraphQLVariable("before")], type: .nonNull(.object(Timeline.selections))),
            GraphQLField("milestone", type: .object(Milestone.selections)),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("author", type: .object(Author.selections)),
            GraphQLField("editor", type: .object(Editor.selections)),
            GraphQLField("lastEditedAt", type: .scalar(String.self)),
            GraphQLField("body", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("locked", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("labels", arguments: ["first": 30], type: .object(Label.selections)),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("assignees", arguments: ["first": GraphQLVariable("page_size")], type: .nonNull(.object(Assignee.selections))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(timeline: Timeline, milestone: Milestone? = nil, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: Assignee, number: Int, title: String) {
            self.init(snapshot: ["__typename": "Issue", "timeline": timeline.snapshot, "milestone": milestone.flatMap { (value: Milestone) -> Snapshot in value.snapshot }, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels.flatMap { (value: Label) -> Snapshot in value.snapshot }, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees.snapshot, "number": number, "title": title])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of events, comments, commits, etc. associated with the issue.
          public var timeline: Timeline {
            get {
              return Timeline(snapshot: snapshot["timeline"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "timeline")
            }
          }

          /// Identifies the milestone associated with the issue.
          public var milestone: Milestone? {
            get {
              return (snapshot["milestone"] as? Snapshot).flatMap { Milestone(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "milestone")
            }
          }

          /// Can user react to this subject
          public var viewerCanReact: Bool {
            get {
              return snapshot["viewerCanReact"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerCanReact")
            }
          }

          /// A list of reactions grouped by content left on the subject.
          public var reactionGroups: [ReactionGroup]? {
            get {
              return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
            }
            set {
              snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// The actor who edited the comment.
          public var editor: Editor? {
            get {
              return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "editor")
            }
          }

          /// The moment the editor made the last edit
          public var lastEditedAt: String? {
            get {
              return snapshot["lastEditedAt"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "lastEditedAt")
            }
          }

          /// Identifies the body of the issue.
          public var body: String {
            get {
              return snapshot["body"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "body")
            }
          }

          /// Identifies the date and time when the object was created.
          public var createdAt: String {
            get {
              return snapshot["createdAt"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "createdAt")
            }
          }

          /// Did the viewer author this comment.
          public var viewerDidAuthor: Bool {
            get {
              return snapshot["viewerDidAuthor"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
            }
          }

          /// `true` if the object is locked
          public var locked: Bool {
            get {
              return snapshot["locked"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "locked")
            }
          }

          /// `true` if the object is closed (definition of closed may depend on type)
          public var closed: Bool {
            get {
              return snapshot["closed"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "closed")
            }
          }

          /// A list of labels associated with the object.
          public var labels: Label? {
            get {
              return (snapshot["labels"] as? Snapshot).flatMap { Label(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "labels")
            }
          }

          /// Check if the current viewer can update this object.
          public var viewerCanUpdate: Bool {
            get {
              return snapshot["viewerCanUpdate"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerCanUpdate")
            }
          }

          /// ID of the object.
          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// A list of Users assigned to this object.
          public var assignees: Assignee {
            get {
              return Assignee(snapshot: snapshot["assignees"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "assignees")
            }
          }

          /// Identifies the issue number.
          public var number: Int {
            get {
              return snapshot["number"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the issue title.
          public var title: String {
            get {
              return snapshot["title"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var lockableFields: LockableFields {
              get {
                return LockableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var closableFields: ClosableFields {
              get {
                return ClosableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var assigneeFields: AssigneeFields {
              get {
                return AssigneeFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "IssueTimelineConnection", "pageInfo": pageInfo.snapshot, "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Information to aid in pagination.
            public var pageInfo: PageInfo {
              get {
                return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct PageInfo: GraphQLSelectionSet {
              public static let possibleTypes = ["PageInfo"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("startCursor", type: .scalar(String.self)),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(hasPreviousPage: Bool, startCursor: String? = nil) {
                self.init(snapshot: ["__typename": "PageInfo", "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// When paginating backwards, are there more items?
              public var hasPreviousPage: Bool {
                get {
                  return snapshot["hasPreviousPage"]! as! Bool
                }
                set {
                  snapshot.updateValue(newValue, forKey: "hasPreviousPage")
                }
              }

              /// When paginating backwards, the cursor to continue.
              public var startCursor: String? {
                get {
                  return snapshot["startCursor"] as? String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "startCursor")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(snapshot: snapshot)
                }
                set {
                  snapshot += newValue.snapshot
                }
              }

              public struct Fragments {
                public var snapshot: Snapshot

                public var headPaging: HeadPaging {
                  get {
                    return HeadPaging(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
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

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public static func makeSubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "SubscribedEvent"])
              }

              public static func makeUnsubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "UnsubscribedEvent"])
              }

              public static func makeCommit(id: GraphQLID, author: AsCommit.Author? = nil, oid: String, messageHeadline: String) -> Node {
                return Node(snapshot: ["__typename": "Commit", "id": id, "author": author.flatMap { (value: AsCommit.Author) -> Snapshot in value.snapshot }, "oid": oid, "messageHeadline": messageHeadline])
              }

              public static func makeIssueComment(id: GraphQLID, viewerCanReact: Bool, reactionGroups: [AsIssueComment.ReactionGroup]? = nil, author: AsIssueComment.Author? = nil, editor: AsIssueComment.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool, viewerCanDelete: Bool) -> Node {
                return Node(snapshot: ["__typename": "IssueComment", "id": id, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [AsIssueComment.ReactionGroup]) -> [Snapshot] in value.map { (value: AsIssueComment.ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: AsIssueComment.Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: AsIssueComment.Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate, "viewerCanDelete": viewerCanDelete])
              }

              public static func makeLabeledEvent(id: GraphQLID, actor: AsLabeledEvent.Actor? = nil, label: AsLabeledEvent.Label, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "LabeledEvent", "id": id, "actor": actor.flatMap { (value: AsLabeledEvent.Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
              }

              public static func makeUnlabeledEvent(id: GraphQLID, actor: AsUnlabeledEvent.Actor? = nil, label: AsUnlabeledEvent.Label, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "UnlabeledEvent", "id": id, "actor": actor.flatMap { (value: AsUnlabeledEvent.Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
              }

              public static func makeClosedEvent(id: GraphQLID, actor: AsClosedEvent.Actor? = nil, createdAt: String, closer: AsClosedEvent.Closer? = nil) -> Node {
                return Node(snapshot: ["__typename": "ClosedEvent", "id": id, "actor": actor.flatMap { (value: AsClosedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "closer": closer.flatMap { (value: AsClosedEvent.Closer) -> Snapshot in value.snapshot }])
              }

              public static func makeReopenedEvent(id: GraphQLID, actor: AsReopenedEvent.Actor? = nil, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "ReopenedEvent", "id": id, "actor": actor.flatMap { (value: AsReopenedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
              }

              public static func makeRenamedTitleEvent(id: GraphQLID, actor: AsRenamedTitleEvent.Actor? = nil, createdAt: String, currentTitle: String, previousTitle: String) -> Node {
                return Node(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "actor": actor.flatMap { (value: AsRenamedTitleEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "currentTitle": currentTitle, "previousTitle": previousTitle])
              }

              public static func makeLockedEvent(id: GraphQLID, actor: AsLockedEvent.Actor? = nil, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "LockedEvent", "id": id, "actor": actor.flatMap { (value: AsLockedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
              }

              public static func makeUnlockedEvent(id: GraphQLID, actor: AsUnlockedEvent.Actor? = nil, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "UnlockedEvent", "id": id, "actor": actor.flatMap { (value: AsUnlockedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
              }

              public static func makeCrossReferencedEvent(id: GraphQLID, actor: AsCrossReferencedEvent.Actor? = nil, createdAt: String, source: AsCrossReferencedEvent.Source) -> Node {
                return Node(snapshot: ["__typename": "CrossReferencedEvent", "id": id, "actor": actor.flatMap { (value: AsCrossReferencedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "source": source.snapshot])
              }

              public static func makeReferencedEvent(createdAt: String, id: GraphQLID, refCommit: AsReferencedEvent.RefCommit? = nil, actor: AsReferencedEvent.Actor? = nil, commitRepository: AsReferencedEvent.CommitRepository, subject: AsReferencedEvent.Subject) -> Node {
                return Node(snapshot: ["__typename": "ReferencedEvent", "createdAt": createdAt, "id": id, "refCommit": refCommit.flatMap { (value: AsReferencedEvent.RefCommit) -> Snapshot in value.snapshot }, "actor": actor.flatMap { (value: AsReferencedEvent.Actor) -> Snapshot in value.snapshot }, "commitRepository": commitRepository.snapshot, "subject": subject.snapshot])
              }

              public static func makeAssignedEvent(id: GraphQLID, createdAt: String, actor: AsAssignedEvent.Actor? = nil, user: AsAssignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsAssignedEvent.Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: AsAssignedEvent.User) -> Snapshot in value.snapshot }])
              }

              public static func makeUnassignedEvent(id: GraphQLID, createdAt: String, actor: AsUnassignedEvent.Actor? = nil, user: AsUnassignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsUnassignedEvent.Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: AsUnassignedEvent.User) -> Snapshot in value.snapshot }])
              }

              public static func makeMilestonedEvent(id: GraphQLID, createdAt: String, actor: AsMilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsMilestonedEvent.Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
              }

              public static func makeDemilestonedEvent(id: GraphQLID, createdAt: String, actor: AsDemilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsDemilestonedEvent.Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              public var asCommit: AsCommit? {
                get {
                  if !AsCommit.possibleTypes.contains(__typename) { return nil }
                  return AsCommit(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsCommit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("messageHeadline", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, oid: String, messageHeadline: String) {
                  self.init(snapshot: ["__typename": "Commit", "id": id, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "oid": oid, "messageHeadline": messageHeadline])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Authorship details of the commit.
                public var author: Author? {
                  get {
                    return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
                  }
                }

                /// The Git object ID
                public var oid: String {
                  get {
                    return snapshot["oid"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "oid")
                  }
                }

                /// The Git commit message headline
                public var messageHeadline: String {
                  get {
                    return snapshot["messageHeadline"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "messageHeadline")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["GitActor"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("user", type: .object(User.selections)),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(user: User? = nil) {
                    self.init(snapshot: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The GitHub user corresponding to the email field. Null if no such user exists.
                  public var user: User? {
                    get {
                      return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                    }
                    set {
                      snapshot.updateValue(newValue?.snapshot, forKey: "user")
                    }
                  }

                  public struct User: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(login: String, avatarUrl: String) {
                      self.init(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return snapshot["login"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "login")
                      }
                    }

                    /// A URL pointing to the user's public avatar.
                    public var avatarUrl: String {
                      get {
                        return snapshot["avatarUrl"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "avatarUrl")
                      }
                    }
                  }
                }
              }

              public var asIssueComment: AsIssueComment? {
                get {
                  if !AsIssueComment.possibleTypes.contains(__typename) { return nil }
                  return AsIssueComment(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsIssueComment: GraphQLSelectionSet {
                public static let possibleTypes = ["IssueComment"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("editor", type: .object(Editor.selections)),
                  GraphQLField("lastEditedAt", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerCanDelete", type: .nonNull(.scalar(Bool.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool, viewerCanDelete: Bool) {
                  self.init(snapshot: ["__typename": "IssueComment", "id": id, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate, "viewerCanDelete": viewerCanDelete])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Can user react to this subject
                public var viewerCanReact: Bool {
                  get {
                    return snapshot["viewerCanReact"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerCanReact")
                  }
                }

                /// A list of reactions grouped by content left on the subject.
                public var reactionGroups: [ReactionGroup]? {
                  get {
                    return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
                  }
                  set {
                    snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
                  }
                }

                /// The actor who authored the comment.
                public var author: Author? {
                  get {
                    return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
                  }
                }

                /// The actor who edited the comment.
                public var editor: Editor? {
                  get {
                    return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                  }
                }

                /// The moment the editor made the last edit
                public var lastEditedAt: String? {
                  get {
                    return snapshot["lastEditedAt"] as? String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "lastEditedAt")
                  }
                }

                /// The body as Markdown.
                public var body: String {
                  get {
                    return snapshot["body"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "body")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Did the viewer author this comment.
                public var viewerDidAuthor: Bool {
                  get {
                    return snapshot["viewerDidAuthor"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
                  }
                }

                /// Check if the current viewer can update this object.
                public var viewerCanUpdate: Bool {
                  get {
                    return snapshot["viewerCanUpdate"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerCanUpdate")
                  }
                }

                /// Check if the current viewer can delete this object.
                public var viewerCanDelete: Bool {
                  get {
                    return snapshot["viewerCanDelete"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerCanDelete")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var reactionFields: ReactionFields {
                    get {
                      return ReactionFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var updatableFields: UpdatableFields {
                    get {
                      return UpdatableFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var deletableFields: DeletableFields {
                    get {
                      return DeletableFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
                    self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Whether or not the authenticated user has left a reaction on the subject.
                  public var viewerHasReacted: Bool {
                    get {
                      return snapshot["viewerHasReacted"]! as! Bool
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "viewerHasReacted")
                    }
                  }

                  /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
                  public var users: User {
                    get {
                      return User(snapshot: snapshot["users"]! as! Snapshot)
                    }
                    set {
                      snapshot.updateValue(newValue.snapshot, forKey: "users")
                    }
                  }

                  /// Identifies the emoji reaction.
                  public var content: ReactionContent {
                    get {
                      return snapshot["content"]! as! ReactionContent
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "content")
                    }
                  }

                  public struct User: GraphQLSelectionSet {
                    public static let possibleTypes = ["ReactingUserConnection"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("nodes", type: .list(.object(Node.selections))),
                      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(nodes: [Node?]? = nil, totalCount: Int) {
                      self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// A list of nodes.
                    public var nodes: [Node?]? {
                      get {
                        return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
                      }
                      set {
                        snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
                      }
                    }

                    /// Identifies the total count of items in the connection.
                    public var totalCount: Int {
                      get {
                        return snapshot["totalCount"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "totalCount")
                      }
                    }

                    public struct Node: GraphQLSelectionSet {
                      public static let possibleTypes = ["User"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("login", type: .nonNull(.scalar(String.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(login: String) {
                        self.init(snapshot: ["__typename": "User", "login": login])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The username used to login.
                      public var login: String {
                        get {
                          return snapshot["login"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "login")
                        }
                      }
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                  }

                  public static func makeUser(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                  }

                  public static func makeBot(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }

                  /// A URL pointing to the actor's public avatar.
                  public var avatarUrl: String {
                    get {
                      return snapshot["avatarUrl"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "avatarUrl")
                    }
                  }
                }

                public struct Editor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asLabeledEvent: AsLabeledEvent? {
                get {
                  if !AsLabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLabeledEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsLabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, label: Label, createdAt: String) {
                  self.init(snapshot: ["__typename": "LabeledEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'labeled' event.
                public var label: Label {
                  get {
                    return Label(snapshot: snapshot["label"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(color: String, name: String) {
                    self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return snapshot["color"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return snapshot["name"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asUnlabeledEvent: AsUnlabeledEvent? {
                get {
                  if !AsUnlabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlabeledEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsUnlabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, label: Label, createdAt: String) {
                  self.init(snapshot: ["__typename": "UnlabeledEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'unlabeled' event.
                public var label: Label {
                  get {
                    return Label(snapshot: snapshot["label"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(color: String, name: String) {
                    self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return snapshot["color"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return snapshot["name"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asClosedEvent: AsClosedEvent? {
                get {
                  if !AsClosedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsClosedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsClosedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ClosedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("closer", type: .object(Closer.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String, closer: Closer? = nil) {
                  self.init(snapshot: ["__typename": "ClosedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "closer": closer.flatMap { (value: Closer) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Object which triggered the creation of this event.
                public var closer: Closer? {
                  get {
                    return (snapshot["closer"] as? Snapshot).flatMap { Closer(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "closer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeCommit(oid: String) -> Closer {
                    return Closer(snapshot: ["__typename": "Commit", "oid": oid])
                  }

                  public static func makePullRequest(mergeCommit: AsPullRequest.MergeCommit? = nil) -> Closer {
                    return Closer(snapshot: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: AsPullRequest.MergeCommit) -> Snapshot in value.snapshot }])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asCommit: AsCommit? {
                    get {
                      if !AsCommit.possibleTypes.contains(__typename) { return nil }
                      return AsCommit(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct AsCommit: GraphQLSelectionSet {
                    public static let possibleTypes = ["Commit"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(oid: String) {
                      self.init(snapshot: ["__typename": "Commit", "oid": oid])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The Git object ID
                    public var oid: String {
                      get {
                        return snapshot["oid"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "oid")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("mergeCommit", type: .object(MergeCommit.selections)),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(mergeCommit: MergeCommit? = nil) {
                      self.init(snapshot: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: MergeCommit) -> Snapshot in value.snapshot }])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The commit that was created when this pull request was merged.
                    public var mergeCommit: MergeCommit? {
                      get {
                        return (snapshot["mergeCommit"] as? Snapshot).flatMap { MergeCommit(snapshot: $0) }
                      }
                      set {
                        snapshot.updateValue(newValue?.snapshot, forKey: "mergeCommit")
                      }
                    }

                    public struct MergeCommit: GraphQLSelectionSet {
                      public static let possibleTypes = ["Commit"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(oid: String) {
                        self.init(snapshot: ["__typename": "Commit", "oid": oid])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The Git object ID
                      public var oid: String {
                        get {
                          return snapshot["oid"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "oid")
                        }
                      }
                    }
                  }
                }
              }

              public var asReopenedEvent: AsReopenedEvent? {
                get {
                  if !AsReopenedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReopenedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsReopenedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReopenedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String) {
                  self.init(snapshot: ["__typename": "ReopenedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asRenamedTitleEvent: AsRenamedTitleEvent? {
                get {
                  if !AsRenamedTitleEvent.possibleTypes.contains(__typename) { return nil }
                  return AsRenamedTitleEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsRenamedTitleEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["RenamedTitleEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("previousTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String, currentTitle: String, previousTitle: String) {
                  self.init(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "currentTitle": currentTitle, "previousTitle": previousTitle])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the current title of the issue or pull request.
                public var currentTitle: String {
                  get {
                    return snapshot["currentTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "currentTitle")
                  }
                }

                /// Identifies the previous title of the issue or pull request.
                public var previousTitle: String {
                  get {
                    return snapshot["previousTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "previousTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asLockedEvent: AsLockedEvent? {
                get {
                  if !AsLockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLockedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsLockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String) {
                  self.init(snapshot: ["__typename": "LockedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnlockedEvent: AsUnlockedEvent? {
                get {
                  if !AsUnlockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlockedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsUnlockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String) {
                  self.init(snapshot: ["__typename": "UnlockedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asCrossReferencedEvent: AsCrossReferencedEvent? {
                get {
                  if !AsCrossReferencedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsCrossReferencedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsCrossReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["CrossReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("source", type: .nonNull(.object(Source.selections))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String, source: Source) {
                  self.init(snapshot: ["__typename": "CrossReferencedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "source": source.snapshot])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Issue or pull request that made the reference.
                public var source: Source {
                  get {
                    return Source(snapshot: snapshot["source"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "source")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool, repository: AsIssue.Repository) -> Source {
                    return Source(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.snapshot])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool, repository: AsPullRequest.Repository) -> Source {
                    return Source(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.snapshot])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool, repository: Repository) {
                      self.init(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.snapshot])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(snapshot: snapshot["repository"]! as! Snapshot)
                      }
                      set {
                        snapshot.updateValue(newValue.snapshot, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(name: String, owner: Owner) {
                        self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner.snapshot])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return snapshot["name"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(snapshot: snapshot["owner"]! as! Snapshot)
                        }
                        set {
                          snapshot.updateValue(newValue.snapshot, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public var snapshot: Snapshot

                        public init(snapshot: Snapshot) {
                          self.snapshot = snapshot
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return snapshot["__typename"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return snapshot["login"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "login")
                          }
                        }
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool, repository: Repository) {
                      self.init(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.snapshot])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return snapshot["merged"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "merged")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(snapshot: snapshot["repository"]! as! Snapshot)
                      }
                      set {
                        snapshot.updateValue(newValue.snapshot, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(name: String, owner: Owner) {
                        self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner.snapshot])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return snapshot["name"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(snapshot: snapshot["owner"]! as! Snapshot)
                        }
                        set {
                          snapshot.updateValue(newValue.snapshot, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public var snapshot: Snapshot

                        public init(snapshot: Snapshot) {
                          self.snapshot = snapshot
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return snapshot["__typename"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return snapshot["login"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "login")
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
                  return AsReferencedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("commit", alias: "refCommit", type: .object(RefCommit.selections)),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("commitRepository", type: .nonNull(.object(CommitRepository.selections))),
                  GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(createdAt: String, id: GraphQLID, refCommit: RefCommit? = nil, actor: Actor? = nil, commitRepository: CommitRepository, subject: Subject) {
                  self.init(snapshot: ["__typename": "ReferencedEvent", "createdAt": createdAt, "id": id, "refCommit": refCommit.flatMap { (value: RefCommit) -> Snapshot in value.snapshot }, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "commitRepository": commitRepository.snapshot, "subject": subject.snapshot])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the commit associated with the 'referenced' event.
                public var refCommit: RefCommit? {
                  get {
                    return (snapshot["refCommit"] as? Snapshot).flatMap { RefCommit(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "refCommit")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the repository associated with the 'referenced' event.
                public var commitRepository: CommitRepository {
                  get {
                    return CommitRepository(snapshot: snapshot["commitRepository"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "commitRepository")
                  }
                }

                /// Object referenced by event.
                public var subject: Subject {
                  get {
                    return Subject(snapshot: snapshot["subject"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "subject")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct RefCommit: GraphQLSelectionSet {
                  public static let possibleTypes = ["Commit"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(oid: String) {
                    self.init(snapshot: ["__typename": "Commit", "oid": oid])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The Git object ID
                  public var oid: String {
                    get {
                      return snapshot["oid"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "oid")
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct CommitRepository: GraphQLSelectionSet {
                  public static let possibleTypes = ["Repository"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(name: String, owner: Owner) {
                    self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner.snapshot])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The name of the repository.
                  public var name: String {
                    get {
                      return snapshot["name"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "name")
                    }
                  }

                  /// The User owner of the repository.
                  public var owner: Owner {
                    get {
                      return Owner(snapshot: snapshot["owner"]! as! Snapshot)
                    }
                    set {
                      snapshot.updateValue(newValue.snapshot, forKey: "owner")
                    }
                  }

                  public var fragments: Fragments {
                    get {
                      return Fragments(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public struct Fragments {
                    public var snapshot: Snapshot

                    public var referencedRepositoryFields: ReferencedRepositoryFields {
                      get {
                        return ReferencedRepositoryFields(snapshot: snapshot)
                      }
                      set {
                        snapshot += newValue.snapshot
                      }
                    }
                  }

                  public struct Owner: GraphQLSelectionSet {
                    public static let possibleTypes = ["Organization", "User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public static func makeOrganization(login: String) -> Owner {
                      return Owner(snapshot: ["__typename": "Organization", "login": login])
                    }

                    public static func makeUser(login: String) -> Owner {
                      return Owner(snapshot: ["__typename": "User", "login": login])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return snapshot["login"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool) -> Subject {
                    return Subject(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool) -> Subject {
                    return Subject(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool) {
                      self.init(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool) {
                      self.init(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return snapshot["merged"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "merged")
                      }
                    }
                  }
                }
              }

              public var asAssignedEvent: AsAssignedEvent? {
                get {
                  if !AsAssignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsAssignedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsAssignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["AssignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the user who was assigned.
                public var user: User? {
                  get {
                    return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(login: String) {
                    self.init(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnassignedEvent: AsUnassignedEvent? {
                get {
                  if !AsUnassignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnassignedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsUnassignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnassignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the subject (user) who was unassigned.
                public var user: User? {
                  get {
                    return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(login: String) {
                    self.init(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asMilestonedEvent: AsMilestonedEvent? {
                get {
                  if !AsMilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsMilestonedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsMilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["MilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'milestoned' event.
                public var milestoneTitle: String {
                  get {
                    return snapshot["milestoneTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asDemilestonedEvent: AsDemilestonedEvent? {
                get {
                  if !AsDemilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsDemilestonedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsDemilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["DemilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'demilestoned' event.
                public var milestoneTitle: String {
                  get {
                    return snapshot["milestoneTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("number", type: .nonNull(.scalar(Int.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
              GraphQLField("dueOn", type: .scalar(String.self)),
              GraphQLField("issues", alias: "openCount", arguments: ["states": ["OPEN"]], type: .nonNull(.object(OpenCount.selections))),
              GraphQLField("issues", alias: "totalCount", type: .nonNull(.object(TotalCount.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(number: Int, title: String, url: String, dueOn: String? = nil, openCount: OpenCount, totalCount: TotalCount) {
              self.init(snapshot: ["__typename": "Milestone", "number": number, "title": title, "url": url, "dueOn": dueOn, "openCount": openCount.snapshot, "totalCount": totalCount.snapshot])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the number of the milestone.
            public var number: Int {
              get {
                return snapshot["number"]! as! Int
              }
              set {
                snapshot.updateValue(newValue, forKey: "number")
              }
            }

            /// Identifies the title of the milestone.
            public var title: String {
              get {
                return snapshot["title"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "title")
              }
            }

            /// The HTTP URL for this milestone
            public var url: String {
              get {
                return snapshot["url"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "url")
              }
            }

            /// Identifies the due date of the milestone.
            public var dueOn: String? {
              get {
                return snapshot["dueOn"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "dueOn")
              }
            }

            /// A list of issues associated with the milestone.
            public var openCount: OpenCount {
              get {
                return OpenCount(snapshot: snapshot["openCount"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "openCount")
              }
            }

            /// A list of issues associated with the milestone.
            public var totalCount: TotalCount {
              get {
                return TotalCount(snapshot: snapshot["totalCount"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "totalCount")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var milestoneFields: MilestoneFields {
                get {
                  return MilestoneFields(snapshot: snapshot)
                }
                set {
                  snapshot += newValue.snapshot
                }
              }
            }

            public struct OpenCount: GraphQLSelectionSet {
              public static let possibleTypes = ["IssueConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(totalCount: Int) {
                self.init(snapshot: ["__typename": "IssueConnection", "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }
            }

            public struct TotalCount: GraphQLSelectionSet {
              public static let possibleTypes = ["IssueConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(totalCount: Int) {
                self.init(snapshot: ["__typename": "IssueConnection", "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
              self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Whether or not the authenticated user has left a reaction on the subject.
            public var viewerHasReacted: Bool {
              get {
                return snapshot["viewerHasReacted"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerHasReacted")
              }
            }

            /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
            public var users: User {
              get {
                return User(snapshot: snapshot["users"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "users")
              }
            }

            /// Identifies the emoji reaction.
            public var content: ReactionContent {
              get {
                return snapshot["content"]! as! ReactionContent
              }
              set {
                snapshot.updateValue(newValue, forKey: "content")
              }
            }

            public struct User: GraphQLSelectionSet {
              public static let possibleTypes = ["ReactingUserConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(nodes: [Node?]? = nil, totalCount: Int) {
                self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of nodes.
              public var nodes: [Node?]? {
                get {
                  return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
                }
                set {
                  snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("login", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(login: String) {
                  self.init(snapshot: ["__typename": "User", "login": login])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The username used to login.
                public var login: String {
                  get {
                    return snapshot["login"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "login")
                  }
                }
              }
            }
          }

          public struct Author: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
              GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
            }

            public static func makeUser(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
            }

            public static func makeBot(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }

            /// A URL pointing to the actor's public avatar.
            public var avatarUrl: String {
              get {
                return snapshot["avatarUrl"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }
          }

          public struct Editor: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "User", "login": login])
            }

            public static func makeBot(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "Bot", "login": login])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }
          }

          public struct Label: GraphQLSelectionSet {
            public static let possibleTypes = ["LabelConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Label"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("color", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(color: String, name: String) {
                self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the label color.
              public var color: String {
                get {
                  return snapshot["color"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "color")
                }
              }

              /// Identifies the label name.
              public var name: String {
                get {
                  return snapshot["name"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "name")
                }
              }
            }
          }

          public struct Assignee: GraphQLSelectionSet {
            public static let possibleTypes = ["UserConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["User"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("login", type: .nonNull(.scalar(String.self))),
                GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(login: String, avatarUrl: String) {
                self.init(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The username used to login.
              public var login: String {
                get {
                  return snapshot["login"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "login")
                }
              }

              /// A URL pointing to the user's public avatar.
              public var avatarUrl: String {
                get {
                  return snapshot["avatarUrl"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "avatarUrl")
                }
              }
            }
          }
        }

        public var asPullRequest: AsPullRequest? {
          get {
            if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
            return AsPullRequest(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
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
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("author", type: .object(Author.selections)),
            GraphQLField("editor", type: .object(Editor.selections)),
            GraphQLField("lastEditedAt", type: .scalar(String.self)),
            GraphQLField("body", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("locked", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("labels", arguments: ["first": 30], type: .object(Label.selections)),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("assignees", arguments: ["first": GraphQLVariable("page_size")], type: .nonNull(.object(Assignee.selections))),
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

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(timeline: Timeline, reviewRequests: ReviewRequest? = nil, commits: Commit, milestone: Milestone? = nil, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: Assignee, number: Int, title: String, merged: Bool, baseRefName: String, changedFiles: Int, additions: Int, deletions: Int, mergeable: MergeableState, mergeStateStatus: MergeStateStatus) {
            self.init(snapshot: ["__typename": "PullRequest", "timeline": timeline.snapshot, "reviewRequests": reviewRequests.flatMap { (value: ReviewRequest) -> Snapshot in value.snapshot }, "commits": commits.snapshot, "milestone": milestone.flatMap { (value: Milestone) -> Snapshot in value.snapshot }, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels.flatMap { (value: Label) -> Snapshot in value.snapshot }, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees.snapshot, "number": number, "title": title, "merged": merged, "baseRefName": baseRefName, "changedFiles": changedFiles, "additions": additions, "deletions": deletions, "mergeable": mergeable, "mergeStateStatus": mergeStateStatus])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of events, comments, commits, etc. associated with the pull request.
          public var timeline: Timeline {
            get {
              return Timeline(snapshot: snapshot["timeline"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "timeline")
            }
          }

          /// A list of review requests associated with the pull request.
          public var reviewRequests: ReviewRequest? {
            get {
              return (snapshot["reviewRequests"] as? Snapshot).flatMap { ReviewRequest(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "reviewRequests")
            }
          }

          /// A list of commits present in this pull request's head branch not present in the base branch.
          public var commits: Commit {
            get {
              return Commit(snapshot: snapshot["commits"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "commits")
            }
          }

          /// Identifies the milestone associated with the pull request.
          public var milestone: Milestone? {
            get {
              return (snapshot["milestone"] as? Snapshot).flatMap { Milestone(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "milestone")
            }
          }

          /// Can user react to this subject
          public var viewerCanReact: Bool {
            get {
              return snapshot["viewerCanReact"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerCanReact")
            }
          }

          /// A list of reactions grouped by content left on the subject.
          public var reactionGroups: [ReactionGroup]? {
            get {
              return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
            }
            set {
              snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// The actor who edited this pull request's body.
          public var editor: Editor? {
            get {
              return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "editor")
            }
          }

          /// The moment the editor made the last edit
          public var lastEditedAt: String? {
            get {
              return snapshot["lastEditedAt"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "lastEditedAt")
            }
          }

          /// The body as Markdown.
          public var body: String {
            get {
              return snapshot["body"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "body")
            }
          }

          /// Identifies the date and time when the object was created.
          public var createdAt: String {
            get {
              return snapshot["createdAt"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "createdAt")
            }
          }

          /// Did the viewer author this comment.
          public var viewerDidAuthor: Bool {
            get {
              return snapshot["viewerDidAuthor"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
            }
          }

          /// `true` if the pull request is locked
          public var locked: Bool {
            get {
              return snapshot["locked"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "locked")
            }
          }

          /// `true` if the pull request is closed
          public var closed: Bool {
            get {
              return snapshot["closed"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "closed")
            }
          }

          /// A list of labels associated with the object.
          public var labels: Label? {
            get {
              return (snapshot["labels"] as? Snapshot).flatMap { Label(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "labels")
            }
          }

          /// Check if the current viewer can update this object.
          public var viewerCanUpdate: Bool {
            get {
              return snapshot["viewerCanUpdate"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerCanUpdate")
            }
          }

          /// ID of the object.
          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// A list of Users assigned to this object.
          public var assignees: Assignee {
            get {
              return Assignee(snapshot: snapshot["assignees"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "assignees")
            }
          }

          /// Identifies the pull request number.
          public var number: Int {
            get {
              return snapshot["number"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the pull request title.
          public var title: String {
            get {
              return snapshot["title"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }

          /// Whether or not the pull request was merged.
          public var merged: Bool {
            get {
              return snapshot["merged"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "merged")
            }
          }

          /// Identifies the name of the base Ref associated with the pull request, even if the ref has been deleted.
          public var baseRefName: String {
            get {
              return snapshot["baseRefName"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "baseRefName")
            }
          }

          /// The number of changed files in this pull request.
          public var changedFiles: Int {
            get {
              return snapshot["changedFiles"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "changedFiles")
            }
          }

          /// The number of additions in this pull request.
          public var additions: Int {
            get {
              return snapshot["additions"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "additions")
            }
          }

          /// The number of deletions in this pull request.
          public var deletions: Int {
            get {
              return snapshot["deletions"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "deletions")
            }
          }

          /// Whether or not the pull request can be merged based on the existence of merge conflicts.
          public var mergeable: MergeableState {
            get {
              return snapshot["mergeable"]! as! MergeableState
            }
            set {
              snapshot.updateValue(newValue, forKey: "mergeable")
            }
          }

          /// Detailed information about the current pull request merge state status.
          public var mergeStateStatus: MergeStateStatus {
            get {
              return snapshot["mergeStateStatus"]! as! MergeStateStatus
            }
            set {
              snapshot.updateValue(newValue, forKey: "mergeStateStatus")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var lockableFields: LockableFields {
              get {
                return LockableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var closableFields: ClosableFields {
              get {
                return ClosableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var assigneeFields: AssigneeFields {
              get {
                return AssigneeFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "PullRequestTimelineConnection", "pageInfo": pageInfo.snapshot, "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Information to aid in pagination.
            public var pageInfo: PageInfo {
              get {
                return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct PageInfo: GraphQLSelectionSet {
              public static let possibleTypes = ["PageInfo"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("startCursor", type: .scalar(String.self)),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(hasPreviousPage: Bool, startCursor: String? = nil) {
                self.init(snapshot: ["__typename": "PageInfo", "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// When paginating backwards, are there more items?
              public var hasPreviousPage: Bool {
                get {
                  return snapshot["hasPreviousPage"]! as! Bool
                }
                set {
                  snapshot.updateValue(newValue, forKey: "hasPreviousPage")
                }
              }

              /// When paginating backwards, the cursor to continue.
              public var startCursor: String? {
                get {
                  return snapshot["startCursor"] as? String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "startCursor")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(snapshot: snapshot)
                }
                set {
                  snapshot += newValue.snapshot
                }
              }

              public struct Fragments {
                public var snapshot: Snapshot

                public var headPaging: HeadPaging {
                  get {
                    return HeadPaging(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
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

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public static func makeCommitCommentThread() -> Node {
                return Node(snapshot: ["__typename": "CommitCommentThread"])
              }

              public static func makePullRequestReviewComment() -> Node {
                return Node(snapshot: ["__typename": "PullRequestReviewComment"])
              }

              public static func makeSubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "SubscribedEvent"])
              }

              public static func makeUnsubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "UnsubscribedEvent"])
              }

              public static func makeDeployedEvent() -> Node {
                return Node(snapshot: ["__typename": "DeployedEvent"])
              }

              public static func makeHeadRefDeletedEvent() -> Node {
                return Node(snapshot: ["__typename": "HeadRefDeletedEvent"])
              }

              public static func makeHeadRefRestoredEvent() -> Node {
                return Node(snapshot: ["__typename": "HeadRefRestoredEvent"])
              }

              public static func makeHeadRefForcePushedEvent() -> Node {
                return Node(snapshot: ["__typename": "HeadRefForcePushedEvent"])
              }

              public static func makeBaseRefForcePushedEvent() -> Node {
                return Node(snapshot: ["__typename": "BaseRefForcePushedEvent"])
              }

              public static func makeReviewDismissedEvent() -> Node {
                return Node(snapshot: ["__typename": "ReviewDismissedEvent"])
              }

              public static func makeCommit(id: GraphQLID, author: AsCommit.Author? = nil, oid: String, messageHeadline: String) -> Node {
                return Node(snapshot: ["__typename": "Commit", "id": id, "author": author.flatMap { (value: AsCommit.Author) -> Snapshot in value.snapshot }, "oid": oid, "messageHeadline": messageHeadline])
              }

              public static func makeIssueComment(id: GraphQLID, viewerCanReact: Bool, reactionGroups: [AsIssueComment.ReactionGroup]? = nil, author: AsIssueComment.Author? = nil, editor: AsIssueComment.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool, viewerCanDelete: Bool) -> Node {
                return Node(snapshot: ["__typename": "IssueComment", "id": id, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [AsIssueComment.ReactionGroup]) -> [Snapshot] in value.map { (value: AsIssueComment.ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: AsIssueComment.Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: AsIssueComment.Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate, "viewerCanDelete": viewerCanDelete])
              }

              public static func makeLabeledEvent(id: GraphQLID, actor: AsLabeledEvent.Actor? = nil, label: AsLabeledEvent.Label, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "LabeledEvent", "id": id, "actor": actor.flatMap { (value: AsLabeledEvent.Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
              }

              public static func makeUnlabeledEvent(id: GraphQLID, actor: AsUnlabeledEvent.Actor? = nil, label: AsUnlabeledEvent.Label, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "UnlabeledEvent", "id": id, "actor": actor.flatMap { (value: AsUnlabeledEvent.Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
              }

              public static func makeClosedEvent(id: GraphQLID, actor: AsClosedEvent.Actor? = nil, createdAt: String, closer: AsClosedEvent.Closer? = nil) -> Node {
                return Node(snapshot: ["__typename": "ClosedEvent", "id": id, "actor": actor.flatMap { (value: AsClosedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "closer": closer.flatMap { (value: AsClosedEvent.Closer) -> Snapshot in value.snapshot }])
              }

              public static func makeReopenedEvent(id: GraphQLID, actor: AsReopenedEvent.Actor? = nil, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "ReopenedEvent", "id": id, "actor": actor.flatMap { (value: AsReopenedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
              }

              public static func makeRenamedTitleEvent(id: GraphQLID, actor: AsRenamedTitleEvent.Actor? = nil, createdAt: String, currentTitle: String, previousTitle: String) -> Node {
                return Node(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "actor": actor.flatMap { (value: AsRenamedTitleEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "currentTitle": currentTitle, "previousTitle": previousTitle])
              }

              public static func makeLockedEvent(id: GraphQLID, actor: AsLockedEvent.Actor? = nil, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "LockedEvent", "id": id, "actor": actor.flatMap { (value: AsLockedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
              }

              public static func makeUnlockedEvent(id: GraphQLID, actor: AsUnlockedEvent.Actor? = nil, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "UnlockedEvent", "id": id, "actor": actor.flatMap { (value: AsUnlockedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
              }

              public static func makeMergedEvent(id: GraphQLID, mergedCommit: AsMergedEvent.MergedCommit? = nil, actor: AsMergedEvent.Actor? = nil, createdAt: String) -> Node {
                return Node(snapshot: ["__typename": "MergedEvent", "id": id, "mergedCommit": mergedCommit.flatMap { (value: AsMergedEvent.MergedCommit) -> Snapshot in value.snapshot }, "actor": actor.flatMap { (value: AsMergedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
              }

              public static func makePullRequestReviewThread(comments: AsPullRequestReviewThread.Comment) -> Node {
                return Node(snapshot: ["__typename": "PullRequestReviewThread", "comments": comments.snapshot])
              }

              public static func makePullRequestReview(id: GraphQLID, author: AsPullRequestReview.Author? = nil, editor: AsPullRequestReview.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, state: PullRequestReviewState, submittedAt: String? = nil, comments: AsPullRequestReview.Comment) -> Node {
                return Node(snapshot: ["__typename": "PullRequestReview", "id": id, "author": author.flatMap { (value: AsPullRequestReview.Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: AsPullRequestReview.Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "state": state, "submittedAt": submittedAt, "comments": comments.snapshot])
              }

              public static func makeCrossReferencedEvent(id: GraphQLID, actor: AsCrossReferencedEvent.Actor? = nil, createdAt: String, source: AsCrossReferencedEvent.Source) -> Node {
                return Node(snapshot: ["__typename": "CrossReferencedEvent", "id": id, "actor": actor.flatMap { (value: AsCrossReferencedEvent.Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "source": source.snapshot])
              }

              public static func makeReferencedEvent(createdAt: String, id: GraphQLID, actor: AsReferencedEvent.Actor? = nil, commitRepository: AsReferencedEvent.CommitRepository, subject: AsReferencedEvent.Subject) -> Node {
                return Node(snapshot: ["__typename": "ReferencedEvent", "createdAt": createdAt, "id": id, "actor": actor.flatMap { (value: AsReferencedEvent.Actor) -> Snapshot in value.snapshot }, "commitRepository": commitRepository.snapshot, "subject": subject.snapshot])
              }

              public static func makeAssignedEvent(id: GraphQLID, createdAt: String, actor: AsAssignedEvent.Actor? = nil, user: AsAssignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsAssignedEvent.Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: AsAssignedEvent.User) -> Snapshot in value.snapshot }])
              }

              public static func makeUnassignedEvent(id: GraphQLID, createdAt: String, actor: AsUnassignedEvent.Actor? = nil, user: AsUnassignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsUnassignedEvent.Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: AsUnassignedEvent.User) -> Snapshot in value.snapshot }])
              }

              public static func makeReviewRequestedEvent(id: GraphQLID, createdAt: String, actor: AsReviewRequestedEvent.Actor? = nil, requestedReviewer: AsReviewRequestedEvent.RequestedReviewer? = nil) -> Node {
                return Node(snapshot: ["__typename": "ReviewRequestedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsReviewRequestedEvent.Actor) -> Snapshot in value.snapshot }, "requestedReviewer": requestedReviewer.flatMap { (value: AsReviewRequestedEvent.RequestedReviewer) -> Snapshot in value.snapshot }])
              }

              public static func makeReviewRequestRemovedEvent(id: GraphQLID, createdAt: String, actor: AsReviewRequestRemovedEvent.Actor? = nil, requestedReviewer: AsReviewRequestRemovedEvent.RequestedReviewer? = nil) -> Node {
                return Node(snapshot: ["__typename": "ReviewRequestRemovedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsReviewRequestRemovedEvent.Actor) -> Snapshot in value.snapshot }, "requestedReviewer": requestedReviewer.flatMap { (value: AsReviewRequestRemovedEvent.RequestedReviewer) -> Snapshot in value.snapshot }])
              }

              public static func makeMilestonedEvent(id: GraphQLID, createdAt: String, actor: AsMilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsMilestonedEvent.Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
              }

              public static func makeDemilestonedEvent(id: GraphQLID, createdAt: String, actor: AsDemilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: AsDemilestonedEvent.Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              public var asCommit: AsCommit? {
                get {
                  if !AsCommit.possibleTypes.contains(__typename) { return nil }
                  return AsCommit(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsCommit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("messageHeadline", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, oid: String, messageHeadline: String) {
                  self.init(snapshot: ["__typename": "Commit", "id": id, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "oid": oid, "messageHeadline": messageHeadline])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Authorship details of the commit.
                public var author: Author? {
                  get {
                    return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
                  }
                }

                /// The Git object ID
                public var oid: String {
                  get {
                    return snapshot["oid"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "oid")
                  }
                }

                /// The Git commit message headline
                public var messageHeadline: String {
                  get {
                    return snapshot["messageHeadline"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "messageHeadline")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["GitActor"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("user", type: .object(User.selections)),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(user: User? = nil) {
                    self.init(snapshot: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The GitHub user corresponding to the email field. Null if no such user exists.
                  public var user: User? {
                    get {
                      return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                    }
                    set {
                      snapshot.updateValue(newValue?.snapshot, forKey: "user")
                    }
                  }

                  public struct User: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(login: String, avatarUrl: String) {
                      self.init(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return snapshot["login"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "login")
                      }
                    }

                    /// A URL pointing to the user's public avatar.
                    public var avatarUrl: String {
                      get {
                        return snapshot["avatarUrl"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "avatarUrl")
                      }
                    }
                  }
                }
              }

              public var asIssueComment: AsIssueComment? {
                get {
                  if !AsIssueComment.possibleTypes.contains(__typename) { return nil }
                  return AsIssueComment(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsIssueComment: GraphQLSelectionSet {
                public static let possibleTypes = ["IssueComment"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("editor", type: .object(Editor.selections)),
                  GraphQLField("lastEditedAt", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerCanDelete", type: .nonNull(.scalar(Bool.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool, viewerCanDelete: Bool) {
                  self.init(snapshot: ["__typename": "IssueComment", "id": id, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate, "viewerCanDelete": viewerCanDelete])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Can user react to this subject
                public var viewerCanReact: Bool {
                  get {
                    return snapshot["viewerCanReact"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerCanReact")
                  }
                }

                /// A list of reactions grouped by content left on the subject.
                public var reactionGroups: [ReactionGroup]? {
                  get {
                    return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
                  }
                  set {
                    snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
                  }
                }

                /// The actor who authored the comment.
                public var author: Author? {
                  get {
                    return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
                  }
                }

                /// The actor who edited the comment.
                public var editor: Editor? {
                  get {
                    return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                  }
                }

                /// The moment the editor made the last edit
                public var lastEditedAt: String? {
                  get {
                    return snapshot["lastEditedAt"] as? String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "lastEditedAt")
                  }
                }

                /// The body as Markdown.
                public var body: String {
                  get {
                    return snapshot["body"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "body")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Did the viewer author this comment.
                public var viewerDidAuthor: Bool {
                  get {
                    return snapshot["viewerDidAuthor"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
                  }
                }

                /// Check if the current viewer can update this object.
                public var viewerCanUpdate: Bool {
                  get {
                    return snapshot["viewerCanUpdate"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerCanUpdate")
                  }
                }

                /// Check if the current viewer can delete this object.
                public var viewerCanDelete: Bool {
                  get {
                    return snapshot["viewerCanDelete"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerCanDelete")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var reactionFields: ReactionFields {
                    get {
                      return ReactionFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var updatableFields: UpdatableFields {
                    get {
                      return UpdatableFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var deletableFields: DeletableFields {
                    get {
                      return DeletableFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
                    self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Whether or not the authenticated user has left a reaction on the subject.
                  public var viewerHasReacted: Bool {
                    get {
                      return snapshot["viewerHasReacted"]! as! Bool
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "viewerHasReacted")
                    }
                  }

                  /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
                  public var users: User {
                    get {
                      return User(snapshot: snapshot["users"]! as! Snapshot)
                    }
                    set {
                      snapshot.updateValue(newValue.snapshot, forKey: "users")
                    }
                  }

                  /// Identifies the emoji reaction.
                  public var content: ReactionContent {
                    get {
                      return snapshot["content"]! as! ReactionContent
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "content")
                    }
                  }

                  public struct User: GraphQLSelectionSet {
                    public static let possibleTypes = ["ReactingUserConnection"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("nodes", type: .list(.object(Node.selections))),
                      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(nodes: [Node?]? = nil, totalCount: Int) {
                      self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// A list of nodes.
                    public var nodes: [Node?]? {
                      get {
                        return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
                      }
                      set {
                        snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
                      }
                    }

                    /// Identifies the total count of items in the connection.
                    public var totalCount: Int {
                      get {
                        return snapshot["totalCount"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "totalCount")
                      }
                    }

                    public struct Node: GraphQLSelectionSet {
                      public static let possibleTypes = ["User"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("login", type: .nonNull(.scalar(String.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(login: String) {
                        self.init(snapshot: ["__typename": "User", "login": login])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The username used to login.
                      public var login: String {
                        get {
                          return snapshot["login"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "login")
                        }
                      }
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                  }

                  public static func makeUser(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                  }

                  public static func makeBot(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }

                  /// A URL pointing to the actor's public avatar.
                  public var avatarUrl: String {
                    get {
                      return snapshot["avatarUrl"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "avatarUrl")
                    }
                  }
                }

                public struct Editor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asLabeledEvent: AsLabeledEvent? {
                get {
                  if !AsLabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLabeledEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsLabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, label: Label, createdAt: String) {
                  self.init(snapshot: ["__typename": "LabeledEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'labeled' event.
                public var label: Label {
                  get {
                    return Label(snapshot: snapshot["label"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(color: String, name: String) {
                    self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return snapshot["color"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return snapshot["name"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asUnlabeledEvent: AsUnlabeledEvent? {
                get {
                  if !AsUnlabeledEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlabeledEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsUnlabeledEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("label", type: .nonNull(.object(Label.selections))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, label: Label, createdAt: String) {
                  self.init(snapshot: ["__typename": "UnlabeledEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "label": label.snapshot, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the label associated with the 'unlabeled' event.
                public var label: Label {
                  get {
                    return Label(snapshot: snapshot["label"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "label")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(color: String, name: String) {
                    self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the label color.
                  public var color: String {
                    get {
                      return snapshot["color"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "color")
                    }
                  }

                  /// Identifies the label name.
                  public var name: String {
                    get {
                      return snapshot["name"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "name")
                    }
                  }
                }
              }

              public var asClosedEvent: AsClosedEvent? {
                get {
                  if !AsClosedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsClosedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsClosedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ClosedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("closer", type: .object(Closer.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String, closer: Closer? = nil) {
                  self.init(snapshot: ["__typename": "ClosedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "closer": closer.flatMap { (value: Closer) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Object which triggered the creation of this event.
                public var closer: Closer? {
                  get {
                    return (snapshot["closer"] as? Snapshot).flatMap { Closer(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "closer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeCommit(oid: String) -> Closer {
                    return Closer(snapshot: ["__typename": "Commit", "oid": oid])
                  }

                  public static func makePullRequest(mergeCommit: AsPullRequest.MergeCommit? = nil) -> Closer {
                    return Closer(snapshot: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: AsPullRequest.MergeCommit) -> Snapshot in value.snapshot }])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asCommit: AsCommit? {
                    get {
                      if !AsCommit.possibleTypes.contains(__typename) { return nil }
                      return AsCommit(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct AsCommit: GraphQLSelectionSet {
                    public static let possibleTypes = ["Commit"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(oid: String) {
                      self.init(snapshot: ["__typename": "Commit", "oid": oid])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The Git object ID
                    public var oid: String {
                      get {
                        return snapshot["oid"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "oid")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct AsPullRequest: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequest"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("mergeCommit", type: .object(MergeCommit.selections)),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(mergeCommit: MergeCommit? = nil) {
                      self.init(snapshot: ["__typename": "PullRequest", "mergeCommit": mergeCommit.flatMap { (value: MergeCommit) -> Snapshot in value.snapshot }])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The commit that was created when this pull request was merged.
                    public var mergeCommit: MergeCommit? {
                      get {
                        return (snapshot["mergeCommit"] as? Snapshot).flatMap { MergeCommit(snapshot: $0) }
                      }
                      set {
                        snapshot.updateValue(newValue?.snapshot, forKey: "mergeCommit")
                      }
                    }

                    public struct MergeCommit: GraphQLSelectionSet {
                      public static let possibleTypes = ["Commit"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(oid: String) {
                        self.init(snapshot: ["__typename": "Commit", "oid": oid])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The Git object ID
                      public var oid: String {
                        get {
                          return snapshot["oid"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "oid")
                        }
                      }
                    }
                  }
                }
              }

              public var asReopenedEvent: AsReopenedEvent? {
                get {
                  if !AsReopenedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReopenedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsReopenedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReopenedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String) {
                  self.init(snapshot: ["__typename": "ReopenedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asRenamedTitleEvent: AsRenamedTitleEvent? {
                get {
                  if !AsRenamedTitleEvent.possibleTypes.contains(__typename) { return nil }
                  return AsRenamedTitleEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsRenamedTitleEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["RenamedTitleEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("previousTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String, currentTitle: String, previousTitle: String) {
                  self.init(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "currentTitle": currentTitle, "previousTitle": previousTitle])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the current title of the issue or pull request.
                public var currentTitle: String {
                  get {
                    return snapshot["currentTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "currentTitle")
                  }
                }

                /// Identifies the previous title of the issue or pull request.
                public var previousTitle: String {
                  get {
                    return snapshot["previousTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "previousTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asLockedEvent: AsLockedEvent? {
                get {
                  if !AsLockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsLockedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsLockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["LockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String) {
                  self.init(snapshot: ["__typename": "LockedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnlockedEvent: AsUnlockedEvent? {
                get {
                  if !AsUnlockedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnlockedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsUnlockedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnlockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String) {
                  self.init(snapshot: ["__typename": "UnlockedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asMergedEvent: AsMergedEvent? {
                get {
                  if !AsMergedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsMergedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsMergedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["MergedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("commit", alias: "mergedCommit", type: .object(MergedCommit.selections)),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, mergedCommit: MergedCommit? = nil, actor: Actor? = nil, createdAt: String) {
                  self.init(snapshot: ["__typename": "MergedEvent", "id": id, "mergedCommit": mergedCommit.flatMap { (value: MergedCommit) -> Snapshot in value.snapshot }, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the commit associated with the `merge` event.
                public var mergedCommit: MergedCommit? {
                  get {
                    return (snapshot["mergedCommit"] as? Snapshot).flatMap { MergedCommit(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "mergedCommit")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct MergedCommit: GraphQLSelectionSet {
                  public static let possibleTypes = ["Commit"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(oid: String) {
                    self.init(snapshot: ["__typename": "Commit", "oid": oid])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The Git object ID
                  public var oid: String {
                    get {
                      return snapshot["oid"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "oid")
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asPullRequestReviewThread: AsPullRequestReviewThread? {
                get {
                  if !AsPullRequestReviewThread.possibleTypes.contains(__typename) { return nil }
                  return AsPullRequestReviewThread(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsPullRequestReviewThread: GraphQLSelectionSet {
                public static let possibleTypes = ["PullRequestReviewThread"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("comments", arguments: ["first": GraphQLVariable("page_size")], type: .nonNull(.object(Comment.selections))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(comments: Comment) {
                  self.init(snapshot: ["__typename": "PullRequestReviewThread", "comments": comments.snapshot])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A list of pull request comments associated with the thread.
                public var comments: Comment {
                  get {
                    return Comment(snapshot: snapshot["comments"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "comments")
                  }
                }

                public struct Comment: GraphQLSelectionSet {
                  public static let possibleTypes = ["PullRequestReviewCommentConnection"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("nodes", type: .list(.object(Node.selections))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(nodes: [Node?]? = nil) {
                    self.init(snapshot: ["__typename": "PullRequestReviewCommentConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// A list of nodes.
                  public var nodes: [Node?]? {
                    get {
                      return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
                    }
                    set {
                      snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
                    }
                  }

                  public struct Node: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequestReviewComment"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("author", type: .object(Author.selections)),
                      GraphQLField("editor", type: .object(Editor.selections)),
                      GraphQLField("lastEditedAt", type: .scalar(String.self)),
                      GraphQLField("body", type: .nonNull(.scalar(String.self))),
                      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                      GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("path", type: .nonNull(.scalar(String.self))),
                      GraphQLField("diffHunk", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, id: GraphQLID, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, path: String, diffHunk: String) {
                      self.init(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, "id": id, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "path": path, "diffHunk": diffHunk])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Can user react to this subject
                    public var viewerCanReact: Bool {
                      get {
                        return snapshot["viewerCanReact"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "viewerCanReact")
                      }
                    }

                    /// A list of reactions grouped by content left on the subject.
                    public var reactionGroups: [ReactionGroup]? {
                      get {
                        return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
                      }
                      set {
                        snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
                      }
                    }

                    /// ID of the object.
                    public var id: GraphQLID {
                      get {
                        return snapshot["id"]! as! GraphQLID
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "id")
                      }
                    }

                    /// The actor who authored the comment.
                    public var author: Author? {
                      get {
                        return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
                      }
                      set {
                        snapshot.updateValue(newValue?.snapshot, forKey: "author")
                      }
                    }

                    /// The actor who edited the comment.
                    public var editor: Editor? {
                      get {
                        return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
                      }
                      set {
                        snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                      }
                    }

                    /// The moment the editor made the last edit
                    public var lastEditedAt: String? {
                      get {
                        return snapshot["lastEditedAt"] as? String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "lastEditedAt")
                      }
                    }

                    /// The comment body of this review comment.
                    public var body: String {
                      get {
                        return snapshot["body"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "body")
                      }
                    }

                    /// Identifies when the comment was created.
                    public var createdAt: String {
                      get {
                        return snapshot["createdAt"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "createdAt")
                      }
                    }

                    /// Did the viewer author this comment.
                    public var viewerDidAuthor: Bool {
                      get {
                        return snapshot["viewerDidAuthor"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
                      }
                    }

                    /// The path to which the comment applies.
                    public var path: String {
                      get {
                        return snapshot["path"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "path")
                      }
                    }

                    /// The diff hunk to which the comment applies.
                    public var diffHunk: String {
                      get {
                        return snapshot["diffHunk"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "diffHunk")
                      }
                    }

                    public var fragments: Fragments {
                      get {
                        return Fragments(snapshot: snapshot)
                      }
                      set {
                        snapshot += newValue.snapshot
                      }
                    }

                    public struct Fragments {
                      public var snapshot: Snapshot

                      public var reactionFields: ReactionFields {
                        get {
                          return ReactionFields(snapshot: snapshot)
                        }
                        set {
                          snapshot += newValue.snapshot
                        }
                      }

                      public var nodeFields: NodeFields {
                        get {
                          return NodeFields(snapshot: snapshot)
                        }
                        set {
                          snapshot += newValue.snapshot
                        }
                      }

                      public var commentFields: CommentFields {
                        get {
                          return CommentFields(snapshot: snapshot)
                        }
                        set {
                          snapshot += newValue.snapshot
                        }
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

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
                        self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// Whether or not the authenticated user has left a reaction on the subject.
                      public var viewerHasReacted: Bool {
                        get {
                          return snapshot["viewerHasReacted"]! as! Bool
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "viewerHasReacted")
                        }
                      }

                      /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
                      public var users: User {
                        get {
                          return User(snapshot: snapshot["users"]! as! Snapshot)
                        }
                        set {
                          snapshot.updateValue(newValue.snapshot, forKey: "users")
                        }
                      }

                      /// Identifies the emoji reaction.
                      public var content: ReactionContent {
                        get {
                          return snapshot["content"]! as! ReactionContent
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "content")
                        }
                      }

                      public struct User: GraphQLSelectionSet {
                        public static let possibleTypes = ["ReactingUserConnection"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("nodes", type: .list(.object(Node.selections))),
                          GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                        ]

                        public var snapshot: Snapshot

                        public init(snapshot: Snapshot) {
                          self.snapshot = snapshot
                        }

                        public init(nodes: [Node?]? = nil, totalCount: Int) {
                          self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
                        }

                        public var __typename: String {
                          get {
                            return snapshot["__typename"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// A list of nodes.
                        public var nodes: [Node?]? {
                          get {
                            return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
                          }
                          set {
                            snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
                          }
                        }

                        /// Identifies the total count of items in the connection.
                        public var totalCount: Int {
                          get {
                            return snapshot["totalCount"]! as! Int
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "totalCount")
                          }
                        }

                        public struct Node: GraphQLSelectionSet {
                          public static let possibleTypes = ["User"]

                          public static let selections: [GraphQLSelection] = [
                            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                            GraphQLField("login", type: .nonNull(.scalar(String.self))),
                          ]

                          public var snapshot: Snapshot

                          public init(snapshot: Snapshot) {
                            self.snapshot = snapshot
                          }

                          public init(login: String) {
                            self.init(snapshot: ["__typename": "User", "login": login])
                          }

                          public var __typename: String {
                            get {
                              return snapshot["__typename"]! as! String
                            }
                            set {
                              snapshot.updateValue(newValue, forKey: "__typename")
                            }
                          }

                          /// The username used to login.
                          public var login: String {
                            get {
                              return snapshot["login"]! as! String
                            }
                            set {
                              snapshot.updateValue(newValue, forKey: "login")
                            }
                          }
                        }
                      }
                    }

                    public struct Author: GraphQLSelectionSet {
                      public static let possibleTypes = ["Organization", "User", "Bot"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                        return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                      }

                      public static func makeUser(login: String, avatarUrl: String) -> Author {
                        return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                      }

                      public static func makeBot(login: String, avatarUrl: String) -> Author {
                        return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The username of the actor.
                      public var login: String {
                        get {
                          return snapshot["login"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "login")
                        }
                      }

                      /// A URL pointing to the actor's public avatar.
                      public var avatarUrl: String {
                        get {
                          return snapshot["avatarUrl"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "avatarUrl")
                        }
                      }
                    }

                    public struct Editor: GraphQLSelectionSet {
                      public static let possibleTypes = ["Organization", "User", "Bot"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("login", type: .nonNull(.scalar(String.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public static func makeOrganization(login: String) -> Editor {
                        return Editor(snapshot: ["__typename": "Organization", "login": login])
                      }

                      public static func makeUser(login: String) -> Editor {
                        return Editor(snapshot: ["__typename": "User", "login": login])
                      }

                      public static func makeBot(login: String) -> Editor {
                        return Editor(snapshot: ["__typename": "Bot", "login": login])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The username of the actor.
                      public var login: String {
                        get {
                          return snapshot["login"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "login")
                        }
                      }
                    }
                  }
                }
              }

              public var asPullRequestReview: AsPullRequestReview? {
                get {
                  if !AsPullRequestReview.possibleTypes.contains(__typename) { return nil }
                  return AsPullRequestReview(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsPullRequestReview: GraphQLSelectionSet {
                public static let possibleTypes = ["PullRequestReview"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("editor", type: .object(Editor.selections)),
                  GraphQLField("lastEditedAt", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("state", type: .nonNull(.scalar(PullRequestReviewState.self))),
                  GraphQLField("submittedAt", type: .scalar(String.self)),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("comments", type: .nonNull(.object(Comment.selections))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, state: PullRequestReviewState, submittedAt: String? = nil, comments: Comment) {
                  self.init(snapshot: ["__typename": "PullRequestReview", "id": id, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "state": state, "submittedAt": submittedAt, "comments": comments.snapshot])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// The actor who authored the comment.
                public var author: Author? {
                  get {
                    return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
                  }
                }

                /// The actor who edited the comment.
                public var editor: Editor? {
                  get {
                    return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                  }
                }

                /// The moment the editor made the last edit
                public var lastEditedAt: String? {
                  get {
                    return snapshot["lastEditedAt"] as? String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "lastEditedAt")
                  }
                }

                /// Identifies the pull request review body.
                public var body: String {
                  get {
                    return snapshot["body"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "body")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Did the viewer author this comment.
                public var viewerDidAuthor: Bool {
                  get {
                    return snapshot["viewerDidAuthor"]! as! Bool
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
                  }
                }

                /// Identifies the current state of the pull request review.
                public var state: PullRequestReviewState {
                  get {
                    return snapshot["state"]! as! PullRequestReviewState
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "state")
                  }
                }

                /// Identifies when the Pull Request Review was submitted
                public var submittedAt: String? {
                  get {
                    return snapshot["submittedAt"] as? String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "submittedAt")
                  }
                }

                /// A list of review comments for the current pull request review.
                public var comments: Comment {
                  get {
                    return Comment(snapshot: snapshot["comments"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "comments")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                  }

                  public static func makeUser(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                  }

                  public static func makeBot(login: String, avatarUrl: String) -> Author {
                    return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }

                  /// A URL pointing to the actor's public avatar.
                  public var avatarUrl: String {
                    get {
                      return snapshot["avatarUrl"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "avatarUrl")
                    }
                  }
                }

                public struct Editor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Editor {
                    return Editor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct Comment: GraphQLSelectionSet {
                  public static let possibleTypes = ["PullRequestReviewCommentConnection"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(totalCount: Int) {
                    self.init(snapshot: ["__typename": "PullRequestReviewCommentConnection", "totalCount": totalCount])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the total count of items in the connection.
                  public var totalCount: Int {
                    get {
                      return snapshot["totalCount"]! as! Int
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "totalCount")
                    }
                  }
                }
              }

              public var asCrossReferencedEvent: AsCrossReferencedEvent? {
                get {
                  if !AsCrossReferencedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsCrossReferencedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsCrossReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["CrossReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("source", type: .nonNull(.object(Source.selections))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, actor: Actor? = nil, createdAt: String, source: Source) {
                  self.init(snapshot: ["__typename": "CrossReferencedEvent", "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "createdAt": createdAt, "source": source.snapshot])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Issue or pull request that made the reference.
                public var source: Source {
                  get {
                    return Source(snapshot: snapshot["source"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "source")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool, repository: AsIssue.Repository) -> Source {
                    return Source(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.snapshot])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool, repository: AsPullRequest.Repository) -> Source {
                    return Source(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.snapshot])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool, repository: Repository) {
                      self.init(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed, "repository": repository.snapshot])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(snapshot: snapshot["repository"]! as! Snapshot)
                      }
                      set {
                        snapshot.updateValue(newValue.snapshot, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(name: String, owner: Owner) {
                        self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner.snapshot])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return snapshot["name"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(snapshot: snapshot["owner"]! as! Snapshot)
                        }
                        set {
                          snapshot.updateValue(newValue.snapshot, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public var snapshot: Snapshot

                        public init(snapshot: Snapshot) {
                          self.snapshot = snapshot
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return snapshot["__typename"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return snapshot["login"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "login")
                          }
                        }
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool, repository: Repository) {
                      self.init(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged, "repository": repository.snapshot])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return snapshot["merged"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "merged")
                      }
                    }

                    /// The repository associated with this node.
                    public var repository: Repository {
                      get {
                        return Repository(snapshot: snapshot["repository"]! as! Snapshot)
                      }
                      set {
                        snapshot.updateValue(newValue.snapshot, forKey: "repository")
                      }
                    }

                    public struct Repository: GraphQLSelectionSet {
                      public static let possibleTypes = ["Repository"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(name: String, owner: Owner) {
                        self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner.snapshot])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The name of the repository.
                      public var name: String {
                        get {
                          return snapshot["name"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The User owner of the repository.
                      public var owner: Owner {
                        get {
                          return Owner(snapshot: snapshot["owner"]! as! Snapshot)
                        }
                        set {
                          snapshot.updateValue(newValue.snapshot, forKey: "owner")
                        }
                      }

                      public struct Owner: GraphQLSelectionSet {
                        public static let possibleTypes = ["Organization", "User"]

                        public static let selections: [GraphQLSelection] = [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        ]

                        public var snapshot: Snapshot

                        public init(snapshot: Snapshot) {
                          self.snapshot = snapshot
                        }

                        public static func makeOrganization(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "Organization", "login": login])
                        }

                        public static func makeUser(login: String) -> Owner {
                          return Owner(snapshot: ["__typename": "User", "login": login])
                        }

                        public var __typename: String {
                          get {
                            return snapshot["__typename"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username used to login.
                        public var login: String {
                          get {
                            return snapshot["login"]! as! String
                          }
                          set {
                            snapshot.updateValue(newValue, forKey: "login")
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
                  return AsReferencedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsReferencedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("commitRepository", type: .nonNull(.object(CommitRepository.selections))),
                  GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(createdAt: String, id: GraphQLID, actor: Actor? = nil, commitRepository: CommitRepository, subject: Subject) {
                  self.init(snapshot: ["__typename": "ReferencedEvent", "createdAt": createdAt, "id": id, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "commitRepository": commitRepository.snapshot, "subject": subject.snapshot])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the repository associated with the 'referenced' event.
                public var commitRepository: CommitRepository {
                  get {
                    return CommitRepository(snapshot: snapshot["commitRepository"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "commitRepository")
                  }
                }

                /// Object referenced by event.
                public var subject: Subject {
                  get {
                    return Subject(snapshot: snapshot["subject"]! as! Snapshot)
                  }
                  set {
                    snapshot.updateValue(newValue.snapshot, forKey: "subject")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct CommitRepository: GraphQLSelectionSet {
                  public static let possibleTypes = ["Repository"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(name: String, owner: Owner) {
                    self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner.snapshot])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The name of the repository.
                  public var name: String {
                    get {
                      return snapshot["name"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "name")
                    }
                  }

                  /// The User owner of the repository.
                  public var owner: Owner {
                    get {
                      return Owner(snapshot: snapshot["owner"]! as! Snapshot)
                    }
                    set {
                      snapshot.updateValue(newValue.snapshot, forKey: "owner")
                    }
                  }

                  public var fragments: Fragments {
                    get {
                      return Fragments(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }

                  public struct Fragments {
                    public var snapshot: Snapshot

                    public var referencedRepositoryFields: ReferencedRepositoryFields {
                      get {
                        return ReferencedRepositoryFields(snapshot: snapshot)
                      }
                      set {
                        snapshot += newValue.snapshot
                      }
                    }
                  }

                  public struct Owner: GraphQLSelectionSet {
                    public static let possibleTypes = ["Organization", "User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public static func makeOrganization(login: String) -> Owner {
                      return Owner(snapshot: ["__typename": "Organization", "login": login])
                    }

                    public static func makeUser(login: String) -> Owner {
                      return Owner(snapshot: ["__typename": "User", "login": login])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return snapshot["login"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeIssue(title: String, number: Int, closed: Bool) -> Subject {
                    return Subject(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                  }

                  public static func makePullRequest(title: String, number: Int, closed: Bool, merged: Bool) -> Subject {
                    return Subject(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asIssue: AsIssue? {
                    get {
                      if !AsIssue.possibleTypes.contains(__typename) { return nil }
                      return AsIssue(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool) {
                      self.init(snapshot: ["__typename": "Issue", "title": title, "number": number, "closed": closed])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the issue title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the issue number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the object is closed (definition of closed may depend on type)
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }
                  }

                  public var asPullRequest: AsPullRequest? {
                    get {
                      if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
                      return AsPullRequest(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(title: String, number: Int, closed: Bool, merged: Bool) {
                      self.init(snapshot: ["__typename": "PullRequest", "title": title, "number": number, "closed": closed, "merged": merged])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the pull request title.
                    public var title: String {
                      get {
                        return snapshot["title"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "title")
                      }
                    }

                    /// Identifies the pull request number.
                    public var number: Int {
                      get {
                        return snapshot["number"]! as! Int
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "number")
                      }
                    }

                    /// `true` if the pull request is closed
                    public var closed: Bool {
                      get {
                        return snapshot["closed"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "closed")
                      }
                    }

                    /// Whether or not the pull request was merged.
                    public var merged: Bool {
                      get {
                        return snapshot["merged"]! as! Bool
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "merged")
                      }
                    }
                  }
                }
              }

              public var asAssignedEvent: AsAssignedEvent? {
                get {
                  if !AsAssignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsAssignedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsAssignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["AssignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the user who was assigned.
                public var user: User? {
                  get {
                    return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(login: String) {
                    self.init(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asUnassignedEvent: AsUnassignedEvent? {
                get {
                  if !AsUnassignedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsUnassignedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsUnassignedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["UnassignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the subject (user) who was unassigned.
                public var user: User? {
                  get {
                    return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "user")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(login: String) {
                    self.init(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asReviewRequestedEvent: AsReviewRequestedEvent? {
                get {
                  if !AsReviewRequestedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReviewRequestedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsReviewRequestedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReviewRequestedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, requestedReviewer: RequestedReviewer? = nil) {
                  self.init(snapshot: ["__typename": "ReviewRequestedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "requestedReviewer": requestedReviewer.flatMap { (value: RequestedReviewer) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the reviewer whose review was requested.
                public var requestedReviewer: RequestedReviewer? {
                  get {
                    return (snapshot["requestedReviewer"] as? Snapshot).flatMap { RequestedReviewer(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "requestedReviewer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeTeam() -> RequestedReviewer {
                    return RequestedReviewer(snapshot: ["__typename": "Team"])
                  }

                  public static func makeUser(login: String) -> RequestedReviewer {
                    return RequestedReviewer(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asUser: AsUser? {
                    get {
                      if !AsUser.possibleTypes.contains(__typename) { return nil }
                      return AsUser(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct AsUser: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(login: String) {
                      self.init(snapshot: ["__typename": "User", "login": login])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return snapshot["login"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "login")
                      }
                    }
                  }
                }
              }

              public var asReviewRequestRemovedEvent: AsReviewRequestRemovedEvent? {
                get {
                  if !AsReviewRequestRemovedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsReviewRequestRemovedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsReviewRequestRemovedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["ReviewRequestRemovedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, requestedReviewer: RequestedReviewer? = nil) {
                  self.init(snapshot: ["__typename": "ReviewRequestRemovedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "requestedReviewer": requestedReviewer.flatMap { (value: RequestedReviewer) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the reviewer whose review request was removed.
                public var requestedReviewer: RequestedReviewer? {
                  get {
                    return (snapshot["requestedReviewer"] as? Snapshot).flatMap { RequestedReviewer(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "requestedReviewer")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeTeam() -> RequestedReviewer {
                    return RequestedReviewer(snapshot: ["__typename": "Team"])
                  }

                  public static func makeUser(login: String) -> RequestedReviewer {
                    return RequestedReviewer(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var asUser: AsUser? {
                    get {
                      if !AsUser.possibleTypes.contains(__typename) { return nil }
                      return AsUser(snapshot: snapshot)
                    }
                    set {
                      guard let newValue = newValue else { return }
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct AsUser: GraphQLSelectionSet {
                    public static let possibleTypes = ["User"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(login: String) {
                      self.init(snapshot: ["__typename": "User", "login": login])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username used to login.
                    public var login: String {
                      get {
                        return snapshot["login"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "login")
                      }
                    }
                  }
                }
              }

              public var asMilestonedEvent: AsMilestonedEvent? {
                get {
                  if !AsMilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsMilestonedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsMilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["MilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'milestoned' event.
                public var milestoneTitle: String {
                  get {
                    return snapshot["milestoneTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }
                }
              }

              public var asDemilestonedEvent: AsDemilestonedEvent? {
                get {
                  if !AsDemilestonedEvent.possibleTypes.contains(__typename) { return nil }
                  return AsDemilestonedEvent(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsDemilestonedEvent: GraphQLSelectionSet {
                public static let possibleTypes = ["DemilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.selections)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor.flatMap { (value: Actor) -> Snapshot in value.snapshot }, "milestoneTitle": milestoneTitle])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the object.
                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Identifies the date and time when the object was created.
                public var createdAt: String {
                  get {
                    return snapshot["createdAt"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// Identifies the actor who performed the event.
                public var actor: Actor? {
                  get {
                    return (snapshot["actor"] as? Snapshot).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the milestone title associated with the 'demilestoned' event.
                public var milestoneTitle: String {
                  get {
                    return snapshot["milestoneTitle"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "milestoneTitle")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Actor: GraphQLSelectionSet {
                  public static let possibleTypes = ["Organization", "User", "Bot"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public static func makeOrganization(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Organization", "login": login])
                  }

                  public static func makeUser(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "User", "login": login])
                  }

                  public static func makeBot(login: String) -> Actor {
                    return Actor(snapshot: ["__typename": "Bot", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username of the actor.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "ReviewRequestConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["ReviewRequest"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(requestedReviewer: RequestedReviewer? = nil) {
                self.init(snapshot: ["__typename": "ReviewRequest", "requestedReviewer": requestedReviewer.flatMap { (value: RequestedReviewer) -> Snapshot in value.snapshot }])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The reviewer that is requested.
              public var requestedReviewer: RequestedReviewer? {
                get {
                  return (snapshot["requestedReviewer"] as? Snapshot).flatMap { RequestedReviewer(snapshot: $0) }
                }
                set {
                  snapshot.updateValue(newValue?.snapshot, forKey: "requestedReviewer")
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

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public static func makeTeam() -> RequestedReviewer {
                  return RequestedReviewer(snapshot: ["__typename": "Team"])
                }

                public static func makeUser(login: String, avatarUrl: String) -> RequestedReviewer {
                  return RequestedReviewer(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var asUser: AsUser? {
                  get {
                    if !AsUser.possibleTypes.contains(__typename) { return nil }
                    return AsUser(snapshot: snapshot)
                  }
                  set {
                    guard let newValue = newValue else { return }
                    snapshot = newValue.snapshot
                  }
                }

                public struct AsUser: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(login: String, avatarUrl: String) {
                    self.init(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
                    }
                  }

                  /// A URL pointing to the user's public avatar.
                  public var avatarUrl: String {
                    get {
                      return snapshot["avatarUrl"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "avatarUrl")
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "PullRequestCommitConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["PullRequestCommit"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("commit", type: .nonNull(.object(Commit.selections))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(commit: Commit) {
                self.init(snapshot: ["__typename": "PullRequestCommit", "commit": commit.snapshot])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The Git commit object
              public var commit: Commit {
                get {
                  return Commit(snapshot: snapshot["commit"]! as! Snapshot)
                }
                set {
                  snapshot.updateValue(newValue.snapshot, forKey: "commit")
                }
              }

              public struct Commit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("status", type: .object(Status.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, status: Status? = nil) {
                  self.init(snapshot: ["__typename": "Commit", "id": id, "status": status.flatMap { (value: Status) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return snapshot["id"]! as! GraphQLID
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "id")
                  }
                }

                /// Status information for this commit
                public var status: Status? {
                  get {
                    return (snapshot["status"] as? Snapshot).flatMap { Status(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "status")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot += newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var commitContext: CommitContext {
                    get {
                      return CommitContext(snapshot: snapshot)
                    }
                    set {
                      snapshot += newValue.snapshot
                    }
                  }
                }

                public struct Status: GraphQLSelectionSet {
                  public static let possibleTypes = ["Status"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("contexts", type: .nonNull(.list(.nonNull(.object(Context.selections))))),
                    GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(contexts: [Context], state: StatusState) {
                    self.init(snapshot: ["__typename": "Status", "contexts": contexts.map { (value: Context) -> Snapshot in value.snapshot }, "state": state])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The individual status contexts for this commit.
                  public var contexts: [Context] {
                    get {
                      return (snapshot["contexts"] as! [Snapshot]).map { (value: Snapshot) -> Context in Context(snapshot: value) }
                    }
                    set {
                      snapshot.updateValue(newValue.map { (value: Context) -> Snapshot in value.snapshot }, forKey: "contexts")
                    }
                  }

                  /// The combined commit status.
                  public var state: StatusState {
                    get {
                      return snapshot["state"]! as! StatusState
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "state")
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

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(id: GraphQLID, context: String, state: StatusState, creator: Creator? = nil, description: String? = nil, targetUrl: String? = nil) {
                      self.init(snapshot: ["__typename": "StatusContext", "id": id, "context": context, "state": state, "creator": creator.flatMap { (value: Creator) -> Snapshot in value.snapshot }, "description": description, "targetUrl": targetUrl])
                    }

                    public var __typename: String {
                      get {
                        return snapshot["__typename"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    public var id: GraphQLID {
                      get {
                        return snapshot["id"]! as! GraphQLID
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "id")
                      }
                    }

                    /// The name of this status context.
                    public var context: String {
                      get {
                        return snapshot["context"]! as! String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "context")
                      }
                    }

                    /// The state of this status context.
                    public var state: StatusState {
                      get {
                        return snapshot["state"]! as! StatusState
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "state")
                      }
                    }

                    /// The actor who created this status context.
                    public var creator: Creator? {
                      get {
                        return (snapshot["creator"] as? Snapshot).flatMap { Creator(snapshot: $0) }
                      }
                      set {
                        snapshot.updateValue(newValue?.snapshot, forKey: "creator")
                      }
                    }

                    /// The description for this status context.
                    public var description: String? {
                      get {
                        return snapshot["description"] as? String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "description")
                      }
                    }

                    /// The URL for this status context.
                    public var targetUrl: String? {
                      get {
                        return snapshot["targetUrl"] as? String
                      }
                      set {
                        snapshot.updateValue(newValue, forKey: "targetUrl")
                      }
                    }

                    public struct Creator: GraphQLSelectionSet {
                      public static let possibleTypes = ["Organization", "User", "Bot"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public static func makeOrganization(login: String, avatarUrl: String) -> Creator {
                        return Creator(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                      }

                      public static func makeUser(login: String, avatarUrl: String) -> Creator {
                        return Creator(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                      }

                      public static func makeBot(login: String, avatarUrl: String) -> Creator {
                        return Creator(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                      }

                      public var __typename: String {
                        get {
                          return snapshot["__typename"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The username of the actor.
                      public var login: String {
                        get {
                          return snapshot["login"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "login")
                        }
                      }

                      /// A URL pointing to the actor's public avatar.
                      public var avatarUrl: String {
                        get {
                          return snapshot["avatarUrl"]! as! String
                        }
                        set {
                          snapshot.updateValue(newValue, forKey: "avatarUrl")
                        }
                      }
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
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("number", type: .nonNull(.scalar(Int.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
              GraphQLField("dueOn", type: .scalar(String.self)),
              GraphQLField("issues", alias: "openCount", arguments: ["states": ["OPEN"]], type: .nonNull(.object(OpenCount.selections))),
              GraphQLField("issues", alias: "totalCount", type: .nonNull(.object(TotalCount.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(number: Int, title: String, url: String, dueOn: String? = nil, openCount: OpenCount, totalCount: TotalCount) {
              self.init(snapshot: ["__typename": "Milestone", "number": number, "title": title, "url": url, "dueOn": dueOn, "openCount": openCount.snapshot, "totalCount": totalCount.snapshot])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the number of the milestone.
            public var number: Int {
              get {
                return snapshot["number"]! as! Int
              }
              set {
                snapshot.updateValue(newValue, forKey: "number")
              }
            }

            /// Identifies the title of the milestone.
            public var title: String {
              get {
                return snapshot["title"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "title")
              }
            }

            /// The HTTP URL for this milestone
            public var url: String {
              get {
                return snapshot["url"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "url")
              }
            }

            /// Identifies the due date of the milestone.
            public var dueOn: String? {
              get {
                return snapshot["dueOn"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "dueOn")
              }
            }

            /// A list of issues associated with the milestone.
            public var openCount: OpenCount {
              get {
                return OpenCount(snapshot: snapshot["openCount"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "openCount")
              }
            }

            /// A list of issues associated with the milestone.
            public var totalCount: TotalCount {
              get {
                return TotalCount(snapshot: snapshot["totalCount"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "totalCount")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var milestoneFields: MilestoneFields {
                get {
                  return MilestoneFields(snapshot: snapshot)
                }
                set {
                  snapshot += newValue.snapshot
                }
              }
            }

            public struct OpenCount: GraphQLSelectionSet {
              public static let possibleTypes = ["IssueConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(totalCount: Int) {
                self.init(snapshot: ["__typename": "IssueConnection", "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }
            }

            public struct TotalCount: GraphQLSelectionSet {
              public static let possibleTypes = ["IssueConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(totalCount: Int) {
                self.init(snapshot: ["__typename": "IssueConnection", "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
              self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Whether or not the authenticated user has left a reaction on the subject.
            public var viewerHasReacted: Bool {
              get {
                return snapshot["viewerHasReacted"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerHasReacted")
              }
            }

            /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
            public var users: User {
              get {
                return User(snapshot: snapshot["users"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "users")
              }
            }

            /// Identifies the emoji reaction.
            public var content: ReactionContent {
              get {
                return snapshot["content"]! as! ReactionContent
              }
              set {
                snapshot.updateValue(newValue, forKey: "content")
              }
            }

            public struct User: GraphQLSelectionSet {
              public static let possibleTypes = ["ReactingUserConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(nodes: [Node?]? = nil, totalCount: Int) {
                self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of nodes.
              public var nodes: [Node?]? {
                get {
                  return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
                }
                set {
                  snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("login", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(login: String) {
                  self.init(snapshot: ["__typename": "User", "login": login])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The username used to login.
                public var login: String {
                  get {
                    return snapshot["login"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "login")
                  }
                }
              }
            }
          }

          public struct Author: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
              GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
            }

            public static func makeUser(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
            }

            public static func makeBot(login: String, avatarUrl: String) -> Author {
              return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }

            /// A URL pointing to the actor's public avatar.
            public var avatarUrl: String {
              get {
                return snapshot["avatarUrl"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }
          }

          public struct Editor: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "User", "login": login])
            }

            public static func makeBot(login: String) -> Editor {
              return Editor(snapshot: ["__typename": "Bot", "login": login])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }
          }

          public struct Label: GraphQLSelectionSet {
            public static let possibleTypes = ["LabelConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Label"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("color", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(color: String, name: String) {
                self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the label color.
              public var color: String {
                get {
                  return snapshot["color"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "color")
                }
              }

              /// Identifies the label name.
              public var name: String {
                get {
                  return snapshot["name"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "name")
                }
              }
            }
          }

          public struct Assignee: GraphQLSelectionSet {
            public static let possibleTypes = ["UserConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["User"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("login", type: .nonNull(.scalar(String.self))),
                GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(login: String, avatarUrl: String) {
                self.init(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The username used to login.
              public var login: String {
                get {
                  return snapshot["login"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "login")
                }
              }

              /// A URL pointing to the user's public avatar.
              public var avatarUrl: String {
                get {
                  return snapshot["avatarUrl"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "avatarUrl")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class RemoveReactionMutation: GraphQLMutation {
  public static let operationString =
    "mutation RemoveReaction($subject_id: ID!, $content: ReactionContent!) {\n  removeReaction(input: {subjectId: $subject_id, content: $content}) {\n    __typename\n    subject {\n      __typename\n      ...reactionFields\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(ReactionFields.fragmentString) }

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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(removeReaction: RemoveReaction? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "removeReaction": removeReaction.flatMap { (value: RemoveReaction) -> Snapshot in value.snapshot }])
    }

    /// Removes a reaction from a subject.
    public var removeReaction: RemoveReaction? {
      get {
        return (snapshot["removeReaction"] as? Snapshot).flatMap { RemoveReaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "removeReaction")
      }
    }

    public struct RemoveReaction: GraphQLSelectionSet {
      public static let possibleTypes = ["RemoveReactionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(subject: Subject) {
        self.init(snapshot: ["__typename": "RemoveReactionPayload", "subject": subject.snapshot])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The reactable subject.
      public var subject: Subject {
        get {
          return Subject(snapshot: snapshot["subject"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "subject")
        }
      }

      public struct Subject: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "Issue", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makeCommitComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "CommitComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makePullRequest(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequest", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makeIssueComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "IssueComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public static func makePullRequestReviewComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Can user react to this subject
        public var viewerCanReact: Bool {
          get {
            return snapshot["viewerCanReact"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "viewerCanReact")
          }
        }

        /// A list of reactions grouped by content left on the subject.
        public var reactionGroups: [ReactionGroup]? {
          get {
            return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var reactionFields: ReactionFields {
            get {
              return ReactionFields(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
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

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
            self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Whether or not the authenticated user has left a reaction on the subject.
          public var viewerHasReacted: Bool {
            get {
              return snapshot["viewerHasReacted"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "viewerHasReacted")
            }
          }

          /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
          public var users: User {
            get {
              return User(snapshot: snapshot["users"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "users")
            }
          }

          /// Identifies the emoji reaction.
          public var content: ReactionContent {
            get {
              return snapshot["content"]! as! ReactionContent
            }
            set {
              snapshot.updateValue(newValue, forKey: "content")
            }
          }

          public struct User: GraphQLSelectionSet {
            public static let possibleTypes = ["ReactingUserConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
              GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil, totalCount: Int) {
              self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return snapshot["totalCount"]! as! Int
              }
              set {
                snapshot.updateValue(newValue, forKey: "totalCount")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["User"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("login", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(login: String) {
                self.init(snapshot: ["__typename": "User", "login": login])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The username used to login.
              public var login: String {
                get {
                  return snapshot["login"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "login")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class FetchRepositoryBranchesQuery: GraphQLQuery {
  public static let operationString =
    "query fetchRepositoryBranches($owner: String!, $name: String!) {\n  repository(owner: $owner, name: $name) {\n    __typename\n    refs(first: 50, refPrefix: \"refs/heads/\") {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          name\n        }\n      }\n    }\n  }\n}"

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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> Snapshot in value.snapshot }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"] as? Snapshot).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("refs", arguments: ["first": 50, "refPrefix": "refs/heads/"], type: .object(Ref.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(refs: Ref? = nil) {
        self.init(snapshot: ["__typename": "Repository", "refs": refs.flatMap { (value: Ref) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Fetch a list of refs from the repository
      public var refs: Ref? {
        get {
          return (snapshot["refs"] as? Snapshot).flatMap { Ref(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "refs")
        }
      }

      public struct Ref: GraphQLSelectionSet {
        public static let possibleTypes = ["RefConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil) {
          self.init(snapshot: ["__typename": "RefConnection", "edges": edges.flatMap { (value: [Edge?]) -> [Snapshot?] in value.map { (value: Edge?) -> Snapshot? in value.flatMap { (value: Edge) -> Snapshot in value.snapshot } } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Edge?] in value.map { (value: Snapshot?) -> Edge? in value.flatMap { (value: Snapshot) -> Edge in Edge(snapshot: value) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { (value: [Edge?]) -> [Snapshot?] in value.map { (value: Edge?) -> Snapshot? in value.flatMap { (value: Edge) -> Snapshot in value.snapshot } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["RefEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "RefEdge", "node": node.flatMap { (value: Node) -> Snapshot in value.snapshot }])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"] as? Snapshot).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Ref"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String) {
              self.init(snapshot: ["__typename": "Ref", "name": name])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The ref name.
            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }
    }
  }
}

public final class RepoFileQuery: GraphQLQuery {
  public static let operationString =
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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> Snapshot in value.snapshot }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"] as? Snapshot).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("object", arguments: ["expression": GraphQLVariable("branchAndPath")], type: .object(Object.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(object: Object? = nil) {
        self.init(snapshot: ["__typename": "Repository", "object": object.flatMap { (value: Object) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A Git object in the repository
      public var object: Object? {
        get {
          return (snapshot["object"] as? Snapshot).flatMap { Object(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "object")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeCommit() -> Object {
          return Object(snapshot: ["__typename": "Commit"])
        }

        public static func makeTree() -> Object {
          return Object(snapshot: ["__typename": "Tree"])
        }

        public static func makeTag() -> Object {
          return Object(snapshot: ["__typename": "Tag"])
        }

        public static func makeBlob(text: String? = nil) -> Object {
          return Object(snapshot: ["__typename": "Blob", "text": text])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asBlob: AsBlob? {
          get {
            if !AsBlob.possibleTypes.contains(__typename) { return nil }
            return AsBlob(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsBlob: GraphQLSelectionSet {
          public static let possibleTypes = ["Blob"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("text", type: .scalar(String.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(text: String? = nil) {
            self.init(snapshot: ["__typename": "Blob", "text": text])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// UTF8 text data or null if the Blob is binary
          public var text: String? {
            get {
              return snapshot["text"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "text")
            }
          }
        }
      }
    }
  }
}

public final class RepoFileHistoryQuery: GraphQLQuery {
  public static let operationString =
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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> Snapshot in value.snapshot }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"] as? Snapshot).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("object", arguments: ["expression": GraphQLVariable("branch")], type: .object(Object.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(object: Object? = nil) {
        self.init(snapshot: ["__typename": "Repository", "object": object.flatMap { (value: Object) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A Git object in the repository
      public var object: Object? {
        get {
          return (snapshot["object"] as? Snapshot).flatMap { Object(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "object")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeTree() -> Object {
          return Object(snapshot: ["__typename": "Tree"])
        }

        public static func makeBlob() -> Object {
          return Object(snapshot: ["__typename": "Blob"])
        }

        public static func makeTag() -> Object {
          return Object(snapshot: ["__typename": "Tag"])
        }

        public static func makeCommit(history: AsCommit.History) -> Object {
          return Object(snapshot: ["__typename": "Commit", "history": history.snapshot])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asCommit: AsCommit? {
          get {
            if !AsCommit.possibleTypes.contains(__typename) { return nil }
            return AsCommit(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsCommit: GraphQLSelectionSet {
          public static let possibleTypes = ["Commit"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("history", arguments: ["after": GraphQLVariable("after"), "path": GraphQLVariable("path"), "first": GraphQLVariable("page_size")], type: .nonNull(.object(History.selections))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(history: History) {
            self.init(snapshot: ["__typename": "Commit", "history": history.snapshot])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The linear commit history starting from (and including) this commit, in the same order as `git log`.
          public var history: History {
            get {
              return History(snapshot: snapshot["history"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "history")
            }
          }

          public struct History: GraphQLSelectionSet {
            public static let possibleTypes = ["CommitHistoryConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
              self.init(snapshot: ["__typename": "CommitHistoryConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "pageInfo": pageInfo.snapshot])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            /// Information to aid in pagination.
            public var pageInfo: PageInfo {
              get {
                return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
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

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(message: String, oid: String, committedDate: String, url: String, author: Author? = nil, committer: Committer? = nil) {
                self.init(snapshot: ["__typename": "Commit", "message": message, "oid": oid, "committedDate": committedDate, "url": url, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "committer": committer.flatMap { (value: Committer) -> Snapshot in value.snapshot }])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The Git commit message
              public var message: String {
                get {
                  return snapshot["message"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "message")
                }
              }

              /// The Git object ID
              public var oid: String {
                get {
                  return snapshot["oid"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "oid")
                }
              }

              /// The datetime when this commit was committed.
              public var committedDate: String {
                get {
                  return snapshot["committedDate"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "committedDate")
                }
              }

              /// The HTTP URL for this commit
              public var url: String {
                get {
                  return snapshot["url"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "url")
                }
              }

              /// Authorship details of the commit.
              public var author: Author? {
                get {
                  return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
                }
                set {
                  snapshot.updateValue(newValue?.snapshot, forKey: "author")
                }
              }

              /// Committership details of the commit.
              public var committer: Committer? {
                get {
                  return (snapshot["committer"] as? Snapshot).flatMap { Committer(snapshot: $0) }
                }
                set {
                  snapshot.updateValue(newValue?.snapshot, forKey: "committer")
                }
              }

              public struct Author: GraphQLSelectionSet {
                public static let possibleTypes = ["GitActor"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("user", type: .object(User.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(user: User? = nil) {
                  self.init(snapshot: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The GitHub user corresponding to the email field. Null if no such user exists.
                public var user: User? {
                  get {
                    return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "user")
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(login: String) {
                    self.init(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(user: User? = nil) {
                  self.init(snapshot: ["__typename": "GitActor", "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The GitHub user corresponding to the email field. Null if no such user exists.
                public var user: User? {
                  get {
                    return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "user")
                  }
                }

                public struct User: GraphQLSelectionSet {
                  public static let possibleTypes = ["User"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(login: String) {
                    self.init(snapshot: ["__typename": "User", "login": login])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The username used to login.
                  public var login: String {
                    get {
                      return snapshot["login"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "login")
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

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(hasNextPage: Bool, endCursor: String? = nil) {
                self.init(snapshot: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "endCursor": endCursor])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// When paginating forwards, are there more items?
              public var hasNextPage: Bool {
                get {
                  return snapshot["hasNextPage"]! as! Bool
                }
                set {
                  snapshot.updateValue(newValue, forKey: "hasNextPage")
                }
              }

              /// When paginating forwards, the cursor to continue.
              public var endCursor: String? {
                get {
                  return snapshot["endCursor"] as? String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "endCursor")
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
  public static let operationString =
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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> Snapshot in value.snapshot }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"] as? Snapshot).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("object", arguments: ["expression": GraphQLVariable("branchAndPath")], type: .object(Object.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(object: Object? = nil) {
        self.init(snapshot: ["__typename": "Repository", "object": object.flatMap { (value: Object) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A Git object in the repository
      public var object: Object? {
        get {
          return (snapshot["object"] as? Snapshot).flatMap { Object(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "object")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeCommit() -> Object {
          return Object(snapshot: ["__typename": "Commit"])
        }

        public static func makeBlob() -> Object {
          return Object(snapshot: ["__typename": "Blob"])
        }

        public static func makeTag() -> Object {
          return Object(snapshot: ["__typename": "Tag"])
        }

        public static func makeTree(entries: [AsTree.Entry]? = nil) -> Object {
          return Object(snapshot: ["__typename": "Tree", "entries": entries.flatMap { (value: [AsTree.Entry]) -> [Snapshot] in value.map { (value: AsTree.Entry) -> Snapshot in value.snapshot } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asTree: AsTree? {
          get {
            if !AsTree.possibleTypes.contains(__typename) { return nil }
            return AsTree(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsTree: GraphQLSelectionSet {
          public static let possibleTypes = ["Tree"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("entries", type: .list(.nonNull(.object(Entry.selections)))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(entries: [Entry]? = nil) {
            self.init(snapshot: ["__typename": "Tree", "entries": entries.flatMap { (value: [Entry]) -> [Snapshot] in value.map { (value: Entry) -> Snapshot in value.snapshot } }])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of tree entries.
          public var entries: [Entry]? {
            get {
              return (snapshot["entries"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [Entry] in value.map { (value: Snapshot) -> Entry in Entry(snapshot: value) } }
            }
            set {
              snapshot.updateValue(newValue.flatMap { (value: [Entry]) -> [Snapshot] in value.map { (value: Entry) -> Snapshot in value.snapshot } }, forKey: "entries")
            }
          }

          public struct Entry: GraphQLSelectionSet {
            public static let possibleTypes = ["TreeEntry"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String, type: String) {
              self.init(snapshot: ["__typename": "TreeEntry", "name": name, "type": type])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Entry file name.
            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            /// Entry file type.
            public var type: String {
              get {
                return snapshot["type"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "type")
              }
            }
          }
        }
      }
    }
  }
}

public final class RepoSearchPagesQuery: GraphQLQuery {
  public static let operationString =
    "query RepoSearchPages($query: String!, $after: String, $page_size: Int!) {\n  search(query: $query, type: ISSUE, after: $after, first: $page_size) {\n    __typename\n    nodes {\n      __typename\n      ... on Issue {\n        ...repoEventFields\n        ...nodeFields\n        ...labelableFields\n        title\n        number\n        issueState: state\n      }\n      ... on PullRequest {\n        ...repoEventFields\n        ...nodeFields\n        ...labelableFields\n        title\n        number\n        pullRequestState: state\n        commits(last: 1) {\n          __typename\n          nodes {\n            __typename\n            commit {\n              __typename\n              status {\n                __typename\n                state\n              }\n            }\n          }\n        }\n      }\n    }\n    pageInfo {\n      __typename\n      hasNextPage\n      endCursor\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(RepoEventFields.fragmentString).appending(NodeFields.fragmentString).appending(LabelableFields.fragmentString) }

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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search.snapshot])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(snapshot: snapshot["search"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "pageInfo": pageInfo.snapshot])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
        }
      }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeRepository() -> Node {
          return Node(snapshot: ["__typename": "Repository"])
        }

        public static func makeUser() -> Node {
          return Node(snapshot: ["__typename": "User"])
        }

        public static func makeOrganization() -> Node {
          return Node(snapshot: ["__typename": "Organization"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(snapshot: ["__typename": "MarketplaceListing"])
        }

        public static func makeIssue(createdAt: String, author: AsIssue.Author? = nil, id: GraphQLID, labels: AsIssue.Label? = nil, title: String, number: Int, issueState: IssueState) -> Node {
          return Node(snapshot: ["__typename": "Issue", "createdAt": createdAt, "author": author.flatMap { (value: AsIssue.Author) -> Snapshot in value.snapshot }, "id": id, "labels": labels.flatMap { (value: AsIssue.Label) -> Snapshot in value.snapshot }, "title": title, "number": number, "issueState": issueState])
        }

        public static func makePullRequest(createdAt: String, author: AsPullRequest.Author? = nil, id: GraphQLID, labels: AsPullRequest.Label? = nil, title: String, number: Int, pullRequestState: PullRequestState, commits: AsPullRequest.Commit) -> Node {
          return Node(snapshot: ["__typename": "PullRequest", "createdAt": createdAt, "author": author.flatMap { (value: AsPullRequest.Author) -> Snapshot in value.snapshot }, "id": id, "labels": labels.flatMap { (value: AsPullRequest.Label) -> Snapshot in value.snapshot }, "title": title, "number": number, "pullRequestState": pullRequestState, "commits": commits.snapshot])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asIssue: AsIssue? {
          get {
            if !AsIssue.possibleTypes.contains(__typename) { return nil }
            return AsIssue(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsIssue: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("author", type: .object(Author.selections)),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("labels", arguments: ["first": 30], type: .object(Label.selections)),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", alias: "issueState", type: .nonNull(.scalar(IssueState.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(createdAt: String, author: Author? = nil, id: GraphQLID, labels: Label? = nil, title: String, number: Int, issueState: IssueState) {
            self.init(snapshot: ["__typename": "Issue", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "id": id, "labels": labels.flatMap { (value: Label) -> Snapshot in value.snapshot }, "title": title, "number": number, "issueState": issueState])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the date and time when the object was created.
          public var createdAt: String {
            get {
              return snapshot["createdAt"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "createdAt")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// ID of the object.
          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// A list of labels associated with the object.
          public var labels: Label? {
            get {
              return (snapshot["labels"] as? Snapshot).flatMap { Label(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "labels")
            }
          }

          /// Identifies the issue title.
          public var title: String {
            get {
              return snapshot["title"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }

          /// Identifies the issue number.
          public var number: Int {
            get {
              return snapshot["number"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the state of the issue.
          public var issueState: IssueState {
            get {
              return snapshot["issueState"]! as! IssueState
            }
            set {
              snapshot.updateValue(newValue, forKey: "issueState")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var repoEventFields: RepoEventFields {
              get {
                return RepoEventFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }

          public struct Author: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String) -> Author {
              return Author(snapshot: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Author {
              return Author(snapshot: ["__typename": "User", "login": login])
            }

            public static func makeBot(login: String) -> Author {
              return Author(snapshot: ["__typename": "Bot", "login": login])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }
          }

          public struct Label: GraphQLSelectionSet {
            public static let possibleTypes = ["LabelConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Label"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("color", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(color: String, name: String) {
                self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the label color.
              public var color: String {
                get {
                  return snapshot["color"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "color")
                }
              }

              /// Identifies the label name.
              public var name: String {
                get {
                  return snapshot["name"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "name")
                }
              }
            }
          }
        }

        public var asPullRequest: AsPullRequest? {
          get {
            if !AsPullRequest.possibleTypes.contains(__typename) { return nil }
            return AsPullRequest(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsPullRequest: GraphQLSelectionSet {
          public static let possibleTypes = ["PullRequest"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("author", type: .object(Author.selections)),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("labels", arguments: ["first": 30], type: .object(Label.selections)),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", alias: "pullRequestState", type: .nonNull(.scalar(PullRequestState.self))),
            GraphQLField("commits", arguments: ["last": 1], type: .nonNull(.object(Commit.selections))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(createdAt: String, author: Author? = nil, id: GraphQLID, labels: Label? = nil, title: String, number: Int, pullRequestState: PullRequestState, commits: Commit) {
            self.init(snapshot: ["__typename": "PullRequest", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "id": id, "labels": labels.flatMap { (value: Label) -> Snapshot in value.snapshot }, "title": title, "number": number, "pullRequestState": pullRequestState, "commits": commits.snapshot])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the date and time when the object was created.
          public var createdAt: String {
            get {
              return snapshot["createdAt"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "createdAt")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// ID of the object.
          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// A list of labels associated with the object.
          public var labels: Label? {
            get {
              return (snapshot["labels"] as? Snapshot).flatMap { Label(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "labels")
            }
          }

          /// Identifies the pull request title.
          public var title: String {
            get {
              return snapshot["title"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }

          /// Identifies the pull request number.
          public var number: Int {
            get {
              return snapshot["number"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the state of the pull request.
          public var pullRequestState: PullRequestState {
            get {
              return snapshot["pullRequestState"]! as! PullRequestState
            }
            set {
              snapshot.updateValue(newValue, forKey: "pullRequestState")
            }
          }

          /// A list of commits present in this pull request's head branch not present in the base branch.
          public var commits: Commit {
            get {
              return Commit(snapshot: snapshot["commits"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "commits")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var repoEventFields: RepoEventFields {
              get {
                return RepoEventFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }

          public struct Author: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User", "Bot"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String) -> Author {
              return Author(snapshot: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Author {
              return Author(snapshot: ["__typename": "User", "login": login])
            }

            public static func makeBot(login: String) -> Author {
              return Author(snapshot: ["__typename": "Bot", "login": login])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username of the actor.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }
          }

          public struct Label: GraphQLSelectionSet {
            public static let possibleTypes = ["LabelConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Label"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("color", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(color: String, name: String) {
                self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the label color.
              public var color: String {
                get {
                  return snapshot["color"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "color")
                }
              }

              /// Identifies the label name.
              public var name: String {
                get {
                  return snapshot["name"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "name")
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "PullRequestCommitConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["PullRequestCommit"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("commit", type: .nonNull(.object(Commit.selections))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(commit: Commit) {
                self.init(snapshot: ["__typename": "PullRequestCommit", "commit": commit.snapshot])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The Git commit object
              public var commit: Commit {
                get {
                  return Commit(snapshot: snapshot["commit"]! as! Snapshot)
                }
                set {
                  snapshot.updateValue(newValue.snapshot, forKey: "commit")
                }
              }

              public struct Commit: GraphQLSelectionSet {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("status", type: .object(Status.selections)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(status: Status? = nil) {
                  self.init(snapshot: ["__typename": "Commit", "status": status.flatMap { (value: Status) -> Snapshot in value.snapshot }])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Status information for this commit
                public var status: Status? {
                  get {
                    return (snapshot["status"] as? Snapshot).flatMap { Status(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "status")
                  }
                }

                public struct Status: GraphQLSelectionSet {
                  public static let possibleTypes = ["Status"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(state: StatusState) {
                    self.init(snapshot: ["__typename": "Status", "state": state])
                  }

                  public var __typename: String {
                    get {
                      return snapshot["__typename"]! as! String
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The combined commit status.
                  public var state: StatusState {
                    get {
                      return snapshot["state"]! as! StatusState
                    }
                    set {
                      snapshot.updateValue(newValue, forKey: "state")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(hasNextPage: Bool, endCursor: String? = nil) {
          self.init(snapshot: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "endCursor": endCursor])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool {
          get {
            return snapshot["hasNextPage"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "hasNextPage")
          }
        }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? {
          get {
            return snapshot["endCursor"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "endCursor")
          }
        }
      }
    }
  }
}

public final class RepositoryLabelsQuery: GraphQLQuery {
  public static let operationString =
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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> Snapshot in value.snapshot }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"] as? Snapshot).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("labels", arguments: ["first": 100], type: .object(Label.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(labels: Label? = nil) {
        self.init(snapshot: ["__typename": "Repository", "labels": labels.flatMap { (value: Label) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of labels associated with the repository.
      public var labels: Label? {
        get {
          return (snapshot["labels"] as? Snapshot).flatMap { Label(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "labels")
        }
      }

      public struct Label: GraphQLSelectionSet {
        public static let possibleTypes = ["LabelConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil) {
          self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Label"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("color", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(name: String, color: String) {
            self.init(snapshot: ["__typename": "Label", "name": name, "color": color])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the label name.
          public var name: String {
            get {
              return snapshot["name"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }

          /// Identifies the label color.
          public var color: String {
            get {
              return snapshot["color"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "color")
            }
          }
        }
      }
    }
  }
}

public final class SearchReposQuery: GraphQLQuery {
  public static let operationString =
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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search.snapshot])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(snapshot: snapshot["search"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "search")
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

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(nodes: [Node?]? = nil, pageInfo: PageInfo, repositoryCount: Int) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "pageInfo": pageInfo.snapshot, "repositoryCount": repositoryCount])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
        }
      }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
        }
      }

      /// The number of repositories that matched the search query.
      public var repositoryCount: Int {
        get {
          return snapshot["repositoryCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "repositoryCount")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue() -> Node {
          return Node(snapshot: ["__typename": "Issue"])
        }

        public static func makePullRequest() -> Node {
          return Node(snapshot: ["__typename": "PullRequest"])
        }

        public static func makeUser() -> Node {
          return Node(snapshot: ["__typename": "User"])
        }

        public static func makeOrganization() -> Node {
          return Node(snapshot: ["__typename": "Organization"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(snapshot: ["__typename": "MarketplaceListing"])
        }

        public static func makeRepository(id: GraphQLID, name: String, hasIssuesEnabled: Bool, owner: AsRepository.Owner, description: String? = nil, pushedAt: String? = nil, primaryLanguage: AsRepository.PrimaryLanguage? = nil, stargazers: AsRepository.Stargazer, defaultBranchRef: AsRepository.DefaultBranchRef? = nil) -> Node {
          return Node(snapshot: ["__typename": "Repository", "id": id, "name": name, "hasIssuesEnabled": hasIssuesEnabled, "owner": owner.snapshot, "description": description, "pushedAt": pushedAt, "primaryLanguage": primaryLanguage.flatMap { (value: AsRepository.PrimaryLanguage) -> Snapshot in value.snapshot }, "stargazers": stargazers.snapshot, "defaultBranchRef": defaultBranchRef.flatMap { (value: AsRepository.DefaultBranchRef) -> Snapshot in value.snapshot }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asRepository: AsRepository? {
          get {
            if !AsRepository.possibleTypes.contains(__typename) { return nil }
            return AsRepository(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
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

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String, hasIssuesEnabled: Bool, owner: Owner, description: String? = nil, pushedAt: String? = nil, primaryLanguage: PrimaryLanguage? = nil, stargazers: Stargazer, defaultBranchRef: DefaultBranchRef? = nil) {
            self.init(snapshot: ["__typename": "Repository", "id": id, "name": name, "hasIssuesEnabled": hasIssuesEnabled, "owner": owner.snapshot, "description": description, "pushedAt": pushedAt, "primaryLanguage": primaryLanguage.flatMap { (value: PrimaryLanguage) -> Snapshot in value.snapshot }, "stargazers": stargazers.snapshot, "defaultBranchRef": defaultBranchRef.flatMap { (value: DefaultBranchRef) -> Snapshot in value.snapshot }])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              return snapshot["name"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }

          /// Indicates if the repository has issues feature enabled.
          public var hasIssuesEnabled: Bool {
            get {
              return snapshot["hasIssuesEnabled"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasIssuesEnabled")
            }
          }

          /// The User owner of the repository.
          public var owner: Owner {
            get {
              return Owner(snapshot: snapshot["owner"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "owner")
            }
          }

          /// The description of the repository.
          public var description: String? {
            get {
              return snapshot["description"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "description")
            }
          }

          /// Identifies when the repository was last pushed to.
          public var pushedAt: String? {
            get {
              return snapshot["pushedAt"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "pushedAt")
            }
          }

          /// The primary language of the repository's code.
          public var primaryLanguage: PrimaryLanguage? {
            get {
              return (snapshot["primaryLanguage"] as? Snapshot).flatMap { PrimaryLanguage(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "primaryLanguage")
            }
          }

          /// A list of users who have starred this starrable.
          public var stargazers: Stargazer {
            get {
              return Stargazer(snapshot: snapshot["stargazers"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "stargazers")
            }
          }

          /// The Ref associated with the repository's default branch.
          public var defaultBranchRef: DefaultBranchRef? {
            get {
              return (snapshot["defaultBranchRef"] as? Snapshot).flatMap { DefaultBranchRef(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "defaultBranchRef")
            }
          }

          public struct Owner: GraphQLSelectionSet {
            public static let possibleTypes = ["Organization", "User"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public static func makeOrganization(login: String) -> Owner {
              return Owner(snapshot: ["__typename": "Organization", "login": login])
            }

            public static func makeUser(login: String) -> Owner {
              return Owner(snapshot: ["__typename": "User", "login": login])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
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

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String, color: String? = nil) {
              self.init(snapshot: ["__typename": "Language", "name": name, "color": color])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the current language.
            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            /// The color defined for the current language.
            public var color: String? {
              get {
                return snapshot["color"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "color")
              }
            }
          }

          public struct Stargazer: GraphQLSelectionSet {
            public static let possibleTypes = ["StargazerConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(totalCount: Int) {
              self.init(snapshot: ["__typename": "StargazerConnection", "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return snapshot["totalCount"]! as! Int
              }
              set {
                snapshot.updateValue(newValue, forKey: "totalCount")
              }
            }
          }

          public struct DefaultBranchRef: GraphQLSelectionSet {
            public static let possibleTypes = ["Ref"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String) {
              self.init(snapshot: ["__typename": "Ref", "name": name])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The ref name.
            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
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

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(endCursor: String? = nil, hasNextPage: Bool) {
          self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? {
          get {
            return snapshot["endCursor"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "endCursor")
          }
        }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool {
          get {
            return snapshot["hasNextPage"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "hasNextPage")
          }
        }
      }
    }
  }
}

public struct ReactionFields: GraphQLFragment {
  public static let fragmentString =
    "fragment reactionFields on Reactable {\n  __typename\n  viewerCanReact\n  reactionGroups {\n    __typename\n    viewerHasReacted\n    users(first: 3) {\n      __typename\n      nodes {\n        __typename\n        login\n      }\n      totalCount\n    }\n    content\n  }\n}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.selections)))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "Issue", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
  }

  public static func makeCommitComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "CommitComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
  }

  public static func makePullRequest(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "PullRequest", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
  }

  public static func makeIssueComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "IssueComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
  }

  public static func makePullRequestReviewComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Can user react to this subject
  public var viewerCanReact: Bool {
    get {
      return snapshot["viewerCanReact"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "viewerCanReact")
    }
  }

  /// A list of reactions grouped by content left on the subject.
  public var reactionGroups: [ReactionGroup]? {
    get {
      return (snapshot["reactionGroups"] as? [Snapshot]).flatMap { (value: [Snapshot]) -> [ReactionGroup] in value.map { (value: Snapshot) -> ReactionGroup in ReactionGroup(snapshot: value) } }
    }
    set {
      snapshot.updateValue(newValue.flatMap { (value: [ReactionGroup]) -> [Snapshot] in value.map { (value: ReactionGroup) -> Snapshot in value.snapshot } }, forKey: "reactionGroups")
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

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
      self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users.snapshot, "content": content])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Whether or not the authenticated user has left a reaction on the subject.
    public var viewerHasReacted: Bool {
      get {
        return snapshot["viewerHasReacted"]! as! Bool
      }
      set {
        snapshot.updateValue(newValue, forKey: "viewerHasReacted")
      }
    }

    /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
    public var users: User {
      get {
        return User(snapshot: snapshot["users"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "users")
      }
    }

    /// Identifies the emoji reaction.
    public var content: ReactionContent {
      get {
        return snapshot["content"]! as! ReactionContent
      }
      set {
        snapshot.updateValue(newValue, forKey: "content")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["ReactingUserConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(nodes: [Node?]? = nil, totalCount: Int) {
        self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, "totalCount": totalCount])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
        }
      }

      /// Identifies the total count of items in the connection.
      public var totalCount: Int {
        get {
          return snapshot["totalCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "totalCount")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(login: String) {
          self.init(snapshot: ["__typename": "User", "login": login])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The username used to login.
        public var login: String {
          get {
            return snapshot["login"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "login")
          }
        }
      }
    }
  }
}

public struct CommentFields: GraphQLFragment {
  public static let fragmentString =
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

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "Issue", "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeCommitComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "CommitComment", "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequest(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "PullRequest", "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeIssueComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "IssueComment", "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReview(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "PullRequestReview", "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReviewComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "PullRequestReviewComment", "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeGistComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "GistComment", "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }, "editor": editor.flatMap { (value: Editor) -> Snapshot in value.snapshot }, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "author")
    }
  }

  /// The actor who edited the comment.
  public var editor: Editor? {
    get {
      return (snapshot["editor"] as? Snapshot).flatMap { Editor(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "editor")
    }
  }

  /// The moment the editor made the last edit
  public var lastEditedAt: String? {
    get {
      return snapshot["lastEditedAt"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "lastEditedAt")
    }
  }

  /// The body as Markdown.
  public var body: String {
    get {
      return snapshot["body"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "body")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return snapshot["createdAt"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// Did the viewer author this comment.
  public var viewerDidAuthor: Bool {
    get {
      return snapshot["viewerDidAuthor"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "viewerDidAuthor")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User", "Bot"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public static func makeOrganization(login: String, avatarUrl: String) -> Author {
      return Author(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeUser(login: String, avatarUrl: String) -> Author {
      return Author(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeBot(login: String, avatarUrl: String) -> Author {
      return Author(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return snapshot["login"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "login")
      }
    }

    /// A URL pointing to the actor's public avatar.
    public var avatarUrl: String {
      get {
        return snapshot["avatarUrl"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "avatarUrl")
      }
    }
  }

  public struct Editor: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User", "Bot"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public static func makeOrganization(login: String) -> Editor {
      return Editor(snapshot: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Editor {
      return Editor(snapshot: ["__typename": "User", "login": login])
    }

    public static func makeBot(login: String) -> Editor {
      return Editor(snapshot: ["__typename": "Bot", "login": login])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return snapshot["login"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "login")
      }
    }
  }
}

public struct LockableFields: GraphQLFragment {
  public static let fragmentString =
    "fragment lockableFields on Lockable {\n  __typename\n  locked\n}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("locked", type: .nonNull(.scalar(Bool.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(locked: Bool) -> LockableFields {
    return LockableFields(snapshot: ["__typename": "Issue", "locked": locked])
  }

  public static func makePullRequest(locked: Bool) -> LockableFields {
    return LockableFields(snapshot: ["__typename": "PullRequest", "locked": locked])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// `true` if the object is locked
  public var locked: Bool {
    get {
      return snapshot["locked"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "locked")
    }
  }
}

public struct ClosableFields: GraphQLFragment {
  public static let fragmentString =
    "fragment closableFields on Closable {\n  __typename\n  closed\n}"

  public static let possibleTypes = ["Project", "Issue", "PullRequest", "Milestone"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeProject(closed: Bool) -> ClosableFields {
    return ClosableFields(snapshot: ["__typename": "Project", "closed": closed])
  }

  public static func makeIssue(closed: Bool) -> ClosableFields {
    return ClosableFields(snapshot: ["__typename": "Issue", "closed": closed])
  }

  public static func makePullRequest(closed: Bool) -> ClosableFields {
    return ClosableFields(snapshot: ["__typename": "PullRequest", "closed": closed])
  }

  public static func makeMilestone(closed: Bool) -> ClosableFields {
    return ClosableFields(snapshot: ["__typename": "Milestone", "closed": closed])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// `true` if the object is closed (definition of closed may depend on type)
  public var closed: Bool {
    get {
      return snapshot["closed"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "closed")
    }
  }
}

public struct LabelableFields: GraphQLFragment {
  public static let fragmentString =
    "fragment labelableFields on Labelable {\n  __typename\n  labels(first: 30) {\n    __typename\n    nodes {\n      __typename\n      color\n      name\n    }\n  }\n}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("labels", arguments: ["first": 30], type: .object(Label.selections)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(labels: Label? = nil) -> LabelableFields {
    return LabelableFields(snapshot: ["__typename": "Issue", "labels": labels.flatMap { (value: Label) -> Snapshot in value.snapshot }])
  }

  public static func makePullRequest(labels: Label? = nil) -> LabelableFields {
    return LabelableFields(snapshot: ["__typename": "PullRequest", "labels": labels.flatMap { (value: Label) -> Snapshot in value.snapshot }])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A list of labels associated with the object.
  public var labels: Label? {
    get {
      return (snapshot["labels"] as? Snapshot).flatMap { Label(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "labels")
    }
  }

  public struct Label: GraphQLSelectionSet {
    public static let possibleTypes = ["LabelConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("nodes", type: .list(.object(Node.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(nodes: [Node?]? = nil) {
      self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A list of nodes.
    public var nodes: [Node?]? {
      get {
        return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes = ["Label"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("color", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(color: String, name: String) {
        self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Identifies the label color.
      public var color: String {
        get {
          return snapshot["color"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "color")
        }
      }

      /// Identifies the label name.
      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

public struct UpdatableFields: GraphQLFragment {
  public static let fragmentString =
    "fragment updatableFields on Updatable {\n  __typename\n  viewerCanUpdate\n}"

  public static let possibleTypes = ["Project", "Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeProject(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "Project", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeIssue(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "Issue", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeCommitComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "CommitComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makePullRequest(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "PullRequest", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeIssueComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "IssueComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makePullRequestReview(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "PullRequestReview", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makePullRequestReviewComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public static func makeGistComment(viewerCanUpdate: Bool) -> UpdatableFields {
    return UpdatableFields(snapshot: ["__typename": "GistComment", "viewerCanUpdate": viewerCanUpdate])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Check if the current viewer can update this object.
  public var viewerCanUpdate: Bool {
    get {
      return snapshot["viewerCanUpdate"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "viewerCanUpdate")
    }
  }
}

public struct DeletableFields: GraphQLFragment {
  public static let fragmentString =
    "fragment deletableFields on Deletable {\n  __typename\n  viewerCanDelete\n}"

  public static let possibleTypes = ["CommitComment", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerCanDelete", type: .nonNull(.scalar(Bool.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeCommitComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(snapshot: ["__typename": "CommitComment", "viewerCanDelete": viewerCanDelete])
  }

  public static func makeIssueComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(snapshot: ["__typename": "IssueComment", "viewerCanDelete": viewerCanDelete])
  }

  public static func makePullRequestReview(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(snapshot: ["__typename": "PullRequestReview", "viewerCanDelete": viewerCanDelete])
  }

  public static func makePullRequestReviewComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanDelete": viewerCanDelete])
  }

  public static func makeGistComment(viewerCanDelete: Bool) -> DeletableFields {
    return DeletableFields(snapshot: ["__typename": "GistComment", "viewerCanDelete": viewerCanDelete])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Check if the current viewer can delete this object.
  public var viewerCanDelete: Bool {
    get {
      return snapshot["viewerCanDelete"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "viewerCanDelete")
    }
  }
}

public struct NodeFields: GraphQLFragment {
  public static let fragmentString =
    "fragment nodeFields on Node {\n  __typename\n  id\n}"

  public static let possibleTypes = ["License", "MarketplaceCategory", "MarketplaceListing", "Organization", "Project", "ProjectColumn", "ProjectCard", "Issue", "User", "Repository", "CommitComment", "UserContentEdit", "Reaction", "Commit", "Status", "StatusContext", "Tree", "Ref", "PullRequest", "Label", "IssueComment", "PullRequestCommit", "Milestone", "ReviewRequest", "Team", "OrganizationInvitation", "PullRequestReview", "PullRequestReviewComment", "CommitCommentThread", "PullRequestReviewThread", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "MergedEvent", "ReferencedEvent", "CrossReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent", "DeployedEvent", "Deployment", "DeploymentStatus", "HeadRefDeletedEvent", "HeadRefRestoredEvent", "HeadRefForcePushedEvent", "BaseRefForcePushedEvent", "ReviewRequestedEvent", "ReviewRequestRemovedEvent", "ReviewDismissedEvent", "DeployKey", "Language", "ProtectedBranch", "PushAllowance", "ReviewDismissalAllowance", "Release", "ReleaseAsset", "RepositoryTopic", "Topic", "Gist", "GistComment", "PublicKey", "OrganizationIdentityProvider", "ExternalIdentity", "Bot", "RepositoryInvitation", "Blob", "BaseRefChangedEvent", "AddedToProjectEvent", "CommentDeletedEvent", "ConvertedNoteToIssueEvent", "MentionedEvent", "MovedColumnsInProjectEvent", "RemovedFromProjectEvent", "Tag"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeLicense(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "License", "id": id])
  }

  public static func makeMarketplaceCategory(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "MarketplaceCategory", "id": id])
  }

  public static func makeMarketplaceListing(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "MarketplaceListing", "id": id])
  }

  public static func makeOrganization(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Organization", "id": id])
  }

  public static func makeProject(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Project", "id": id])
  }

  public static func makeProjectColumn(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ProjectColumn", "id": id])
  }

  public static func makeProjectCard(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ProjectCard", "id": id])
  }

  public static func makeIssue(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Issue", "id": id])
  }

  public static func makeUser(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "User", "id": id])
  }

  public static func makeRepository(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Repository", "id": id])
  }

  public static func makeCommitComment(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "CommitComment", "id": id])
  }

  public static func makeUserContentEdit(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "UserContentEdit", "id": id])
  }

  public static func makeReaction(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Reaction", "id": id])
  }

  public static func makeCommit(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Commit", "id": id])
  }

  public static func makeStatus(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Status", "id": id])
  }

  public static func makeStatusContext(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "StatusContext", "id": id])
  }

  public static func makeTree(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Tree", "id": id])
  }

  public static func makeRef(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Ref", "id": id])
  }

  public static func makePullRequest(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PullRequest", "id": id])
  }

  public static func makeLabel(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Label", "id": id])
  }

  public static func makeIssueComment(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "IssueComment", "id": id])
  }

  public static func makePullRequestCommit(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PullRequestCommit", "id": id])
  }

  public static func makeMilestone(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Milestone", "id": id])
  }

  public static func makeReviewRequest(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReviewRequest", "id": id])
  }

  public static func makeTeam(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Team", "id": id])
  }

  public static func makeOrganizationInvitation(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "OrganizationInvitation", "id": id])
  }

  public static func makePullRequestReview(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PullRequestReview", "id": id])
  }

  public static func makePullRequestReviewComment(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PullRequestReviewComment", "id": id])
  }

  public static func makeCommitCommentThread(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "CommitCommentThread", "id": id])
  }

  public static func makePullRequestReviewThread(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PullRequestReviewThread", "id": id])
  }

  public static func makeClosedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ClosedEvent", "id": id])
  }

  public static func makeReopenedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReopenedEvent", "id": id])
  }

  public static func makeSubscribedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "SubscribedEvent", "id": id])
  }

  public static func makeUnsubscribedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "UnsubscribedEvent", "id": id])
  }

  public static func makeMergedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "MergedEvent", "id": id])
  }

  public static func makeReferencedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReferencedEvent", "id": id])
  }

  public static func makeCrossReferencedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "CrossReferencedEvent", "id": id])
  }

  public static func makeAssignedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "AssignedEvent", "id": id])
  }

  public static func makeUnassignedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "UnassignedEvent", "id": id])
  }

  public static func makeLabeledEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "LabeledEvent", "id": id])
  }

  public static func makeUnlabeledEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "UnlabeledEvent", "id": id])
  }

  public static func makeMilestonedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "MilestonedEvent", "id": id])
  }

  public static func makeDemilestonedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "DemilestonedEvent", "id": id])
  }

  public static func makeRenamedTitleEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "RenamedTitleEvent", "id": id])
  }

  public static func makeLockedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "LockedEvent", "id": id])
  }

  public static func makeUnlockedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "UnlockedEvent", "id": id])
  }

  public static func makeDeployedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "DeployedEvent", "id": id])
  }

  public static func makeDeployment(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Deployment", "id": id])
  }

  public static func makeDeploymentStatus(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "DeploymentStatus", "id": id])
  }

  public static func makeHeadRefDeletedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "HeadRefDeletedEvent", "id": id])
  }

  public static func makeHeadRefRestoredEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "HeadRefRestoredEvent", "id": id])
  }

  public static func makeHeadRefForcePushedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "HeadRefForcePushedEvent", "id": id])
  }

  public static func makeBaseRefForcePushedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "BaseRefForcePushedEvent", "id": id])
  }

  public static func makeReviewRequestedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReviewRequestedEvent", "id": id])
  }

  public static func makeReviewRequestRemovedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReviewRequestRemovedEvent", "id": id])
  }

  public static func makeReviewDismissedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReviewDismissedEvent", "id": id])
  }

  public static func makeDeployKey(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "DeployKey", "id": id])
  }

  public static func makeLanguage(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Language", "id": id])
  }

  public static func makeProtectedBranch(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ProtectedBranch", "id": id])
  }

  public static func makePushAllowance(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PushAllowance", "id": id])
  }

  public static func makeReviewDismissalAllowance(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReviewDismissalAllowance", "id": id])
  }

  public static func makeRelease(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Release", "id": id])
  }

  public static func makeReleaseAsset(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ReleaseAsset", "id": id])
  }

  public static func makeRepositoryTopic(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "RepositoryTopic", "id": id])
  }

  public static func makeTopic(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Topic", "id": id])
  }

  public static func makeGist(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Gist", "id": id])
  }

  public static func makeGistComment(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "GistComment", "id": id])
  }

  public static func makePublicKey(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PublicKey", "id": id])
  }

  public static func makeOrganizationIdentityProvider(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "OrganizationIdentityProvider", "id": id])
  }

  public static func makeExternalIdentity(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ExternalIdentity", "id": id])
  }

  public static func makeBot(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Bot", "id": id])
  }

  public static func makeRepositoryInvitation(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "RepositoryInvitation", "id": id])
  }

  public static func makeBlob(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Blob", "id": id])
  }

  public static func makeBaseRefChangedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "BaseRefChangedEvent", "id": id])
  }

  public static func makeAddedToProjectEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "AddedToProjectEvent", "id": id])
  }

  public static func makeCommentDeletedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "CommentDeletedEvent", "id": id])
  }

  public static func makeConvertedNoteToIssueEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ConvertedNoteToIssueEvent", "id": id])
  }

  public static func makeMentionedEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "MentionedEvent", "id": id])
  }

  public static func makeMovedColumnsInProjectEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "MovedColumnsInProjectEvent", "id": id])
  }

  public static func makeRemovedFromProjectEvent(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "RemovedFromProjectEvent", "id": id])
  }

  public static func makeTag(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Tag", "id": id])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// ID of the object.
  public var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }
}

public struct ReferencedRepositoryFields: GraphQLFragment {
  public static let fragmentString =
    "fragment referencedRepositoryFields on RepositoryInfo {\n  __typename\n  name\n  owner {\n    __typename\n    login\n  }\n}"

  public static let possibleTypes = ["Repository"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(name: String, owner: Owner) {
    self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner.snapshot])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The name of the repository.
  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  /// The User owner of the repository.
  public var owner: Owner {
    get {
      return Owner(snapshot: snapshot["owner"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "owner")
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public static func makeOrganization(login: String) -> Owner {
      return Owner(snapshot: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Owner {
      return Owner(snapshot: ["__typename": "User", "login": login])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username used to login.
    public var login: String {
      get {
        return snapshot["login"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "login")
      }
    }
  }
}

public struct AssigneeFields: GraphQLFragment {
  public static let fragmentString =
    "fragment assigneeFields on Assignable {\n  __typename\n  assignees(first: $page_size) {\n    __typename\n    nodes {\n      __typename\n      login\n      avatarUrl\n    }\n  }\n}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("assignees", arguments: ["first": GraphQLVariable("page_size")], type: .nonNull(.object(Assignee.selections))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(assignees: Assignee) -> AssigneeFields {
    return AssigneeFields(snapshot: ["__typename": "Issue", "assignees": assignees.snapshot])
  }

  public static func makePullRequest(assignees: Assignee) -> AssigneeFields {
    return AssigneeFields(snapshot: ["__typename": "PullRequest", "assignees": assignees.snapshot])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A list of Users assigned to this object.
  public var assignees: Assignee {
    get {
      return Assignee(snapshot: snapshot["assignees"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "assignees")
    }
  }

  public struct Assignee: GraphQLSelectionSet {
    public static let possibleTypes = ["UserConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("nodes", type: .list(.object(Node.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(nodes: [Node?]? = nil) {
      self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A list of nodes.
    public var nodes: [Node?]? {
      get {
        return (snapshot["nodes"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Node?] in value.map { (value: Snapshot?) -> Node? in value.flatMap { (value: Snapshot) -> Node in Node(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Node?]) -> [Snapshot?] in value.map { (value: Node?) -> Snapshot? in value.flatMap { (value: Node) -> Snapshot in value.snapshot } } }, forKey: "nodes")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("login", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(login: String, avatarUrl: String) {
        self.init(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return snapshot["login"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "login")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return snapshot["avatarUrl"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}

public struct HeadPaging: GraphQLFragment {
  public static let fragmentString =
    "fragment headPaging on PageInfo {\n  __typename\n  hasPreviousPage\n  startCursor\n}"

  public static let possibleTypes = ["PageInfo"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("startCursor", type: .scalar(String.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(hasPreviousPage: Bool, startCursor: String? = nil) {
    self.init(snapshot: ["__typename": "PageInfo", "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// When paginating backwards, are there more items?
  public var hasPreviousPage: Bool {
    get {
      return snapshot["hasPreviousPage"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "hasPreviousPage")
    }
  }

  /// When paginating backwards, the cursor to continue.
  public var startCursor: String? {
    get {
      return snapshot["startCursor"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "startCursor")
    }
  }
}

public struct MilestoneFields: GraphQLFragment {
  public static let fragmentString =
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

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(number: Int, title: String, url: String, dueOn: String? = nil, openCount: OpenCount, totalCount: TotalCount) {
    self.init(snapshot: ["__typename": "Milestone", "number": number, "title": title, "url": url, "dueOn": dueOn, "openCount": openCount.snapshot, "totalCount": totalCount.snapshot])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Identifies the number of the milestone.
  public var number: Int {
    get {
      return snapshot["number"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "number")
    }
  }

  /// Identifies the title of the milestone.
  public var title: String {
    get {
      return snapshot["title"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "title")
    }
  }

  /// The HTTP URL for this milestone
  public var url: String {
    get {
      return snapshot["url"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "url")
    }
  }

  /// Identifies the due date of the milestone.
  public var dueOn: String? {
    get {
      return snapshot["dueOn"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "dueOn")
    }
  }

  /// A list of issues associated with the milestone.
  public var openCount: OpenCount {
    get {
      return OpenCount(snapshot: snapshot["openCount"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "openCount")
    }
  }

  /// A list of issues associated with the milestone.
  public var totalCount: TotalCount {
    get {
      return TotalCount(snapshot: snapshot["totalCount"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "totalCount")
    }
  }

  public struct OpenCount: GraphQLSelectionSet {
    public static let possibleTypes = ["IssueConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(totalCount: Int) {
      self.init(snapshot: ["__typename": "IssueConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return snapshot["totalCount"]! as! Int
      }
      set {
        snapshot.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct TotalCount: GraphQLSelectionSet {
    public static let possibleTypes = ["IssueConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(totalCount: Int) {
      self.init(snapshot: ["__typename": "IssueConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return snapshot["totalCount"]! as! Int
      }
      set {
        snapshot.updateValue(newValue, forKey: "totalCount")
      }
    }
  }
}

public struct RepoEventFields: GraphQLFragment {
  public static let fragmentString =
    "fragment repoEventFields on Comment {\n  __typename\n  createdAt\n  author {\n    __typename\n    login\n  }\n}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("author", type: .object(Author.selections)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "Issue", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }])
  }

  public static func makeCommitComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "CommitComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }])
  }

  public static func makePullRequest(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "PullRequest", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }])
  }

  public static func makeIssueComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "IssueComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }])
  }

  public static func makePullRequestReview(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "PullRequestReview", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }])
  }

  public static func makePullRequestReviewComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "PullRequestReviewComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }])
  }

  public static func makeGistComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "GistComment", "createdAt": createdAt, "author": author.flatMap { (value: Author) -> Snapshot in value.snapshot }])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return snapshot["createdAt"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (snapshot["author"] as? Snapshot).flatMap { Author(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "author")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User", "Bot"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public static func makeOrganization(login: String) -> Author {
      return Author(snapshot: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Author {
      return Author(snapshot: ["__typename": "User", "login": login])
    }

    public static func makeBot(login: String) -> Author {
      return Author(snapshot: ["__typename": "Bot", "login": login])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return snapshot["login"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "login")
      }
    }
  }
}

public struct CommitContext: GraphQLFragment {
  public static let fragmentString =
    "fragment commitContext on Commit {\n  __typename\n  id\n  status {\n    __typename\n    contexts {\n      __typename\n      id\n      context\n      state\n      creator {\n        __typename\n        login\n        avatarUrl\n      }\n      description\n      targetUrl\n    }\n    state\n  }\n}"

  public static let possibleTypes = ["Commit"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("status", type: .object(Status.selections)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: GraphQLID, status: Status? = nil) {
    self.init(snapshot: ["__typename": "Commit", "id": id, "status": status.flatMap { (value: Status) -> Snapshot in value.snapshot }])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  /// Status information for this commit
  public var status: Status? {
    get {
      return (snapshot["status"] as? Snapshot).flatMap { Status(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "status")
    }
  }

  public struct Status: GraphQLSelectionSet {
    public static let possibleTypes = ["Status"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("contexts", type: .nonNull(.list(.nonNull(.object(Context.selections))))),
      GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(contexts: [Context], state: StatusState) {
      self.init(snapshot: ["__typename": "Status", "contexts": contexts.map { (value: Context) -> Snapshot in value.snapshot }, "state": state])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The individual status contexts for this commit.
    public var contexts: [Context] {
      get {
        return (snapshot["contexts"] as! [Snapshot]).map { (value: Snapshot) -> Context in Context(snapshot: value) }
      }
      set {
        snapshot.updateValue(newValue.map { (value: Context) -> Snapshot in value.snapshot }, forKey: "contexts")
      }
    }

    /// The combined commit status.
    public var state: StatusState {
      get {
        return snapshot["state"]! as! StatusState
      }
      set {
        snapshot.updateValue(newValue, forKey: "state")
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

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, context: String, state: StatusState, creator: Creator? = nil, description: String? = nil, targetUrl: String? = nil) {
        self.init(snapshot: ["__typename": "StatusContext", "id": id, "context": context, "state": state, "creator": creator.flatMap { (value: Creator) -> Snapshot in value.snapshot }, "description": description, "targetUrl": targetUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// The name of this status context.
      public var context: String {
        get {
          return snapshot["context"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "context")
        }
      }

      /// The state of this status context.
      public var state: StatusState {
        get {
          return snapshot["state"]! as! StatusState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      /// The actor who created this status context.
      public var creator: Creator? {
        get {
          return (snapshot["creator"] as? Snapshot).flatMap { Creator(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "creator")
        }
      }

      /// The description for this status context.
      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      /// The URL for this status context.
      public var targetUrl: String? {
        get {
          return snapshot["targetUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "targetUrl")
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes = ["Organization", "User", "Bot"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeOrganization(login: String, avatarUrl: String) -> Creator {
          return Creator(snapshot: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
        }

        public static func makeUser(login: String, avatarUrl: String) -> Creator {
          return Creator(snapshot: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
        }

        public static func makeBot(login: String, avatarUrl: String) -> Creator {
          return Creator(snapshot: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The username of the actor.
        public var login: String {
          get {
            return snapshot["login"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "login")
          }
        }

        /// A URL pointing to the actor's public avatar.
        public var avatarUrl: String {
          get {
            return snapshot["avatarUrl"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "avatarUrl")
          }
        }
      }
    }
  }
}