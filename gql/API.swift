//  This file was automatically generated and should not be edited.

import Apollo

/// Emojis that can be attached to Issues, Pull Requests and Comments.
public enum ReactionContent: String {
  /// Represents the 👍 emoji.
  case thumbsUp = "THUMBS_UP"
  /// Represents the 👎 emoji.
  case thumbsDown = "THUMBS_DOWN"
  /// Represents the 😄 emoji.
  case laugh = "LAUGH"
  /// Represents the 🎉 emoji.
  case hooray = "HOORAY"
  /// Represents the 😕 emoji.
  case confused = "CONFUSED"
  /// Represents the ❤️ emoji.
  case heart = "HEART"
}

extension ReactionContent: Apollo.JSONDecodable, Apollo.JSONEncodable {}

/// The possible states of a pull request review.
public enum PullRequestReviewState: String {
  /// A review that has not yet been submitted.
  case pending = "PENDING"
  /// An informational review.
  case commented = "COMMENTED"
  /// A review allowing the pull request to merge.
  case approved = "APPROVED"
  /// A review blocking the pull request from merging.
  case changesRequested = "CHANGES_REQUESTED"
  /// A review that has been dismissed.
  case dismissed = "DISMISSED"
}

extension PullRequestReviewState: Apollo.JSONDecodable, Apollo.JSONEncodable {}

/// The possible states of an issue.
public enum IssueState: String {
  /// An issue that is still open
  case `open` = "OPEN"
  /// An issue that has been closed
  case closed = "CLOSED"
}

extension IssueState: Apollo.JSONDecodable, Apollo.JSONEncodable {}

/// The possible states of a pull request.
public enum PullRequestState: String {
  /// A pull request that is still open.
  case `open` = "OPEN"
  /// A pull request that has been closed without being merged.
  case closed = "CLOSED"
  /// A pull request that has been closed by being merged.
  case merged = "MERGED"
}

extension PullRequestState: Apollo.JSONDecodable, Apollo.JSONEncodable {}

public final class AddCommentMutation: GraphQLMutation {
  public static let operationString =
    "mutation AddComment($subject_id: ID!, $body: String!) {" +
    "  addComment(input: {subjectId: $subject_id, body: $body}) {" +
    "    __typename" +
    "    commentEdge {" +
    "      __typename" +
    "      node {" +
    "        __typename" +
    "        ...nodeFields" +
    "        ...reactionFields" +
    "        ...commentFields" +
    "        ...updatableFields" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(NodeFields.fragmentString).appending(ReactionFields.fragmentString).appending(CommentFields.fragmentString).appending(UpdatableFields.fragmentString) }

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
      GraphQLField("addComment", arguments: ["input": ["subjectId": Variable("subject_id"), "body": Variable("body")]], type: .object(AddComment.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addComment: AddComment? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "addComment": addComment])
    }

    /// Adds a comment to an Issue or Pull Request.
    public var addComment: AddComment? {
      get {
        return (snapshot["addComment"]! as! Snapshot?).flatMap { AddComment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "addComment")
      }
    }

    public struct AddComment: GraphQLSelectionSet {
      public static let possibleTypes = ["AddCommentPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("commentEdge", type: .nonNull(.object(CommentEdge.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(commentEdge: CommentEdge) {
        self.init(snapshot: ["__typename": "AddCommentPayload", "commentEdge": commentEdge])
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
          GraphQLField("node", type: .object(Node.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(node: Node? = nil) {
          self.init(snapshot: ["__typename": "IssueCommentEdge", "node": node])
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
            return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["IssueComment"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
            GraphQLField("author", type: .object(Author.self)),
            GraphQLField("editor", type: .object(Editor.self)),
            GraphQLField("lastEditedAt", type: .scalar(String.self)),
            GraphQLField("body", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool) {
            self.init(snapshot: ["__typename": "IssueComment", "id": id, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate])
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
              return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
            }
            set {
              snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// The actor who edited the comment.
          public var editor: Editor? {
            get {
              return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "editor")
            }
          }

          /// The moment the editor made the last edit
          public var lastEditedAt: String? {
            get {
              return snapshot["lastEditedAt"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "lastEditedAt")
            }
          }

          /// Identifies the comment body.
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

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }
          }

          public struct ReactionGroup: GraphQLSelectionSet {
            public static let possibleTypes = ["ReactionGroup"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
              GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
              self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
                GraphQLField("nodes", type: .list(.object(Node.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(nodes: [Node?]? = nil, totalCount: Int) {
                self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                  return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                }
                set {
                  snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
    "mutation AddReaction($subject_id: ID!, $content: ReactionContent!) {" +
    "  addReaction(input: {subjectId: $subject_id, content: $content}) {" +
    "    __typename" +
    "    subject {" +
    "      __typename" +
    "      ...reactionFields" +
    "    }" +
    "  }" +
    "}"

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
      GraphQLField("addReaction", arguments: ["input": ["subjectId": Variable("subject_id"), "content": Variable("content")]], type: .object(AddReaction.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addReaction: AddReaction? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "addReaction": addReaction])
    }

    /// Adds a reaction to a subject.
    public var addReaction: AddReaction? {
      get {
        return (snapshot["addReaction"]! as! Snapshot?).flatMap { AddReaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "addReaction")
      }
    }

    public struct AddReaction: GraphQLSelectionSet {
      public static let possibleTypes = ["AddReactionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("subject", type: .nonNull(.object(Subject.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(subject: Subject) {
        self.init(snapshot: ["__typename": "AddReactionPayload", "subject": subject])
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
          GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "Issue", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makeCommitComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "CommitComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makePullRequest(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequest", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makeIssueComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "IssueComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makePullRequestReviewComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
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
            return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var reactionFields: ReactionFields {
            get {
              return ReactionFields(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }
        }

        public struct ReactionGroup: GraphQLSelectionSet {
          public static let possibleTypes = ["ReactionGroup"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
            GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
            self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
              GraphQLField("nodes", type: .list(.object(Node.self))),
              GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil, totalCount: Int) {
              self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

public final class IssueOrPullRequestQuery: GraphQLQuery {
  public static let operationString =
    "query IssueOrPullRequest($owner: String!, $repo: String!, $number: Int!, $page_size: Int!, $before: String) {" +
    "  repository(owner: $owner, name: $repo) {" +
    "    __typename" +
    "    name" +
    "    hasIssuesEnabled" +
    "    viewerCanAdminister" +
    "    mentionableUsers(first: 100) {" +
    "      __typename" +
    "      nodes {" +
    "        __typename" +
    "        avatarUrl" +
    "        login" +
    "      }" +
    "    }" +
    "    issueOrPullRequest(number: $number) {" +
    "      __typename" +
    "      ... on Issue {" +
    "        __typename" +
    "        timeline(last: $page_size, before: $before) {" +
    "          __typename" +
    "          pageInfo {" +
    "            __typename" +
    "            ...headPaging" +
    "          }" +
    "          nodes {" +
    "            __typename" +
    "            ... on Commit {" +
    "              __typename" +
    "              ...nodeFields" +
    "              author {" +
    "                __typename" +
    "                user {" +
    "                  __typename" +
    "                  login" +
    "                  avatarUrl" +
    "                }" +
    "              }" +
    "              oid" +
    "              messageHeadline" +
    "            }" +
    "            ... on IssueComment {" +
    "              __typename" +
    "              ...nodeFields" +
    "              ...reactionFields" +
    "              ...commentFields" +
    "              ...updatableFields" +
    "            }" +
    "            ... on LabeledEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              label {" +
    "                __typename" +
    "                color" +
    "                name" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on UnlabeledEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              label {" +
    "                __typename" +
    "                color" +
    "                name" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on ClosedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              closedCommit: commit {" +
    "                __typename" +
    "                oid" +
    "              }" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on ReopenedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on RenamedTitleEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "              currentTitle" +
    "            }" +
    "            ... on LockedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on UnlockedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on ReferencedEvent {" +
    "              __typename" +
    "              createdAt" +
    "              ...nodeFields" +
    "              refCommit: commit {" +
    "                __typename" +
    "                oid" +
    "              }" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              commitRepository {" +
    "                __typename" +
    "                ...referencedRepositoryFields" +
    "              }" +
    "              subject {" +
    "                __typename" +
    "                ... on Issue {" +
    "                  __typename" +
    "                  title" +
    "                  number" +
    "                  closed" +
    "                }" +
    "                ... on PullRequest {" +
    "                  __typename" +
    "                  title" +
    "                  number" +
    "                  closed" +
    "                  merged" +
    "                }" +
    "              }" +
    "            }" +
    "            ... on RenamedTitleEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              currentTitle" +
    "              previousTitle" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on AssignedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              user {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on UnassignedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              user {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on MilestonedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              milestoneTitle" +
    "            }" +
    "            ... on DemilestonedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              milestoneTitle" +
    "            }" +
    "          }" +
    "        }" +
    "        milestone {" +
    "          __typename" +
    "          ...milestoneFields" +
    "        }" +
    "        ...reactionFields" +
    "        ...commentFields" +
    "        ...lockableFields" +
    "        ...closableFields" +
    "        ...labelableFields" +
    "        ...updatableFields" +
    "        ...nodeFields" +
    "        ...assigneeFields" +
    "        number" +
    "        title" +
    "      }" +
    "      ... on PullRequest {" +
    "        __typename" +
    "        timeline(last: $page_size, before: $before) {" +
    "          __typename" +
    "          pageInfo {" +
    "            __typename" +
    "            ...headPaging" +
    "          }" +
    "          nodes {" +
    "            __typename" +
    "            ... on Commit {" +
    "              __typename" +
    "              ...nodeFields" +
    "              author {" +
    "                __typename" +
    "                user {" +
    "                  __typename" +
    "                  login" +
    "                  avatarUrl" +
    "                }" +
    "              }" +
    "              oid" +
    "              messageHeadline" +
    "            }" +
    "            ... on IssueComment {" +
    "              __typename" +
    "              ...nodeFields" +
    "              ...reactionFields" +
    "              ...commentFields" +
    "              ...updatableFields" +
    "            }" +
    "            ... on LabeledEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              label {" +
    "                __typename" +
    "                color" +
    "                name" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on UnlabeledEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              label {" +
    "                __typename" +
    "                color" +
    "                name" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on ClosedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              closedCommit: commit {" +
    "                __typename" +
    "                oid" +
    "              }" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on ReopenedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on RenamedTitleEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "              currentTitle" +
    "            }" +
    "            ... on LockedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on UnlockedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on MergedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              mergedCommit: commit {" +
    "                __typename" +
    "                oid" +
    "              }" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              createdAt" +
    "            }" +
    "            ... on PullRequestReviewThread {" +
    "              __typename" +
    "              comments(first: $page_size) {" +
    "                __typename" +
    "                nodes {" +
    "                  __typename" +
    "                  ...reactionFields" +
    "                  ...nodeFields" +
    "                  ...commentFields" +
    "                  path" +
    "                  diffHunk" +
    "                }" +
    "              }" +
    "            }" +
    "            ... on PullRequestReview {" +
    "              __typename" +
    "              ...nodeFields" +
    "              ...commentFields" +
    "              state" +
    "              submittedAt" +
    "              author {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on ReferencedEvent {" +
    "              __typename" +
    "              createdAt" +
    "              ...nodeFields" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              commitRepository {" +
    "                __typename" +
    "                ...referencedRepositoryFields" +
    "              }" +
    "              subject {" +
    "                __typename" +
    "                ... on Issue {" +
    "                  __typename" +
    "                  title" +
    "                  number" +
    "                  closed" +
    "                }" +
    "                ... on PullRequest {" +
    "                  __typename" +
    "                  title" +
    "                  number" +
    "                  closed" +
    "                  merged" +
    "                }" +
    "              }" +
    "            }" +
    "            ... on RenamedTitleEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              currentTitle" +
    "              previousTitle" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on AssignedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              user {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on UnassignedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              user {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on ReviewRequestedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              subject {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on ReviewRequestRemovedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              subject {" +
    "                __typename" +
    "                login" +
    "              }" +
    "            }" +
    "            ... on MilestonedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              milestoneTitle" +
    "            }" +
    "            ... on DemilestonedEvent {" +
    "              __typename" +
    "              ...nodeFields" +
    "              createdAt" +
    "              actor {" +
    "                __typename" +
    "                login" +
    "              }" +
    "              milestoneTitle" +
    "            }" +
    "          }" +
    "        }" +
    "        reviewRequests(first: $page_size) {" +
    "          __typename" +
    "          nodes {" +
    "            __typename" +
    "            reviewer {" +
    "              __typename" +
    "              login" +
    "              avatarUrl" +
    "            }" +
    "          }" +
    "        }" +
    "        milestone {" +
    "          __typename" +
    "          ...milestoneFields" +
    "        }" +
    "        ...reactionFields" +
    "        ...commentFields" +
    "        ...lockableFields" +
    "        ...closableFields" +
    "        ...labelableFields" +
    "        ...updatableFields" +
    "        ...nodeFields" +
    "        ...assigneeFields" +
    "        number" +
    "        title" +
    "        merged" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(HeadPaging.fragmentString).appending(NodeFields.fragmentString).appending(ReactionFields.fragmentString).appending(CommentFields.fragmentString).appending(UpdatableFields.fragmentString).appending(ReferencedRepositoryFields.fragmentString).appending(MilestoneFields.fragmentString).appending(LockableFields.fragmentString).appending(ClosableFields.fragmentString).appending(LabelableFields.fragmentString).appending(AssigneeFields.fragmentString) }

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
      GraphQLField("repository", arguments: ["owner": Variable("owner"), "name": Variable("repo")], type: .object(Repository.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"]! as! Snapshot?).flatMap { Repository(snapshot: $0) }
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
        GraphQLField("mentionableUsers", arguments: ["first": 100], type: .nonNull(.object(MentionableUser.self))),
        GraphQLField("issueOrPullRequest", arguments: ["number": Variable("number")], type: .object(IssueOrPullRequest.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(name: String, hasIssuesEnabled: Bool, viewerCanAdminister: Bool, mentionableUsers: MentionableUser, issueOrPullRequest: IssueOrPullRequest? = nil) {
        self.init(snapshot: ["__typename": "Repository", "name": name, "hasIssuesEnabled": hasIssuesEnabled, "viewerCanAdminister": viewerCanAdminister, "mentionableUsers": mentionableUsers, "issueOrPullRequest": issueOrPullRequest])
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

      /// A list of Users that can be mentioned in the context of the repository.
      public var mentionableUsers: MentionableUser {
        get {
          return MentionableUser(snapshot: snapshot["mentionableUsers"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "mentionableUsers")
        }
      }

      /// Returns a single issue-like object from the current repository by number.
      public var issueOrPullRequest: IssueOrPullRequest? {
        get {
          return (snapshot["issueOrPullRequest"]! as! Snapshot?).flatMap { IssueOrPullRequest(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "issueOrPullRequest")
        }
      }

      public struct MentionableUser: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil) {
          self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes])
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
            return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

      public struct IssueOrPullRequest: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "PullRequest"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(AsIssue.self),
          GraphQLFragmentSpread(AsPullRequest.self),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue(timeline: AsIssue.Timeline, milestone: AsIssue.Milestone? = nil, viewerCanReact: Bool, reactionGroups: [AsIssue.ReactionGroup]? = nil, author: AsIssue.Author? = nil, editor: AsIssue.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: AsIssue.Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: AsIssue.Assignee, number: Int, title: String) -> IssueOrPullRequest {
          return IssueOrPullRequest(snapshot: ["__typename": "Issue", "timeline": timeline, "milestone": milestone, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees, "number": number, "title": title])
        }

        public static func makePullRequest(timeline: AsPullRequest.Timeline, milestone: AsPullRequest.Milestone? = nil, viewerCanReact: Bool, reactionGroups: [AsPullRequest.ReactionGroup]? = nil, author: AsPullRequest.Author? = nil, editor: AsPullRequest.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: AsPullRequest.Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: AsPullRequest.Assignee, number: Int, title: String, reviewRequests: AsPullRequest.ReviewRequest? = nil, merged: Bool) -> IssueOrPullRequest {
          return IssueOrPullRequest(snapshot: ["__typename": "PullRequest", "timeline": timeline, "milestone": milestone, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees, "number": number, "title": title, "reviewRequests": reviewRequests, "merged": merged])
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

        public struct AsIssue: GraphQLFragment {
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("timeline", arguments: ["last": Variable("page_size"), "before": Variable("before")], type: .nonNull(.object(Timeline.self))),
            GraphQLField("milestone", type: .object(Milestone.self)),
            GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
            GraphQLField("author", type: .object(Author.self)),
            GraphQLField("editor", type: .object(Editor.self)),
            GraphQLField("lastEditedAt", type: .scalar(String.self)),
            GraphQLField("body", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("locked", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("labels", arguments: ["first": 100], type: .object(Label.self)),
            GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("assignees", arguments: ["first": Variable("page_size")], type: .nonNull(.object(Assignee.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(timeline: Timeline, milestone: Milestone? = nil, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: Assignee, number: Int, title: String) {
            self.init(snapshot: ["__typename": "Issue", "timeline": timeline, "milestone": milestone, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees, "number": number, "title": title])
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
              return (snapshot["milestone"]! as! Snapshot?).flatMap { Milestone(snapshot: $0) }
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
              return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
            }
            set {
              snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// The actor who edited the comment.
          public var editor: Editor? {
            get {
              return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "editor")
            }
          }

          /// The moment the editor made the last edit
          public var lastEditedAt: String? {
            get {
              return snapshot["lastEditedAt"]! as! String?
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
              return (snapshot["labels"]! as! Snapshot?).flatMap { Label(snapshot: $0) }
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
              snapshot = newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var lockableFields: LockableFields {
              get {
                return LockableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var closableFields: ClosableFields {
              get {
                return ClosableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var assigneeFields: AssigneeFields {
              get {
                return AssigneeFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }
          }

          public struct Timeline: GraphQLSelectionSet {
            public static let possibleTypes = ["IssueTimelineConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.self))),
              GraphQLField("nodes", type: .list(.object(Node.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "IssueTimelineConnection", "pageInfo": pageInfo, "nodes": nodes])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
              }
            }

            public struct PageInfo: GraphQLSelectionSet {
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
                  return snapshot["startCursor"]! as! String?
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
                  snapshot = newValue.snapshot
                }
              }

              public struct Fragments {
                public var snapshot: Snapshot

                public var headPaging: HeadPaging {
                  get {
                    return HeadPaging(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Commit", "IssueComment", "CrossReferencedEvent", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "ReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(AsCommit.self),
                GraphQLFragmentSpread(AsIssueComment.self),
                GraphQLFragmentSpread(AsLabeledEvent.self),
                GraphQLFragmentSpread(AsUnlabeledEvent.self),
                GraphQLFragmentSpread(AsClosedEvent.self),
                GraphQLFragmentSpread(AsReopenedEvent.self),
                GraphQLFragmentSpread(AsRenamedTitleEvent.self),
                GraphQLFragmentSpread(AsLockedEvent.self),
                GraphQLFragmentSpread(AsUnlockedEvent.self),
                GraphQLFragmentSpread(AsReferencedEvent.self),
                GraphQLFragmentSpread(AsAssignedEvent.self),
                GraphQLFragmentSpread(AsUnassignedEvent.self),
                GraphQLFragmentSpread(AsMilestonedEvent.self),
                GraphQLFragmentSpread(AsDemilestonedEvent.self),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public static func makeCommit(id: GraphQLID, author: AsCommit.Author? = nil, oid: String, messageHeadline: String) -> Node {
                return Node(snapshot: ["__typename": "Commit", "id": id, "author": author, "oid": oid, "messageHeadline": messageHeadline])
              }

              public static func makeIssueComment(id: GraphQLID, author: AsIssueComment.Author? = nil, viewerCanReact: Bool, reactionGroups: [AsIssueComment.ReactionGroup]? = nil, editor: AsIssueComment.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool) -> Node {
                return Node(snapshot: ["__typename": "IssueComment", "id": id, "author": author, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate])
              }

              public static func makeCrossReferencedEvent() -> Node {
                return Node(snapshot: ["__typename": "CrossReferencedEvent"])
              }

              public static func makeClosedEvent(id: GraphQLID, createdAt: String, actor: AsClosedEvent.Actor? = nil, closedCommit: AsClosedEvent.ClosedCommit? = nil) -> Node {
                return Node(snapshot: ["__typename": "ClosedEvent", "id": id, "createdAt": createdAt, "actor": actor, "closedCommit": closedCommit])
              }

              public static func makeReopenedEvent(id: GraphQLID, createdAt: String, actor: AsReopenedEvent.Actor? = nil) -> Node {
                return Node(snapshot: ["__typename": "ReopenedEvent", "id": id, "createdAt": createdAt, "actor": actor])
              }

              public static func makeSubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "SubscribedEvent"])
              }

              public static func makeUnsubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "UnsubscribedEvent"])
              }

              public static func makeReferencedEvent(id: GraphQLID, createdAt: String, actor: AsReferencedEvent.Actor? = nil, refCommit: AsReferencedEvent.RefCommit? = nil, commitRepository: AsReferencedEvent.CommitRepository, subject: AsReferencedEvent.Subject) -> Node {
                return Node(snapshot: ["__typename": "ReferencedEvent", "id": id, "createdAt": createdAt, "actor": actor, "refCommit": refCommit, "commitRepository": commitRepository, "subject": subject])
              }

              public static func makeAssignedEvent(id: GraphQLID, createdAt: String, actor: AsAssignedEvent.Actor? = nil, user: AsAssignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
              }

              public static func makeUnassignedEvent(id: GraphQLID, createdAt: String, actor: AsUnassignedEvent.Actor? = nil, user: AsUnassignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
              }

              public static func makeLabeledEvent(id: GraphQLID, createdAt: String, actor: AsLabeledEvent.Actor? = nil, label: AsLabeledEvent.Label) -> Node {
                return Node(snapshot: ["__typename": "LabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
              }

              public static func makeUnlabeledEvent(id: GraphQLID, createdAt: String, actor: AsUnlabeledEvent.Actor? = nil, label: AsUnlabeledEvent.Label) -> Node {
                return Node(snapshot: ["__typename": "UnlabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
              }

              public static func makeMilestonedEvent(id: GraphQLID, createdAt: String, actor: AsMilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
              }

              public static func makeDemilestonedEvent(id: GraphQLID, createdAt: String, actor: AsDemilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
              }

              public static func makeRenamedTitleEvent(id: GraphQLID, createdAt: String, actor: AsRenamedTitleEvent.Actor? = nil, currentTitle: String, previousTitle: String) -> Node {
                return Node(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "createdAt": createdAt, "actor": actor, "currentTitle": currentTitle, "previousTitle": previousTitle])
              }

              public static func makeLockedEvent(id: GraphQLID, createdAt: String, actor: AsLockedEvent.Actor? = nil) -> Node {
                return Node(snapshot: ["__typename": "LockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
              }

              public static func makeUnlockedEvent(id: GraphQLID, createdAt: String, actor: AsUnlockedEvent.Actor? = nil) -> Node {
                return Node(snapshot: ["__typename": "UnlockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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

              public struct AsCommit: GraphQLFragment {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("author", type: .object(Author.self)),
                  GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("messageHeadline", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, oid: String, messageHeadline: String) {
                  self.init(snapshot: ["__typename": "Commit", "id": id, "author": author, "oid": oid, "messageHeadline": messageHeadline])
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

                /// Authorship details of the commit.
                public var author: Author? {
                  get {
                    return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["GitActor"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("user", type: .object(User.self)),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(user: User? = nil) {
                    self.init(snapshot: ["__typename": "GitActor", "user": user])
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
                      return (snapshot["user"]! as! Snapshot?).flatMap { User(snapshot: $0) }
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

              public struct AsIssueComment: GraphQLFragment {
                public static let possibleTypes = ["IssueComment"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("author", type: .object(Author.self)),
                  GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
                  GraphQLField("editor", type: .object(Editor.self)),
                  GraphQLField("lastEditedAt", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool) {
                  self.init(snapshot: ["__typename": "IssueComment", "id": id, "author": author, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate])
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

                /// The actor who authored the comment.
                public var author: Author? {
                  get {
                    return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
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
                    return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
                  }
                  set {
                    snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
                  }
                }

                /// The actor who edited the comment.
                public var editor: Editor? {
                  get {
                    return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                  }
                }

                /// The moment the editor made the last edit
                public var lastEditedAt: String? {
                  get {
                    return snapshot["lastEditedAt"]! as! String?
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "lastEditedAt")
                  }
                }

                /// Identifies the comment body.
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

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }

                  public var reactionFields: ReactionFields {
                    get {
                      return ReactionFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }

                  public var updatableFields: UpdatableFields {
                    get {
                      return UpdatableFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

                public struct ReactionGroup: GraphQLSelectionSet {
                  public static let possibleTypes = ["ReactionGroup"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
                    GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
                    GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
                    self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
                      GraphQLField("nodes", type: .list(.object(Node.self))),
                      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(nodes: [Node?]? = nil, totalCount: Int) {
                      self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                        return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                      }
                      set {
                        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

              public struct AsLabeledEvent: GraphQLFragment {
                public static let possibleTypes = ["LabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("label", type: .nonNull(.object(Label.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, label: Label) {
                  self.init(snapshot: ["__typename": "LabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsUnlabeledEvent: GraphQLFragment {
                public static let possibleTypes = ["UnlabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("label", type: .nonNull(.object(Label.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, label: Label) {
                  self.init(snapshot: ["__typename": "UnlabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsClosedEvent: GraphQLFragment {
                public static let possibleTypes = ["ClosedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("commit", alias: "closedCommit", type: .object(ClosedCommit.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, closedCommit: ClosedCommit? = nil) {
                  self.init(snapshot: ["__typename": "ClosedEvent", "id": id, "createdAt": createdAt, "actor": actor, "closedCommit": closedCommit])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the commit associated with the 'closed' event.
                public var closedCommit: ClosedCommit? {
                  get {
                    return (snapshot["closedCommit"]! as! Snapshot?).flatMap { ClosedCommit(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "closedCommit")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

                public struct ClosedCommit: GraphQLSelectionSet {
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

              public struct AsReopenedEvent: GraphQLFragment {
                public static let possibleTypes = ["ReopenedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil) {
                  self.init(snapshot: ["__typename": "ReopenedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsRenamedTitleEvent: GraphQLFragment {
                public static let possibleTypes = ["RenamedTitleEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("previousTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, currentTitle: String, previousTitle: String) {
                  self.init(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "createdAt": createdAt, "actor": actor, "currentTitle": currentTitle, "previousTitle": previousTitle])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsLockedEvent: GraphQLFragment {
                public static let possibleTypes = ["LockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil) {
                  self.init(snapshot: ["__typename": "LockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsUnlockedEvent: GraphQLFragment {
                public static let possibleTypes = ["UnlockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil) {
                  self.init(snapshot: ["__typename": "UnlockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsReferencedEvent: GraphQLFragment {
                public static let possibleTypes = ["ReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("commit", alias: "refCommit", type: .object(RefCommit.self)),
                  GraphQLField("commitRepository", type: .nonNull(.object(CommitRepository.self))),
                  GraphQLField("subject", type: .nonNull(.object(Subject.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, refCommit: RefCommit? = nil, commitRepository: CommitRepository, subject: Subject) {
                  self.init(snapshot: ["__typename": "ReferencedEvent", "id": id, "createdAt": createdAt, "actor": actor, "refCommit": refCommit, "commitRepository": commitRepository, "subject": subject])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the commit associated with the 'referenced' event.
                public var refCommit: RefCommit? {
                  get {
                    return (snapshot["refCommit"]! as! Snapshot?).flatMap { RefCommit(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "refCommit")
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

                public struct CommitRepository: GraphQLSelectionSet {
                  public static let possibleTypes = ["Repository"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("owner", type: .nonNull(.object(Owner.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(name: String, owner: Owner) {
                    self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner])
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
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct Fragments {
                    public var snapshot: Snapshot

                    public var referencedRepositoryFields: ReferencedRepositoryFields {
                      get {
                        return ReferencedRepositoryFields(snapshot: snapshot)
                      }
                      set {
                        snapshot = newValue.snapshot
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
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(AsIssue.self),
                    GraphQLFragmentSpread(AsPullRequest.self),
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

                  public struct AsIssue: GraphQLFragment {
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

                  public struct AsPullRequest: GraphQLFragment {
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

              public struct AsAssignedEvent: GraphQLFragment {
                public static let possibleTypes = ["AssignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("user", type: .object(User.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the user who was assigned.
                public var user: User? {
                  get {
                    return (snapshot["user"]! as! Snapshot?).flatMap { User(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsUnassignedEvent: GraphQLFragment {
                public static let possibleTypes = ["UnassignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("user", type: .object(User.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the subject (user) who was unassigned.
                public var user: User? {
                  get {
                    return (snapshot["user"]! as! Snapshot?).flatMap { User(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsMilestonedEvent: GraphQLFragment {
                public static let possibleTypes = ["MilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsDemilestonedEvent: GraphQLFragment {
                public static let possibleTypes = ["DemilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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
              GraphQLField("number", type: .nonNull(.scalar(Int.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(number: Int, title: String, url: String) {
              self.init(snapshot: ["__typename": "Milestone", "number": number, "title": title, "url": url])
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

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var milestoneFields: MilestoneFields {
                get {
                  return MilestoneFields(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }

          public struct ReactionGroup: GraphQLSelectionSet {
            public static let possibleTypes = ["ReactionGroup"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
              GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
              self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
                GraphQLField("nodes", type: .list(.object(Node.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(nodes: [Node?]? = nil, totalCount: Int) {
                self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                  return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                }
                set {
                  snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
              GraphQLField("nodes", type: .list(.object(Node.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
              GraphQLField("nodes", type: .list(.object(Node.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

        public struct AsPullRequest: GraphQLFragment {
          public static let possibleTypes = ["PullRequest"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("timeline", arguments: ["last": Variable("page_size"), "before": Variable("before")], type: .nonNull(.object(Timeline.self))),
            GraphQLField("milestone", type: .object(Milestone.self)),
            GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
            GraphQLField("author", type: .object(Author.self)),
            GraphQLField("editor", type: .object(Editor.self)),
            GraphQLField("lastEditedAt", type: .scalar(String.self)),
            GraphQLField("body", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("locked", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("closed", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("labels", arguments: ["first": 100], type: .object(Label.self)),
            GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("assignees", arguments: ["first": Variable("page_size")], type: .nonNull(.object(Assignee.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("reviewRequests", arguments: ["first": Variable("page_size")], type: .object(ReviewRequest.self)),
            GraphQLField("merged", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(timeline: Timeline, milestone: Milestone? = nil, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, locked: Bool, closed: Bool, labels: Label? = nil, viewerCanUpdate: Bool, id: GraphQLID, assignees: Assignee, number: Int, title: String, reviewRequests: ReviewRequest? = nil, merged: Bool) {
            self.init(snapshot: ["__typename": "PullRequest", "timeline": timeline, "milestone": milestone, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "locked": locked, "closed": closed, "labels": labels, "viewerCanUpdate": viewerCanUpdate, "id": id, "assignees": assignees, "number": number, "title": title, "reviewRequests": reviewRequests, "merged": merged])
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

          /// Identifies the milestone associated with the pull request.
          public var milestone: Milestone? {
            get {
              return (snapshot["milestone"]! as! Snapshot?).flatMap { Milestone(snapshot: $0) }
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
              return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
            }
            set {
              snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
            }
          }

          /// The actor who authored the comment.
          public var author: Author? {
            get {
              return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
            }
          }

          /// The actor who edited this pull request's body.
          public var editor: Editor? {
            get {
              return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "editor")
            }
          }

          /// The moment the editor made the last edit
          public var lastEditedAt: String? {
            get {
              return snapshot["lastEditedAt"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "lastEditedAt")
            }
          }

          /// Identifies the body of the pull request.
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
              return (snapshot["labels"]! as! Snapshot?).flatMap { Label(snapshot: $0) }
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

          /// A list of review requests associated with the pull request.
          public var reviewRequests: ReviewRequest? {
            get {
              return (snapshot["reviewRequests"]! as! Snapshot?).flatMap { ReviewRequest(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "reviewRequests")
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

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var reactionFields: ReactionFields {
              get {
                return ReactionFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var commentFields: CommentFields {
              get {
                return CommentFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var lockableFields: LockableFields {
              get {
                return LockableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var closableFields: ClosableFields {
              get {
                return ClosableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var labelableFields: LabelableFields {
              get {
                return LabelableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var updatableFields: UpdatableFields {
              get {
                return UpdatableFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var assigneeFields: AssigneeFields {
              get {
                return AssigneeFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }
          }

          public struct Timeline: GraphQLSelectionSet {
            public static let possibleTypes = ["PullRequestTimelineConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.self))),
              GraphQLField("nodes", type: .list(.object(Node.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "PullRequestTimelineConnection", "pageInfo": pageInfo, "nodes": nodes])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
              }
            }

            public struct PageInfo: GraphQLSelectionSet {
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
                  return snapshot["startCursor"]! as! String?
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
                  snapshot = newValue.snapshot
                }
              }

              public struct Fragments {
                public var snapshot: Snapshot

                public var headPaging: HeadPaging {
                  get {
                    return HeadPaging(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["Commit", "CommitCommentThread", "PullRequestReview", "PullRequestReviewThread", "PullRequestReviewComment", "IssueComment", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "MergedEvent", "ReferencedEvent", "CrossReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent", "DeployedEvent", "HeadRefDeletedEvent", "HeadRefRestoredEvent", "HeadRefForcePushedEvent", "BaseRefForcePushedEvent", "ReviewRequestedEvent", "ReviewRequestRemovedEvent", "ReviewDismissedEvent"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(AsCommit.self),
                GraphQLFragmentSpread(AsIssueComment.self),
                GraphQLFragmentSpread(AsLabeledEvent.self),
                GraphQLFragmentSpread(AsUnlabeledEvent.self),
                GraphQLFragmentSpread(AsClosedEvent.self),
                GraphQLFragmentSpread(AsReopenedEvent.self),
                GraphQLFragmentSpread(AsRenamedTitleEvent.self),
                GraphQLFragmentSpread(AsLockedEvent.self),
                GraphQLFragmentSpread(AsUnlockedEvent.self),
                GraphQLFragmentSpread(AsMergedEvent.self),
                GraphQLFragmentSpread(AsPullRequestReviewThread.self),
                GraphQLFragmentSpread(AsPullRequestReview.self),
                GraphQLFragmentSpread(AsReferencedEvent.self),
                GraphQLFragmentSpread(AsAssignedEvent.self),
                GraphQLFragmentSpread(AsUnassignedEvent.self),
                GraphQLFragmentSpread(AsReviewRequestedEvent.self),
                GraphQLFragmentSpread(AsReviewRequestRemovedEvent.self),
                GraphQLFragmentSpread(AsMilestonedEvent.self),
                GraphQLFragmentSpread(AsDemilestonedEvent.self),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public static func makeCommit(id: GraphQLID, author: AsCommit.Author? = nil, oid: String, messageHeadline: String) -> Node {
                return Node(snapshot: ["__typename": "Commit", "id": id, "author": author, "oid": oid, "messageHeadline": messageHeadline])
              }

              public static func makeCommitCommentThread() -> Node {
                return Node(snapshot: ["__typename": "CommitCommentThread"])
              }

              public static func makePullRequestReview(id: GraphQLID, author: AsPullRequestReview.Author? = nil, editor: AsPullRequestReview.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, state: PullRequestReviewState, submittedAt: String? = nil) -> Node {
                return Node(snapshot: ["__typename": "PullRequestReview", "id": id, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "state": state, "submittedAt": submittedAt])
              }

              public static func makePullRequestReviewThread(comments: AsPullRequestReviewThread.Comment) -> Node {
                return Node(snapshot: ["__typename": "PullRequestReviewThread", "comments": comments])
              }

              public static func makePullRequestReviewComment() -> Node {
                return Node(snapshot: ["__typename": "PullRequestReviewComment"])
              }

              public static func makeIssueComment(id: GraphQLID, author: AsIssueComment.Author? = nil, viewerCanReact: Bool, reactionGroups: [AsIssueComment.ReactionGroup]? = nil, editor: AsIssueComment.Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool) -> Node {
                return Node(snapshot: ["__typename": "IssueComment", "id": id, "author": author, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate])
              }

              public static func makeClosedEvent(id: GraphQLID, createdAt: String, actor: AsClosedEvent.Actor? = nil, closedCommit: AsClosedEvent.ClosedCommit? = nil) -> Node {
                return Node(snapshot: ["__typename": "ClosedEvent", "id": id, "createdAt": createdAt, "actor": actor, "closedCommit": closedCommit])
              }

              public static func makeReopenedEvent(id: GraphQLID, createdAt: String, actor: AsReopenedEvent.Actor? = nil) -> Node {
                return Node(snapshot: ["__typename": "ReopenedEvent", "id": id, "createdAt": createdAt, "actor": actor])
              }

              public static func makeSubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "SubscribedEvent"])
              }

              public static func makeUnsubscribedEvent() -> Node {
                return Node(snapshot: ["__typename": "UnsubscribedEvent"])
              }

              public static func makeMergedEvent(id: GraphQLID, createdAt: String, actor: AsMergedEvent.Actor? = nil, mergedCommit: AsMergedEvent.MergedCommit? = nil) -> Node {
                return Node(snapshot: ["__typename": "MergedEvent", "id": id, "createdAt": createdAt, "actor": actor, "mergedCommit": mergedCommit])
              }

              public static func makeReferencedEvent(id: GraphQLID, createdAt: String, actor: AsReferencedEvent.Actor? = nil, commitRepository: AsReferencedEvent.CommitRepository, subject: AsReferencedEvent.Subject) -> Node {
                return Node(snapshot: ["__typename": "ReferencedEvent", "id": id, "createdAt": createdAt, "actor": actor, "commitRepository": commitRepository, "subject": subject])
              }

              public static func makeCrossReferencedEvent() -> Node {
                return Node(snapshot: ["__typename": "CrossReferencedEvent"])
              }

              public static func makeAssignedEvent(id: GraphQLID, createdAt: String, actor: AsAssignedEvent.Actor? = nil, user: AsAssignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
              }

              public static func makeUnassignedEvent(id: GraphQLID, createdAt: String, actor: AsUnassignedEvent.Actor? = nil, user: AsUnassignedEvent.User? = nil) -> Node {
                return Node(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
              }

              public static func makeLabeledEvent(id: GraphQLID, createdAt: String, actor: AsLabeledEvent.Actor? = nil, label: AsLabeledEvent.Label) -> Node {
                return Node(snapshot: ["__typename": "LabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
              }

              public static func makeUnlabeledEvent(id: GraphQLID, createdAt: String, actor: AsUnlabeledEvent.Actor? = nil, label: AsUnlabeledEvent.Label) -> Node {
                return Node(snapshot: ["__typename": "UnlabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
              }

              public static func makeMilestonedEvent(id: GraphQLID, createdAt: String, actor: AsMilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
              }

              public static func makeDemilestonedEvent(id: GraphQLID, createdAt: String, actor: AsDemilestonedEvent.Actor? = nil, milestoneTitle: String) -> Node {
                return Node(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
              }

              public static func makeRenamedTitleEvent(id: GraphQLID, createdAt: String, actor: AsRenamedTitleEvent.Actor? = nil, currentTitle: String, previousTitle: String) -> Node {
                return Node(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "createdAt": createdAt, "actor": actor, "currentTitle": currentTitle, "previousTitle": previousTitle])
              }

              public static func makeLockedEvent(id: GraphQLID, createdAt: String, actor: AsLockedEvent.Actor? = nil) -> Node {
                return Node(snapshot: ["__typename": "LockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
              }

              public static func makeUnlockedEvent(id: GraphQLID, createdAt: String, actor: AsUnlockedEvent.Actor? = nil) -> Node {
                return Node(snapshot: ["__typename": "UnlockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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

              public static func makeReviewRequestedEvent(id: GraphQLID, createdAt: String, actor: AsReviewRequestedEvent.Actor? = nil, subject: AsReviewRequestedEvent.Subject) -> Node {
                return Node(snapshot: ["__typename": "ReviewRequestedEvent", "id": id, "createdAt": createdAt, "actor": actor, "subject": subject])
              }

              public static func makeReviewRequestRemovedEvent(id: GraphQLID, createdAt: String, actor: AsReviewRequestRemovedEvent.Actor? = nil, subject: AsReviewRequestRemovedEvent.Subject) -> Node {
                return Node(snapshot: ["__typename": "ReviewRequestRemovedEvent", "id": id, "createdAt": createdAt, "actor": actor, "subject": subject])
              }

              public static func makeReviewDismissedEvent() -> Node {
                return Node(snapshot: ["__typename": "ReviewDismissedEvent"])
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

              public struct AsCommit: GraphQLFragment {
                public static let possibleTypes = ["Commit"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("author", type: .object(Author.self)),
                  GraphQLField("oid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("messageHeadline", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, oid: String, messageHeadline: String) {
                  self.init(snapshot: ["__typename": "Commit", "id": id, "author": author, "oid": oid, "messageHeadline": messageHeadline])
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

                /// Authorship details of the commit.
                public var author: Author? {
                  get {
                    return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes = ["GitActor"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("user", type: .object(User.self)),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(user: User? = nil) {
                    self.init(snapshot: ["__typename": "GitActor", "user": user])
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
                      return (snapshot["user"]! as! Snapshot?).flatMap { User(snapshot: $0) }
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

              public struct AsIssueComment: GraphQLFragment {
                public static let possibleTypes = ["IssueComment"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("author", type: .object(Author.self)),
                  GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
                  GraphQLField("editor", type: .object(Editor.self)),
                  GraphQLField("lastEditedAt", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("viewerCanUpdate", type: .nonNull(.scalar(Bool.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, viewerCanUpdate: Bool) {
                  self.init(snapshot: ["__typename": "IssueComment", "id": id, "author": author, "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "viewerCanUpdate": viewerCanUpdate])
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

                /// The actor who authored the comment.
                public var author: Author? {
                  get {
                    return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
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
                    return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
                  }
                  set {
                    snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
                  }
                }

                /// The actor who edited the comment.
                public var editor: Editor? {
                  get {
                    return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                  }
                }

                /// The moment the editor made the last edit
                public var lastEditedAt: String? {
                  get {
                    return snapshot["lastEditedAt"]! as! String?
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "lastEditedAt")
                  }
                }

                /// Identifies the comment body.
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

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }

                  public var reactionFields: ReactionFields {
                    get {
                      return ReactionFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }

                  public var updatableFields: UpdatableFields {
                    get {
                      return UpdatableFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

                public struct ReactionGroup: GraphQLSelectionSet {
                  public static let possibleTypes = ["ReactionGroup"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
                    GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
                    GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
                    self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
                      GraphQLField("nodes", type: .list(.object(Node.self))),
                      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                    ]

                    public var snapshot: Snapshot

                    public init(snapshot: Snapshot) {
                      self.snapshot = snapshot
                    }

                    public init(nodes: [Node?]? = nil, totalCount: Int) {
                      self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                        return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                      }
                      set {
                        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

              public struct AsLabeledEvent: GraphQLFragment {
                public static let possibleTypes = ["LabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("label", type: .nonNull(.object(Label.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, label: Label) {
                  self.init(snapshot: ["__typename": "LabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsUnlabeledEvent: GraphQLFragment {
                public static let possibleTypes = ["UnlabeledEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("label", type: .nonNull(.object(Label.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, label: Label) {
                  self.init(snapshot: ["__typename": "UnlabeledEvent", "id": id, "createdAt": createdAt, "actor": actor, "label": label])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsClosedEvent: GraphQLFragment {
                public static let possibleTypes = ["ClosedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("commit", alias: "closedCommit", type: .object(ClosedCommit.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, closedCommit: ClosedCommit? = nil) {
                  self.init(snapshot: ["__typename": "ClosedEvent", "id": id, "createdAt": createdAt, "actor": actor, "closedCommit": closedCommit])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the commit associated with the 'closed' event.
                public var closedCommit: ClosedCommit? {
                  get {
                    return (snapshot["closedCommit"]! as! Snapshot?).flatMap { ClosedCommit(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "closedCommit")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

                public struct ClosedCommit: GraphQLSelectionSet {
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

              public struct AsReopenedEvent: GraphQLFragment {
                public static let possibleTypes = ["ReopenedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil) {
                  self.init(snapshot: ["__typename": "ReopenedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsRenamedTitleEvent: GraphQLFragment {
                public static let possibleTypes = ["RenamedTitleEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("currentTitle", type: .nonNull(.scalar(String.self))),
                  GraphQLField("previousTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, currentTitle: String, previousTitle: String) {
                  self.init(snapshot: ["__typename": "RenamedTitleEvent", "id": id, "createdAt": createdAt, "actor": actor, "currentTitle": currentTitle, "previousTitle": previousTitle])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsLockedEvent: GraphQLFragment {
                public static let possibleTypes = ["LockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil) {
                  self.init(snapshot: ["__typename": "LockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsUnlockedEvent: GraphQLFragment {
                public static let possibleTypes = ["UnlockedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil) {
                  self.init(snapshot: ["__typename": "UnlockedEvent", "id": id, "createdAt": createdAt, "actor": actor])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsMergedEvent: GraphQLFragment {
                public static let possibleTypes = ["MergedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("commit", alias: "mergedCommit", type: .object(MergedCommit.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, mergedCommit: MergedCommit? = nil) {
                  self.init(snapshot: ["__typename": "MergedEvent", "id": id, "createdAt": createdAt, "actor": actor, "mergedCommit": mergedCommit])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the commit associated with the `merge` event.
                public var mergedCommit: MergedCommit? {
                  get {
                    return (snapshot["mergedCommit"]! as! Snapshot?).flatMap { MergedCommit(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "mergedCommit")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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
              }

              public struct AsPullRequestReviewThread: GraphQLFragment {
                public static let possibleTypes = ["PullRequestReviewThread"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("comments", arguments: ["first": Variable("page_size")], type: .nonNull(.object(Comment.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(comments: Comment) {
                  self.init(snapshot: ["__typename": "PullRequestReviewThread", "comments": comments])
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
                    GraphQLField("nodes", type: .list(.object(Node.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(nodes: [Node?]? = nil) {
                    self.init(snapshot: ["__typename": "PullRequestReviewCommentConnection", "nodes": nodes])
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
                      return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                    }
                    set {
                      snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
                    }
                  }

                  public struct Node: GraphQLSelectionSet {
                    public static let possibleTypes = ["PullRequestReviewComment"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
                      GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
                      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                      GraphQLField("author", type: .object(Author.self)),
                      GraphQLField("editor", type: .object(Editor.self)),
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
                      self.init(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups, "id": id, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "path": path, "diffHunk": diffHunk])
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
                        return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
                      }
                      set {
                        snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
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

                    /// The actor who authored the comment.
                    public var author: Author? {
                      get {
                        return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
                      }
                      set {
                        snapshot.updateValue(newValue?.snapshot, forKey: "author")
                      }
                    }

                    /// The actor who edited the comment.
                    public var editor: Editor? {
                      get {
                        return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
                      }
                      set {
                        snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                      }
                    }

                    /// The moment the editor made the last edit
                    public var lastEditedAt: String? {
                      get {
                        return snapshot["lastEditedAt"]! as! String?
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
                        snapshot = newValue.snapshot
                      }
                    }

                    public struct Fragments {
                      public var snapshot: Snapshot

                      public var reactionFields: ReactionFields {
                        get {
                          return ReactionFields(snapshot: snapshot)
                        }
                        set {
                          snapshot = newValue.snapshot
                        }
                      }

                      public var nodeFields: NodeFields {
                        get {
                          return NodeFields(snapshot: snapshot)
                        }
                        set {
                          snapshot = newValue.snapshot
                        }
                      }

                      public var commentFields: CommentFields {
                        get {
                          return CommentFields(snapshot: snapshot)
                        }
                        set {
                          snapshot = newValue.snapshot
                        }
                      }
                    }

                    public struct ReactionGroup: GraphQLSelectionSet {
                      public static let possibleTypes = ["ReactionGroup"]

                      public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
                        GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
                        GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
                      ]

                      public var snapshot: Snapshot

                      public init(snapshot: Snapshot) {
                        self.snapshot = snapshot
                      }

                      public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
                        self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
                          GraphQLField("nodes", type: .list(.object(Node.self))),
                          GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                        ]

                        public var snapshot: Snapshot

                        public init(snapshot: Snapshot) {
                          self.snapshot = snapshot
                        }

                        public init(nodes: [Node?]? = nil, totalCount: Int) {
                          self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                            return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                          }
                          set {
                            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

              public struct AsPullRequestReview: GraphQLFragment {
                public static let possibleTypes = ["PullRequestReview"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("author", type: .object(Author.self)),
                  GraphQLField("editor", type: .object(Editor.self)),
                  GraphQLField("lastEditedAt", type: .scalar(String.self)),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("state", type: .nonNull(.scalar(PullRequestReviewState.self))),
                  GraphQLField("submittedAt", type: .scalar(String.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool, state: PullRequestReviewState, submittedAt: String? = nil) {
                  self.init(snapshot: ["__typename": "PullRequestReview", "id": id, "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor, "state": state, "submittedAt": submittedAt])
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

                /// The actor who authored the comment.
                public var author: Author? {
                  get {
                    return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "author")
                  }
                }

                /// The actor who edited the comment.
                public var editor: Editor? {
                  get {
                    return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "editor")
                  }
                }

                /// The moment the editor made the last edit
                public var lastEditedAt: String? {
                  get {
                    return snapshot["lastEditedAt"]! as! String?
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
                    return snapshot["submittedAt"]! as! String?
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "submittedAt")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(snapshot: snapshot)
                  }
                  set {
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
                    }
                  }

                  public var commentFields: CommentFields {
                    get {
                      return CommentFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsReferencedEvent: GraphQLFragment {
                public static let possibleTypes = ["ReferencedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("commitRepository", type: .nonNull(.object(CommitRepository.self))),
                  GraphQLField("subject", type: .nonNull(.object(Subject.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, commitRepository: CommitRepository, subject: Subject) {
                  self.init(snapshot: ["__typename": "ReferencedEvent", "id": id, "createdAt": createdAt, "actor": actor, "commitRepository": commitRepository, "subject": subject])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("owner", type: .nonNull(.object(Owner.self))),
                  ]

                  public var snapshot: Snapshot

                  public init(snapshot: Snapshot) {
                    self.snapshot = snapshot
                  }

                  public init(name: String, owner: Owner) {
                    self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner])
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
                      snapshot = newValue.snapshot
                    }
                  }

                  public struct Fragments {
                    public var snapshot: Snapshot

                    public var referencedRepositoryFields: ReferencedRepositoryFields {
                      get {
                        return ReferencedRepositoryFields(snapshot: snapshot)
                      }
                      set {
                        snapshot = newValue.snapshot
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
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(AsIssue.self),
                    GraphQLFragmentSpread(AsPullRequest.self),
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

                  public struct AsIssue: GraphQLFragment {
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

                  public struct AsPullRequest: GraphQLFragment {
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

              public struct AsAssignedEvent: GraphQLFragment {
                public static let possibleTypes = ["AssignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("user", type: .object(User.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "AssignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the user who was assigned.
                public var user: User? {
                  get {
                    return (snapshot["user"]! as! Snapshot?).flatMap { User(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsUnassignedEvent: GraphQLFragment {
                public static let possibleTypes = ["UnassignedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("user", type: .object(User.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, user: User? = nil) {
                  self.init(snapshot: ["__typename": "UnassignedEvent", "id": id, "createdAt": createdAt, "actor": actor, "user": user])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the subject (user) who was unassigned.
                public var user: User? {
                  get {
                    return (snapshot["user"]! as! Snapshot?).flatMap { User(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsReviewRequestedEvent: GraphQLFragment {
                public static let possibleTypes = ["ReviewRequestedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("subject", type: .nonNull(.object(Subject.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, subject: Subject) {
                  self.init(snapshot: ["__typename": "ReviewRequestedEvent", "id": id, "createdAt": createdAt, "actor": actor, "subject": subject])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the user whose review was requested.
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

                public struct Subject: GraphQLSelectionSet {
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

              public struct AsReviewRequestRemovedEvent: GraphQLFragment {
                public static let possibleTypes = ["ReviewRequestRemovedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("subject", type: .nonNull(.object(Subject.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, subject: Subject) {
                  self.init(snapshot: ["__typename": "ReviewRequestRemovedEvent", "id": id, "createdAt": createdAt, "actor": actor, "subject": subject])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
                  }
                  set {
                    snapshot.updateValue(newValue?.snapshot, forKey: "actor")
                  }
                }

                /// Identifies the user whose review request was removed.
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

                public struct Subject: GraphQLSelectionSet {
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

              public struct AsMilestonedEvent: GraphQLFragment {
                public static let possibleTypes = ["MilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "MilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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

              public struct AsDemilestonedEvent: GraphQLFragment {
                public static let possibleTypes = ["DemilestonedEvent"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("actor", type: .object(Actor.self)),
                  GraphQLField("milestoneTitle", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(id: GraphQLID, createdAt: String, actor: Actor? = nil, milestoneTitle: String) {
                  self.init(snapshot: ["__typename": "DemilestonedEvent", "id": id, "createdAt": createdAt, "actor": actor, "milestoneTitle": milestoneTitle])
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
                    return (snapshot["actor"]! as! Snapshot?).flatMap { Actor(snapshot: $0) }
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
                    snapshot = newValue.snapshot
                  }
                }

                public struct Fragments {
                  public var snapshot: Snapshot

                  public var nodeFields: NodeFields {
                    get {
                      return NodeFields(snapshot: snapshot)
                    }
                    set {
                      snapshot = newValue.snapshot
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
              GraphQLField("number", type: .nonNull(.scalar(Int.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(number: Int, title: String, url: String) {
              self.init(snapshot: ["__typename": "Milestone", "number": number, "title": title, "url": url])
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

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var milestoneFields: MilestoneFields {
                get {
                  return MilestoneFields(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }

          public struct ReactionGroup: GraphQLSelectionSet {
            public static let possibleTypes = ["ReactionGroup"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
              GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
              self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
                GraphQLField("nodes", type: .list(.object(Node.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(nodes: [Node?]? = nil, totalCount: Int) {
                self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                  return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                }
                set {
                  snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
              GraphQLField("nodes", type: .list(.object(Node.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
              GraphQLField("nodes", type: .list(.object(Node.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

          public struct ReviewRequest: GraphQLSelectionSet {
            public static let possibleTypes = ["ReviewRequestConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil) {
              self.init(snapshot: ["__typename": "ReviewRequestConnection", "nodes": nodes])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["ReviewRequest"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("reviewer", type: .object(Reviewer.self)),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(reviewer: Reviewer? = nil) {
                self.init(snapshot: ["__typename": "ReviewRequest", "reviewer": reviewer])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the author associated with this review request.
              public var reviewer: Reviewer? {
                get {
                  return (snapshot["reviewer"]! as! Snapshot?).flatMap { Reviewer(snapshot: $0) }
                }
                set {
                  snapshot.updateValue(newValue?.snapshot, forKey: "reviewer")
                }
              }

              public struct Reviewer: GraphQLSelectionSet {
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
}

public final class RemoveReactionMutation: GraphQLMutation {
  public static let operationString =
    "mutation RemoveReaction($subject_id: ID!, $content: ReactionContent!) {" +
    "  removeReaction(input: {subjectId: $subject_id, content: $content}) {" +
    "    __typename" +
    "    subject {" +
    "      __typename" +
    "      ...reactionFields" +
    "    }" +
    "  }" +
    "}"

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
      GraphQLField("removeReaction", arguments: ["input": ["subjectId": Variable("subject_id"), "content": Variable("content")]], type: .object(RemoveReaction.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(removeReaction: RemoveReaction? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "removeReaction": removeReaction])
    }

    /// Removes a reaction from a subject.
    public var removeReaction: RemoveReaction? {
      get {
        return (snapshot["removeReaction"]! as! Snapshot?).flatMap { RemoveReaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "removeReaction")
      }
    }

    public struct RemoveReaction: GraphQLSelectionSet {
      public static let possibleTypes = ["RemoveReactionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("subject", type: .nonNull(.object(Subject.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(subject: Subject) {
        self.init(snapshot: ["__typename": "RemoveReactionPayload", "subject": subject])
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
          GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "Issue", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makeCommitComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "CommitComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makePullRequest(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequest", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makeIssueComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "IssueComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
        }

        public static func makePullRequestReviewComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> Subject {
          return Subject(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
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
            return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var reactionFields: ReactionFields {
            get {
              return ReactionFields(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }
        }

        public struct ReactionGroup: GraphQLSelectionSet {
          public static let possibleTypes = ["ReactionGroup"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
            GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
            self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
              GraphQLField("nodes", type: .list(.object(Node.self))),
              GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(nodes: [Node?]? = nil, totalCount: Int) {
              self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
                return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
              }
              set {
                snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

public final class RepoIssuePagesQuery: GraphQLQuery {
  public static let operationString =
    "query RepoIssuePages($owner: String!, $name: String!, $after: String, $page_size: Int!) {" +
    "  repository(owner: $owner, name: $name) {" +
    "    __typename" +
    "    issues(first: $page_size, orderBy: {field: CREATED_AT, direction: DESC}, states: [OPEN, CLOSED], after: $after) {" +
    "      __typename" +
    "      nodes {" +
    "        __typename" +
    "        ...repoEventFields" +
    "        ...nodeFields" +
    "        title" +
    "        number" +
    "        state" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        hasNextPage" +
    "        endCursor" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(RepoEventFields.fragmentString).appending(NodeFields.fragmentString) }

  public var owner: String
  public var name: String
  public var after: String?
  public var page_size: Int

  public init(owner: String, name: String, after: String? = nil, page_size: Int) {
    self.owner = owner
    self.name = name
    self.after = after
    self.page_size = page_size
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "after": after, "page_size": page_size]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": Variable("owner"), "name": Variable("name")], type: .object(Repository.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"]! as! Snapshot?).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("issues", arguments: ["first": Variable("page_size"), "orderBy": ["field": "CREATED_AT", "direction": "DESC"], "states": ["OPEN", "CLOSED"], "after": Variable("after")], type: .nonNull(.object(Issue.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(issues: Issue) {
        self.init(snapshot: ["__typename": "Repository", "issues": issues])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of issues that have been opened in the repository.
      public var issues: Issue {
        get {
          return Issue(snapshot: snapshot["issues"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "issues")
        }
      }

      public struct Issue: GraphQLSelectionSet {
        public static let possibleTypes = ["IssueConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.self))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "IssueConnection", "nodes": nodes, "pageInfo": pageInfo])
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
            return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
          public static let possibleTypes = ["Issue"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("author", type: .object(Author.self)),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", type: .nonNull(.scalar(IssueState.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(createdAt: String, author: Author? = nil, id: GraphQLID, title: String, number: Int, state: IssueState) {
            self.init(snapshot: ["__typename": "Issue", "createdAt": createdAt, "author": author, "id": id, "title": title, "number": number, "state": state])
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
              return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
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
          public var state: IssueState {
            get {
              return snapshot["state"]! as! IssueState
            }
            set {
              snapshot.updateValue(newValue, forKey: "state")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var repoEventFields: RepoEventFields {
              get {
                return RepoEventFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
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
              return snapshot["endCursor"]! as! String?
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

public final class RepoPullRequestPagesQuery: GraphQLQuery {
  public static let operationString =
    "query RepoPullRequestPages($owner: String!, $name: String!, $after: String, $page_size: Int!) {" +
    "  repository(owner: $owner, name: $name) {" +
    "    __typename" +
    "    pullRequests(first: $page_size, orderBy: {field: CREATED_AT, direction: DESC}, states: [OPEN, CLOSED, MERGED], after: $after) {" +
    "      __typename" +
    "      nodes {" +
    "        __typename" +
    "        ...repoEventFields" +
    "        ...nodeFields" +
    "        title" +
    "        number" +
    "        state" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        hasNextPage" +
    "        endCursor" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(RepoEventFields.fragmentString).appending(NodeFields.fragmentString) }

  public var owner: String
  public var name: String
  public var after: String?
  public var page_size: Int

  public init(owner: String, name: String, after: String? = nil, page_size: Int) {
    self.owner = owner
    self.name = name
    self.after = after
    self.page_size = page_size
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "after": after, "page_size": page_size]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": Variable("owner"), "name": Variable("name")], type: .object(Repository.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"]! as! Snapshot?).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("pullRequests", arguments: ["first": Variable("page_size"), "orderBy": ["field": "CREATED_AT", "direction": "DESC"], "states": ["OPEN", "CLOSED", "MERGED"], "after": Variable("after")], type: .nonNull(.object(PullRequest.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(pullRequests: PullRequest) {
        self.init(snapshot: ["__typename": "Repository", "pullRequests": pullRequests])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of pull requests that have been opened in the repository.
      public var pullRequests: PullRequest {
        get {
          return PullRequest(snapshot: snapshot["pullRequests"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "pullRequests")
        }
      }

      public struct PullRequest: GraphQLSelectionSet {
        public static let possibleTypes = ["PullRequestConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.self))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "PullRequestConnection", "nodes": nodes, "pageInfo": pageInfo])
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
            return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
          public static let possibleTypes = ["PullRequest"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("author", type: .object(Author.self)),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", type: .nonNull(.scalar(PullRequestState.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(createdAt: String, author: Author? = nil, id: GraphQLID, title: String, number: Int, state: PullRequestState) {
            self.init(snapshot: ["__typename": "PullRequest", "createdAt": createdAt, "author": author, "id": id, "title": title, "number": number, "state": state])
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
              return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "author")
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
          public var state: PullRequestState {
            get {
              return snapshot["state"]! as! PullRequestState
            }
            set {
              snapshot.updateValue(newValue, forKey: "state")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var repoEventFields: RepoEventFields {
              get {
                return RepoEventFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public var nodeFields: NodeFields {
              get {
                return NodeFields(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
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
              return snapshot["endCursor"]! as! String?
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

public final class RepositoryLabelsQuery: GraphQLQuery {
  public static let operationString =
    "query RepositoryLabels($owner: String!, $repo: String!) {" +
    "  repository(owner: $owner, name: $repo) {" +
    "    __typename" +
    "    labels(first: 100) {" +
    "      __typename" +
    "      nodes {" +
    "        __typename" +
    "        name" +
    "        color" +
    "      }" +
    "    }" +
    "  }" +
    "}"

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
      GraphQLField("repository", arguments: ["owner": Variable("owner"), "name": Variable("repo")], type: .object(Repository.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"]! as! Snapshot?).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("labels", arguments: ["first": 100], type: .object(Label.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(labels: Label? = nil) {
        self.init(snapshot: ["__typename": "Repository", "labels": labels])
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
          return (snapshot["labels"]! as! Snapshot?).flatMap { Label(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "labels")
        }
      }

      public struct Label: GraphQLSelectionSet {
        public static let possibleTypes = ["LabelConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil) {
          self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes])
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
            return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
    "query SearchRepos($search: String!, $before: String) {" +
    "  search(first: 100, query: $search, type: REPOSITORY, before: $before) {" +
    "    __typename" +
    "    nodes {" +
    "      __typename" +
    "      ... on Repository {" +
    "        __typename" +
    "        id" +
    "        name" +
    "        hasIssuesEnabled" +
    "        owner {" +
    "          __typename" +
    "          login" +
    "        }" +
    "        description" +
    "        pushedAt" +
    "        primaryLanguage {" +
    "          __typename" +
    "          name" +
    "          color" +
    "        }" +
    "        stargazers {" +
    "          __typename" +
    "          totalCount" +
    "        }" +
    "      }" +
    "    }" +
    "    pageInfo {" +
    "      __typename" +
    "      endCursor" +
    "      hasNextPage" +
    "    }" +
    "    repositoryCount" +
    "  }" +
    "}"

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
      GraphQLField("search", arguments: ["first": 100, "query": Variable("search"), "type": "REPOSITORY", "before": Variable("before")], type: .nonNull(.object(Search.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search])
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
        GraphQLField("nodes", type: .list(.object(Node.self))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.self))),
        GraphQLField("repositoryCount", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(nodes: [Node?]? = nil, pageInfo: PageInfo, repositoryCount: Int) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "nodes": nodes, "pageInfo": pageInfo, "repositoryCount": repositoryCount])
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
          return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
        public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(AsRepository.self),
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

        public static func makeRepository(id: GraphQLID, name: String, hasIssuesEnabled: Bool, owner: AsRepository.Owner, description: String? = nil, pushedAt: String? = nil, primaryLanguage: AsRepository.PrimaryLanguage? = nil, stargazers: AsRepository.Stargazer) -> Node {
          return Node(snapshot: ["__typename": "Repository", "id": id, "name": name, "hasIssuesEnabled": hasIssuesEnabled, "owner": owner, "description": description, "pushedAt": pushedAt, "primaryLanguage": primaryLanguage, "stargazers": stargazers])
        }

        public static func makeUser() -> Node {
          return Node(snapshot: ["__typename": "User"])
        }

        public static func makeOrganization() -> Node {
          return Node(snapshot: ["__typename": "Organization"])
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

        public struct AsRepository: GraphQLFragment {
          public static let possibleTypes = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasIssuesEnabled", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("owner", type: .nonNull(.object(Owner.self))),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("pushedAt", type: .scalar(String.self)),
            GraphQLField("primaryLanguage", type: .object(PrimaryLanguage.self)),
            GraphQLField("stargazers", type: .nonNull(.object(Stargazer.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String, hasIssuesEnabled: Bool, owner: Owner, description: String? = nil, pushedAt: String? = nil, primaryLanguage: PrimaryLanguage? = nil, stargazers: Stargazer) {
            self.init(snapshot: ["__typename": "Repository", "id": id, "name": name, "hasIssuesEnabled": hasIssuesEnabled, "owner": owner, "description": description, "pushedAt": pushedAt, "primaryLanguage": primaryLanguage, "stargazers": stargazers])
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
              return snapshot["description"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "description")
            }
          }

          /// Identifies when the repository was last pushed to.
          public var pushedAt: String? {
            get {
              return snapshot["pushedAt"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "pushedAt")
            }
          }

          /// The primary language of the repository's code.
          public var primaryLanguage: PrimaryLanguage? {
            get {
              return (snapshot["primaryLanguage"]! as! Snapshot?).flatMap { PrimaryLanguage(snapshot: $0) }
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
                return snapshot["color"]! as! String?
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
            return snapshot["endCursor"]! as! String?
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

public struct NodeFields: GraphQLFragment {
  public static let fragmentString =
    "fragment nodeFields on Node {" +
    "  __typename" +
    "  id" +
    "}"

  public static let possibleTypes = ["Organization", "Project", "ProjectColumn", "ProjectCard", "Issue", "User", "Repository", "CommitComment", "Reaction", "Commit", "Status", "StatusContext", "Tree", "Ref", "PullRequest", "Label", "IssueComment", "PullRequestCommit", "Milestone", "ReviewRequest", "PullRequestReview", "PullRequestReviewComment", "CommitCommentThread", "PullRequestReviewThread", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "MergedEvent", "ReferencedEvent", "CrossReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent", "DeployedEvent", "Deployment", "DeploymentStatus", "HeadRefDeletedEvent", "HeadRefRestoredEvent", "HeadRefForcePushedEvent", "BaseRefForcePushedEvent", "ReviewRequestedEvent", "ReviewRequestRemovedEvent", "ReviewDismissedEvent", "Language", "ProtectedBranch", "PushAllowance", "Team", "OrganizationInvitation", "ReviewDismissalAllowance", "Release", "ReleaseAsset", "RepositoryTopic", "Topic", "Gist", "GistComment", "OrganizationIdentityProvider", "ExternalIdentity", "Blob", "Bot", "BaseRefChangedEvent", "AddedToProjectEvent", "CommentDeletedEvent", "ConvertedNoteToIssueEvent", "MentionedEvent", "MovedColumnsInProjectEvent", "RemovedFromProjectEvent", "RepositoryInvitation", "Tag"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
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

  public static func makeLanguage(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Language", "id": id])
  }

  public static func makeProtectedBranch(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ProtectedBranch", "id": id])
  }

  public static func makePushAllowance(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "PushAllowance", "id": id])
  }

  public static func makeTeam(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Team", "id": id])
  }

  public static func makeOrganizationInvitation(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "OrganizationInvitation", "id": id])
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

  public static func makeOrganizationIdentityProvider(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "OrganizationIdentityProvider", "id": id])
  }

  public static func makeExternalIdentity(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "ExternalIdentity", "id": id])
  }

  public static func makeBlob(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Blob", "id": id])
  }

  public static func makeBot(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "Bot", "id": id])
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

  public static func makeRepositoryInvitation(id: GraphQLID) -> NodeFields {
    return NodeFields(snapshot: ["__typename": "RepositoryInvitation", "id": id])
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

public struct ReactionFields: GraphQLFragment {
  public static let fragmentString =
    "fragment reactionFields on Reactable {" +
    "  __typename" +
    "  viewerCanReact" +
    "  reactionGroups {" +
    "    __typename" +
    "    viewerHasReacted" +
    "    users(first: 3) {" +
    "      __typename" +
    "      nodes {" +
    "        __typename" +
    "        login" +
    "      }" +
    "      totalCount" +
    "    }" +
    "    content" +
    "  }" +
    "}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerCanReact", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("reactionGroups", type: .list(.nonNull(.object(ReactionGroup.self)))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "Issue", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
  }

  public static func makeCommitComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "CommitComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
  }

  public static func makePullRequest(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "PullRequest", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
  }

  public static func makeIssueComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "IssueComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
  }

  public static func makePullRequestReviewComment(viewerCanReact: Bool, reactionGroups: [ReactionGroup]? = nil) -> ReactionFields {
    return ReactionFields(snapshot: ["__typename": "PullRequestReviewComment", "viewerCanReact": viewerCanReact, "reactionGroups": reactionGroups])
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
      return (snapshot["reactionGroups"]! as! [Snapshot]?).flatMap { $0.map { ReactionGroup(snapshot: $0) } }
    }
    set {
      snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "reactionGroups")
    }
  }

  public struct ReactionGroup: GraphQLSelectionSet {
    public static let possibleTypes = ["ReactionGroup"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("viewerHasReacted", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("users", arguments: ["first": 3], type: .nonNull(.object(User.self))),
      GraphQLField("content", type: .nonNull(.scalar(ReactionContent.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewerHasReacted: Bool, users: User, content: ReactionContent) {
      self.init(snapshot: ["__typename": "ReactionGroup", "viewerHasReacted": viewerHasReacted, "users": users, "content": content])
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
        GraphQLField("nodes", type: .list(.object(Node.self))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(nodes: [Node?]? = nil, totalCount: Int) {
        self.init(snapshot: ["__typename": "ReactingUserConnection", "nodes": nodes, "totalCount": totalCount])
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
          return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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
    "fragment commentFields on Comment {" +
    "  __typename" +
    "  author {" +
    "    __typename" +
    "    login" +
    "    avatarUrl" +
    "  }" +
    "  editor {" +
    "    __typename" +
    "    login" +
    "  }" +
    "  lastEditedAt" +
    "  body" +
    "  createdAt" +
    "  viewerDidAuthor" +
    "}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("author", type: .object(Author.self)),
    GraphQLField("editor", type: .object(Editor.self)),
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
    return CommentFields(snapshot: ["__typename": "Issue", "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeCommitComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "CommitComment", "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequest(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "PullRequest", "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeIssueComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "IssueComment", "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReview(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "PullRequestReview", "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReviewComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "PullRequestReviewComment", "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeGistComment(author: Author? = nil, editor: Editor? = nil, lastEditedAt: String? = nil, body: String, createdAt: String, viewerDidAuthor: Bool) -> CommentFields {
    return CommentFields(snapshot: ["__typename": "GistComment", "author": author, "editor": editor, "lastEditedAt": lastEditedAt, "body": body, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
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
      return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "author")
    }
  }

  /// The actor who edited the comment.
  public var editor: Editor? {
    get {
      return (snapshot["editor"]! as! Snapshot?).flatMap { Editor(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "editor")
    }
  }

  /// The moment the editor made the last edit
  public var lastEditedAt: String? {
    get {
      return snapshot["lastEditedAt"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "lastEditedAt")
    }
  }

  /// The comment body as Markdown.
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

public struct UpdatableFields: GraphQLFragment {
  public static let fragmentString =
    "fragment updatableFields on Updatable {" +
    "  __typename" +
    "  viewerCanUpdate" +
    "}"

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

public struct HeadPaging: GraphQLFragment {
  public static let fragmentString =
    "fragment headPaging on PageInfo {" +
    "  __typename" +
    "  hasPreviousPage" +
    "  startCursor" +
    "}"

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
      return snapshot["startCursor"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "startCursor")
    }
  }
}

public struct ReferencedRepositoryFields: GraphQLFragment {
  public static let fragmentString =
    "fragment referencedRepositoryFields on RepositoryInfo {" +
    "  __typename" +
    "  name" +
    "  owner {" +
    "    __typename" +
    "    login" +
    "  }" +
    "}"

  public static let possibleTypes = ["Repository", "RepositoryInvitationRepository"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.object(Owner.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeRepository(name: String, owner: Owner) -> ReferencedRepositoryFields {
    return ReferencedRepositoryFields(snapshot: ["__typename": "Repository", "name": name, "owner": owner])
  }

  public static func makeRepositoryInvitationRepository(name: String, owner: Owner) -> ReferencedRepositoryFields {
    return ReferencedRepositoryFields(snapshot: ["__typename": "RepositoryInvitationRepository", "name": name, "owner": owner])
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

public struct MilestoneFields: GraphQLFragment {
  public static let fragmentString =
    "fragment milestoneFields on Milestone {" +
    "  __typename" +
    "  number" +
    "  title" +
    "  url" +
    "}"

  public static let possibleTypes = ["Milestone"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("number", type: .nonNull(.scalar(Int.self))),
    GraphQLField("title", type: .nonNull(.scalar(String.self))),
    GraphQLField("url", type: .nonNull(.scalar(String.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(number: Int, title: String, url: String) {
    self.init(snapshot: ["__typename": "Milestone", "number": number, "title": title, "url": url])
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
}

public struct LockableFields: GraphQLFragment {
  public static let fragmentString =
    "fragment lockableFields on Lockable {" +
    "  __typename" +
    "  locked" +
    "}"

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
    "fragment closableFields on Closable {" +
    "  __typename" +
    "  closed" +
    "}"

  public static let possibleTypes = ["Project", "Issue", "PullRequest"]

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
    "fragment labelableFields on Labelable {" +
    "  __typename" +
    "  labels(first: 100) {" +
    "    __typename" +
    "    nodes {" +
    "      __typename" +
    "      color" +
    "      name" +
    "    }" +
    "  }" +
    "}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("labels", arguments: ["first": 100], type: .object(Label.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(labels: Label? = nil) -> LabelableFields {
    return LabelableFields(snapshot: ["__typename": "Issue", "labels": labels])
  }

  public static func makePullRequest(labels: Label? = nil) -> LabelableFields {
    return LabelableFields(snapshot: ["__typename": "PullRequest", "labels": labels])
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
      return (snapshot["labels"]! as! Snapshot?).flatMap { Label(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "labels")
    }
  }

  public struct Label: GraphQLSelectionSet {
    public static let possibleTypes = ["LabelConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("nodes", type: .list(.object(Node.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(nodes: [Node?]? = nil) {
      self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes])
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
        return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

public struct AssigneeFields: GraphQLFragment {
  public static let fragmentString =
    "fragment assigneeFields on Assignable {" +
    "  __typename" +
    "  assignees(first: $page_size) {" +
    "    __typename" +
    "    nodes {" +
    "      __typename" +
    "      login" +
    "      avatarUrl" +
    "    }" +
    "  }" +
    "}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("assignees", arguments: ["first": Variable("page_size")], type: .nonNull(.object(Assignee.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(assignees: Assignee) -> AssigneeFields {
    return AssigneeFields(snapshot: ["__typename": "Issue", "assignees": assignees])
  }

  public static func makePullRequest(assignees: Assignee) -> AssigneeFields {
    return AssigneeFields(snapshot: ["__typename": "PullRequest", "assignees": assignees])
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
      GraphQLField("nodes", type: .list(.object(Node.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(nodes: [Node?]? = nil) {
      self.init(snapshot: ["__typename": "UserConnection", "nodes": nodes])
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
        return (snapshot["nodes"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
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

public struct RepoEventFields: GraphQLFragment {
  public static let fragmentString =
    "fragment repoEventFields on Comment {" +
    "  __typename" +
    "  createdAt" +
    "  author {" +
    "    __typename" +
    "    login" +
    "  }" +
    "}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("author", type: .object(Author.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public static func makeIssue(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "Issue", "createdAt": createdAt, "author": author])
  }

  public static func makeCommitComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "CommitComment", "createdAt": createdAt, "author": author])
  }

  public static func makePullRequest(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "PullRequest", "createdAt": createdAt, "author": author])
  }

  public static func makeIssueComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "IssueComment", "createdAt": createdAt, "author": author])
  }

  public static func makePullRequestReview(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "PullRequestReview", "createdAt": createdAt, "author": author])
  }

  public static func makePullRequestReviewComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "PullRequestReviewComment", "createdAt": createdAt, "author": author])
  }

  public static func makeGistComment(createdAt: String, author: Author? = nil) -> RepoEventFields {
    return RepoEventFields(snapshot: ["__typename": "GistComment", "createdAt": createdAt, "author": author])
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
      return (snapshot["author"]! as! Snapshot?).flatMap { Author(snapshot: $0) }
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