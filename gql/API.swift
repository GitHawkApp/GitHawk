//  This file was automatically generated and should not be edited.

import Apollo

/// Emojis that can be attached to Issues, Pull Requests and Comments.
public enum ReactionContent: String {
  case thumbsUp = "THUMBS_UP" /// Represents the 👍 emoji.
  case thumbsDown = "THUMBS_DOWN" /// Represents the 👎 emoji.
  case laugh = "LAUGH" /// Represents the 😄 emoji.
  case hooray = "HOORAY" /// Represents the 🎉 emoji.
  case confused = "CONFUSED" /// Represents the 😕 emoji.
  case heart = "HEART" /// Represents the ❤️ emoji.
}

extension ReactionContent: JSONDecodable, JSONEncodable {}

public final class IssueQuery: GraphQLQuery {
  public static let operationDefinition =
    "query Issue($owner: String!, $name: String!, $number: Int!) {" +
    "  repository(owner: $owner, name: $name) {" +
    "    __typename" +
    "    issue(number: $number) {" +
    "      __typename" +
    "      labels(first: 100) {" +
    "        __typename" +
    "        nodes {" +
    "          __typename" +
    "          color" +
    "          name" +
    "        }" +
    "      }" +
    "      timeline(first: 100) {" +
    "        __typename" +
    "        nodes {" +
    "          __typename" +
    "          ... on Commit {" +
    "            __typename" +
    "            author {" +
    "              __typename" +
    "              name" +
    "              date" +
    "            }" +
    "            messageHeadline" +
    "          }" +
    "          ... on IssueComment {" +
    "            __typename" +
    "            ...reactionFields" +
    "            ...commentFields" +
    "          }" +
    "          ... on LabeledEvent {" +
    "            __typename" +
    "            actor {" +
    "              __typename" +
    "              login" +
    "            }" +
    "            label {" +
    "              __typename" +
    "              color" +
    "              name" +
    "            }" +
    "          }" +
    "          ... on UnlabeledEvent {" +
    "            __typename" +
    "            actor {" +
    "              __typename" +
    "              login" +
    "            }" +
    "            label {" +
    "              __typename" +
    "              color" +
    "              name" +
    "            }" +
    "          }" +
    "          ... on ClosedEvent {" +
    "            __typename" +
    "            actor {" +
    "              __typename" +
    "              login" +
    "            }" +
    "            createdAt" +
    "          }" +
    "          ... on ReopenedEvent {" +
    "            __typename" +
    "            actor {" +
    "              __typename" +
    "              login" +
    "            }" +
    "            createdAt" +
    "          }" +
    "          ... on RenamedTitleEvent {" +
    "            __typename" +
    "            actor {" +
    "              __typename" +
    "              login" +
    "            }" +
    "            createdAt" +
    "            currentTitle" +
    "          }" +
    "          ... on LockedEvent {" +
    "            __typename" +
    "            actor {" +
    "              __typename" +
    "              login" +
    "            }" +
    "            createdAt" +
    "          }" +
    "        }" +
    "      }" +
    "      ...reactionFields" +
    "      ...commentFields" +
    "      closed" +
    "      locked" +
    "      number" +
    "      title" +
    "      viewerCanReact" +
    "      viewerCanUpdate" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(ReactionFields.fragmentDefinition).appending(CommentFields.fragmentDefinition)

  public let owner: String
  public let name: String
  public let number: Int

  public init(owner: String, name: String, number: Int) {
    self.owner = owner
    self.name = name
    self.number = number
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "number": number]
  }

  public struct Data: GraphQLMappable {
    /// Lookup a given repository by the owner and repository name.
    public let repository: Repository?

    public init(reader: GraphQLResultReader) throws {
      repository = try reader.optionalValue(for: Field(responseName: "repository", arguments: ["owner": reader.variables["owner"], "name": reader.variables["name"]]))
    }

    public struct Repository: GraphQLMappable {
      public let __typename: String
      /// Returns a single issue from the current repository by number.
      public let issue: Issue?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        issue = try reader.optionalValue(for: Field(responseName: "issue", arguments: ["number": reader.variables["number"]]))
      }

      public struct Issue: GraphQLMappable {
        public let __typename: String
        /// A list of labels associated with the object.
        public let labels: Label?
        /// A list of events associated with an Issue.
        public let timeline: Timeline
        /// true if the object is `closed` (definition of closed may depend on type)
        public let closed: Bool
        /// `true` if the object is locked
        public let locked: Bool
        /// Identifies the issue number.
        public let number: Int
        /// Identifies the issue title.
        public let title: String
        /// Can user react to this subject
        public let viewerCanReact: Bool
        /// Check if the current viewer can update this object.
        public let viewerCanUpdate: Bool

        public let fragments: Fragments

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          labels = try reader.optionalValue(for: Field(responseName: "labels", arguments: ["first": 100]))
          timeline = try reader.value(for: Field(responseName: "timeline", arguments: ["first": 100]))
          closed = try reader.value(for: Field(responseName: "closed"))
          locked = try reader.value(for: Field(responseName: "locked"))
          number = try reader.value(for: Field(responseName: "number"))
          title = try reader.value(for: Field(responseName: "title"))
          viewerCanReact = try reader.value(for: Field(responseName: "viewerCanReact"))
          viewerCanUpdate = try reader.value(for: Field(responseName: "viewerCanUpdate"))

          let reactionFields = try ReactionFields(reader: reader)
          let commentFields = try CommentFields(reader: reader)
          fragments = Fragments(reactionFields: reactionFields, commentFields: commentFields)
        }

        public struct Fragments {
          public let reactionFields: ReactionFields
          public let commentFields: CommentFields
        }

        public struct Label: GraphQLMappable {
          public let __typename: String
          /// A list of nodes.
          public let nodes: [Node?]?

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            nodes = try reader.optionalList(for: Field(responseName: "nodes"))
          }

          public struct Node: GraphQLMappable {
            public let __typename: String
            /// Identifies the label color.
            public let color: String
            /// Identifies the label name.
            public let name: String

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              color = try reader.value(for: Field(responseName: "color"))
              name = try reader.value(for: Field(responseName: "name"))
            }
          }
        }

        public struct Timeline: GraphQLMappable {
          public let __typename: String
          /// A list of nodes.
          public let nodes: [Node?]?

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            nodes = try reader.optionalList(for: Field(responseName: "nodes"))
          }

          public struct Node: GraphQLMappable {
            public let __typename: String

            public let asCommit: AsCommit?
            public let asLabeledEvent: AsLabeledEvent?
            public let asUnlabeledEvent: AsUnlabeledEvent?
            public let asClosedEvent: AsClosedEvent?
            public let asReopenedEvent: AsReopenedEvent?
            public let asRenamedTitleEvent: AsRenamedTitleEvent?
            public let asLockedEvent: AsLockedEvent?
            public let asIssueComment: AsIssueComment?

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))

              asCommit = try AsCommit(reader: reader, ifTypeMatches: __typename)
              asLabeledEvent = try AsLabeledEvent(reader: reader, ifTypeMatches: __typename)
              asUnlabeledEvent = try AsUnlabeledEvent(reader: reader, ifTypeMatches: __typename)
              asClosedEvent = try AsClosedEvent(reader: reader, ifTypeMatches: __typename)
              asReopenedEvent = try AsReopenedEvent(reader: reader, ifTypeMatches: __typename)
              asRenamedTitleEvent = try AsRenamedTitleEvent(reader: reader, ifTypeMatches: __typename)
              asLockedEvent = try AsLockedEvent(reader: reader, ifTypeMatches: __typename)
              asIssueComment = try AsIssueComment(reader: reader, ifTypeMatches: __typename)
            }

            public struct AsCommit: GraphQLConditionalFragment {
              public static let possibleTypes = ["Commit"]

              public let __typename: String
              /// Authorship details of the commit.
              public let author: Author?
              /// The Git commit message headline
              public let messageHeadline: String

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                author = try reader.optionalValue(for: Field(responseName: "author"))
                messageHeadline = try reader.value(for: Field(responseName: "messageHeadline"))
              }

              public struct Author: GraphQLMappable {
                public let __typename: String
                /// The name in the Git commit.
                public let name: String?
                /// The timestamp of the Git action (authoring or committing).
                public let date: String?

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  name = try reader.optionalValue(for: Field(responseName: "name"))
                  date = try reader.optionalValue(for: Field(responseName: "date"))
                }
              }
            }

            public struct AsLabeledEvent: GraphQLConditionalFragment {
              public static let possibleTypes = ["LabeledEvent"]

              public let __typename: String
              /// Identifies the actor who performed the 'label' event.
              public let actor: Actor?
              /// Identifies the label associated with the 'labeled' event.
              public let label: Label

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                actor = try reader.optionalValue(for: Field(responseName: "actor"))
                label = try reader.value(for: Field(responseName: "label"))
              }

              public struct Actor: GraphQLMappable {
                public let __typename: String
                /// The username of the actor.
                public let login: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  login = try reader.value(for: Field(responseName: "login"))
                }
              }

              public struct Label: GraphQLMappable {
                public let __typename: String
                /// Identifies the label color.
                public let color: String
                /// Identifies the label name.
                public let name: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  color = try reader.value(for: Field(responseName: "color"))
                  name = try reader.value(for: Field(responseName: "name"))
                }
              }
            }

            public struct AsUnlabeledEvent: GraphQLConditionalFragment {
              public static let possibleTypes = ["UnlabeledEvent"]

              public let __typename: String
              /// Identifies the actor who performed the 'unlabel' event.
              public let actor: Actor?
              /// Identifies the label associated with the 'unlabeled' event.
              public let label: Label

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                actor = try reader.optionalValue(for: Field(responseName: "actor"))
                label = try reader.value(for: Field(responseName: "label"))
              }

              public struct Actor: GraphQLMappable {
                public let __typename: String
                /// The username of the actor.
                public let login: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  login = try reader.value(for: Field(responseName: "login"))
                }
              }

              public struct Label: GraphQLMappable {
                public let __typename: String
                /// Identifies the label color.
                public let color: String
                /// Identifies the label name.
                public let name: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  color = try reader.value(for: Field(responseName: "color"))
                  name = try reader.value(for: Field(responseName: "name"))
                }
              }
            }

            public struct AsClosedEvent: GraphQLConditionalFragment {
              public static let possibleTypes = ["ClosedEvent"]

              public let __typename: String
              /// Identifies the actor who closed the item.
              public let actor: Actor?
              /// Identifies the date and time when the object was created.
              public let createdAt: String

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                actor = try reader.optionalValue(for: Field(responseName: "actor"))
                createdAt = try reader.value(for: Field(responseName: "createdAt"))
              }

              public struct Actor: GraphQLMappable {
                public let __typename: String
                /// The username of the actor.
                public let login: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  login = try reader.value(for: Field(responseName: "login"))
                }
              }
            }

            public struct AsReopenedEvent: GraphQLConditionalFragment {
              public static let possibleTypes = ["ReopenedEvent"]

              public let __typename: String
              /// Identifies the actor who reopened the item.
              public let actor: Actor?
              /// Identifies the date and time when the object was created.
              public let createdAt: String

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                actor = try reader.optionalValue(for: Field(responseName: "actor"))
                createdAt = try reader.value(for: Field(responseName: "createdAt"))
              }

              public struct Actor: GraphQLMappable {
                public let __typename: String
                /// The username of the actor.
                public let login: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  login = try reader.value(for: Field(responseName: "login"))
                }
              }
            }

            public struct AsRenamedTitleEvent: GraphQLConditionalFragment {
              public static let possibleTypes = ["RenamedTitleEvent"]

              public let __typename: String
              /// Identifies the actor who performed the 'renamed' event.
              public let actor: Actor?
              /// Identifies the date and time when the object was created.
              public let createdAt: String
              /// Identifies the current title of the issue or pull request.
              public let currentTitle: String

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                actor = try reader.optionalValue(for: Field(responseName: "actor"))
                createdAt = try reader.value(for: Field(responseName: "createdAt"))
                currentTitle = try reader.value(for: Field(responseName: "currentTitle"))
              }

              public struct Actor: GraphQLMappable {
                public let __typename: String
                /// The username of the actor.
                public let login: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  login = try reader.value(for: Field(responseName: "login"))
                }
              }
            }

            public struct AsLockedEvent: GraphQLConditionalFragment {
              public static let possibleTypes = ["LockedEvent"]

              public let __typename: String
              /// Identifies the actor who performed the 'locked' event.
              public let actor: Actor?
              /// Identifies the date and time when the object was created.
              public let createdAt: String

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                actor = try reader.optionalValue(for: Field(responseName: "actor"))
                createdAt = try reader.value(for: Field(responseName: "createdAt"))
              }

              public struct Actor: GraphQLMappable {
                public let __typename: String
                /// The username of the actor.
                public let login: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  login = try reader.value(for: Field(responseName: "login"))
                }
              }
            }

            public struct AsIssueComment: GraphQLConditionalFragment {
              public static let possibleTypes = ["IssueComment"]

              public let __typename: String

              public let fragments: Fragments

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))

                let reactionFields = try ReactionFields(reader: reader)
                let commentFields = try CommentFields(reader: reader)
                fragments = Fragments(reactionFields: reactionFields, commentFields: commentFields)
              }

              public struct Fragments {
                public let reactionFields: ReactionFields
                public let commentFields: CommentFields
              }
            }
          }
        }
      }
    }
  }
}

public struct ReactionFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment reactionFields on Reactable {" +
    "  __typename" +
    "  reactionGroups {" +
    "    __typename" +
    "    viewerHasReacted" +
    "    users {" +
    "      __typename" +
    "      totalCount" +
    "    }" +
    "    content" +
    "  }" +
    "}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReviewComment"]

  public let __typename: String
  /// A list of reactions grouped by content left on the subject.
  public let reactionGroups: [ReactionGroup]?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    reactionGroups = try reader.optionalList(for: Field(responseName: "reactionGroups"))
  }

  public struct ReactionGroup: GraphQLMappable {
    public let __typename: String
    /// Whether or not the authenticated user has left a reaction on the subject.
    public let viewerHasReacted: Bool
    /// Users who have reacted to the reaction subject with the emotion represented by this reaction group
    public let users: User
    /// Identifies the emoji reaction.
    public let content: ReactionContent

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      viewerHasReacted = try reader.value(for: Field(responseName: "viewerHasReacted"))
      users = try reader.value(for: Field(responseName: "users"))
      content = try reader.value(for: Field(responseName: "content"))
    }

    public struct User: GraphQLMappable {
      public let __typename: String
      /// Identifies the total count of items in the connection.
      public let totalCount: Int

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        totalCount = try reader.value(for: Field(responseName: "totalCount"))
      }
    }
  }
}

public struct CommentFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
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
    "  body" +
    "  createdAt" +
    "  viewerDidAuthor" +
    "}"

  public static let possibleTypes = ["Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public let __typename: String
  /// The actor who authored the comment.
  public let author: Author?
  /// The actor who edited the comment.
  public let editor: Editor?
  /// The comment body as Markdown.
  public let body: String
  /// Identifies the date and time when the object was created.
  public let createdAt: String
  /// Did the viewer author this comment.
  public let viewerDidAuthor: Bool

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    author = try reader.optionalValue(for: Field(responseName: "author"))
    editor = try reader.optionalValue(for: Field(responseName: "editor"))
    body = try reader.value(for: Field(responseName: "body"))
    createdAt = try reader.value(for: Field(responseName: "createdAt"))
    viewerDidAuthor = try reader.value(for: Field(responseName: "viewerDidAuthor"))
  }

  public struct Author: GraphQLMappable {
    public let __typename: String
    /// The username of the actor.
    public let login: String
    /// A URL pointing to the actor's public avatar.
    public let avatarUrl: String

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      login = try reader.value(for: Field(responseName: "login"))
      avatarUrl = try reader.value(for: Field(responseName: "avatarUrl"))
    }
  }

  public struct Editor: GraphQLMappable {
    public let __typename: String
    /// The username of the actor.
    public let login: String

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      login = try reader.value(for: Field(responseName: "login"))
    }
  }
}
