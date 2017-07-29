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

/// The possible states of a pull request review.
public enum PullRequestReviewState: String {
  case pending = "PENDING" /// A review that has not yet been submitted.
  case commented = "COMMENTED" /// An informational review.
  case approved = "APPROVED" /// A review allowing the pull request to merge.
  case changesRequested = "CHANGES_REQUESTED" /// A review blocking the pull request from merging.
  case dismissed = "DISMISSED" /// A review that has been dismissed.
}

extension PullRequestReviewState: JSONDecodable, JSONEncodable {}

/// The possible states of an issue.
public enum IssueState: String {
  case `open` = "OPEN" /// An issue that is still open
  case closed = "CLOSED" /// An issue that has been closed
}

extension IssueState: JSONDecodable, JSONEncodable {}

/// The possible states of a pull request.
public enum PullRequestState: String {
  case `open` = "OPEN" /// A pull request that is still open.
  case closed = "CLOSED" /// A pull request that has been closed without being merged.
  case merged = "MERGED" /// A pull request that has been closed by being merged.
}

extension PullRequestState: JSONDecodable, JSONEncodable {}

public final class AddCommentMutation: GraphQLMutation {
  public static let operationDefinition =
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
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(NodeFields.fragmentDefinition).appending(ReactionFields.fragmentDefinition).appending(CommentFields.fragmentDefinition)

  public let subjectId: GraphQLID
  public let body: String

  public init(subjectId: GraphQLID, body: String) {
    self.subjectId = subjectId
    self.body = body
  }

  public var variables: GraphQLMap? {
    return ["subject_id": subjectId, "body": body]
  }

  public struct Data: GraphQLMappable {
    /// Adds a comment to an Issue or Pull Request.
    public let addComment: AddComment?

    public init(reader: GraphQLResultReader) throws {
      addComment = try reader.optionalValue(for: Field(responseName: "addComment", arguments: ["input": ["subjectId": reader.variables["subject_id"], "body": reader.variables["body"]]]))
    }

    public struct AddComment: GraphQLMappable {
      public let __typename: String
      /// The edge from the subject's comment connection.
      public let commentEdge: CommentEdge

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        commentEdge = try reader.value(for: Field(responseName: "commentEdge"))
      }

      public struct CommentEdge: GraphQLMappable {
        public let __typename: String
        /// The item at the end of the edge.
        public let node: Node?

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          node = try reader.optionalValue(for: Field(responseName: "node"))
        }

        public struct Node: GraphQLMappable {
          public let __typename: String

          public let fragments: Fragments

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))

            let nodeFields = try NodeFields(reader: reader)
            let reactionFields = try ReactionFields(reader: reader)
            let commentFields = try CommentFields(reader: reader)
            fragments = Fragments(nodeFields: nodeFields, reactionFields: reactionFields, commentFields: commentFields)
          }

          public struct Fragments {
            public let nodeFields: NodeFields
            public let reactionFields: ReactionFields
            public let commentFields: CommentFields
          }
        }
      }
    }
  }
}

public final class AddReactionMutation: GraphQLMutation {
  public static let operationDefinition =
    "mutation AddReaction($subject_id: ID!, $content: ReactionContent!) {" +
    "  addReaction(input: {subjectId: $subject_id, content: $content}) {" +
    "    __typename" +
    "    subject {" +
    "      __typename" +
    "      ...reactionFields" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(ReactionFields.fragmentDefinition)

  public let subjectId: GraphQLID
  public let content: ReactionContent

  public init(subjectId: GraphQLID, content: ReactionContent) {
    self.subjectId = subjectId
    self.content = content
  }

  public var variables: GraphQLMap? {
    return ["subject_id": subjectId, "content": content]
  }

  public struct Data: GraphQLMappable {
    /// Adds a reaction to a subject.
    public let addReaction: AddReaction?

    public init(reader: GraphQLResultReader) throws {
      addReaction = try reader.optionalValue(for: Field(responseName: "addReaction", arguments: ["input": ["subjectId": reader.variables["subject_id"], "content": reader.variables["content"]]]))
    }

    public struct AddReaction: GraphQLMappable {
      public let __typename: String
      /// The reactable subject.
      public let subject: Subject

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        subject = try reader.value(for: Field(responseName: "subject"))
      }

      public struct Subject: GraphQLMappable {
        public let __typename: String

        public let fragments: Fragments

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))

          let reactionFields = try ReactionFields(reader: reader)
          fragments = Fragments(reactionFields: reactionFields)
        }

        public struct Fragments {
          public let reactionFields: ReactionFields
        }
      }
    }
  }
}

public final class IssueOrPullRequestQuery: GraphQLQuery {
  public static let operationDefinition =
    "query IssueOrPullRequest($owner: String!, $repo: String!, $number: Int!, $page_size: Int!, $before: String) {" +
    "  repository(owner: $owner, name: $repo) {" +
    "    __typename" +
    "    name" +
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
  public static let queryDocument = operationDefinition.appending(HeadPaging.fragmentDefinition).appending(NodeFields.fragmentDefinition).appending(ReactionFields.fragmentDefinition).appending(CommentFields.fragmentDefinition).appending(ReferencedRepositoryFields.fragmentDefinition).appending(LockableFields.fragmentDefinition).appending(ClosableFields.fragmentDefinition).appending(LabelableFields.fragmentDefinition).appending(UpdatableFields.fragmentDefinition).appending(AssigneeFields.fragmentDefinition)

  public let owner: String
  public let repo: String
  public let number: Int
  public let pageSize: Int
  public let before: String?

  public init(owner: String, repo: String, number: Int, pageSize: Int, before: String? = nil) {
    self.owner = owner
    self.repo = repo
    self.number = number
    self.pageSize = pageSize
    self.before = before
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "repo": repo, "number": number, "page_size": pageSize, "before": before]
  }

  public struct Data: GraphQLMappable {
    /// Lookup a given repository by the owner and repository name.
    public let repository: Repository?

    public init(reader: GraphQLResultReader) throws {
      repository = try reader.optionalValue(for: Field(responseName: "repository", arguments: ["owner": reader.variables["owner"], "name": reader.variables["repo"]]))
    }

    public struct Repository: GraphQLMappable {
      public let __typename: String
      /// The name of the repository.
      public let name: String
      /// A list of Users that can be mentioned in the context of the repository.
      public let mentionableUsers: MentionableUser
      /// Returns a single issue-like object from the current repository by number.
      public let issueOrPullRequest: IssueOrPullRequest?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        name = try reader.value(for: Field(responseName: "name"))
        mentionableUsers = try reader.value(for: Field(responseName: "mentionableUsers", arguments: ["first": 100]))
        issueOrPullRequest = try reader.optionalValue(for: Field(responseName: "issueOrPullRequest", arguments: ["number": reader.variables["number"]]))
      }

      public struct MentionableUser: GraphQLMappable {
        public let __typename: String
        /// A list of nodes.
        public let nodes: [Node?]?

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          nodes = try reader.optionalList(for: Field(responseName: "nodes"))
        }

        public struct Node: GraphQLMappable {
          public let __typename: String
          /// A URL pointing to the user's public avatar.
          public let avatarUrl: String
          /// The username used to login.
          public let login: String

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            avatarUrl = try reader.value(for: Field(responseName: "avatarUrl"))
            login = try reader.value(for: Field(responseName: "login"))
          }
        }
      }

      public struct IssueOrPullRequest: GraphQLMappable {
        public let __typename: String

        public let asIssue: AsIssue?
        public let asPullRequest: AsPullRequest?

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))

          asIssue = try AsIssue(reader: reader, ifTypeMatches: __typename)
          asPullRequest = try AsPullRequest(reader: reader, ifTypeMatches: __typename)
        }

        public struct AsIssue: GraphQLConditionalFragment {
          public static let possibleTypes = ["Issue"]

          public let __typename: String
          /// A list of events associated with an Issue.
          public let timeline: Timeline
          /// Identifies the issue number.
          public let number: Int
          /// Identifies the issue title.
          public let title: String

          public let fragments: Fragments

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            timeline = try reader.value(for: Field(responseName: "timeline", arguments: ["last": reader.variables["page_size"], "before": reader.variables["before"]]))
            number = try reader.value(for: Field(responseName: "number"))
            title = try reader.value(for: Field(responseName: "title"))

            let reactionFields = try ReactionFields(reader: reader)
            let commentFields = try CommentFields(reader: reader)
            let lockableFields = try LockableFields(reader: reader)
            let closableFields = try ClosableFields(reader: reader)
            let labelableFields = try LabelableFields(reader: reader)
            let updatableFields = try UpdatableFields(reader: reader)
            let nodeFields = try NodeFields(reader: reader)
            let assigneeFields = try AssigneeFields(reader: reader)
            fragments = Fragments(reactionFields: reactionFields, commentFields: commentFields, lockableFields: lockableFields, closableFields: closableFields, labelableFields: labelableFields, updatableFields: updatableFields, nodeFields: nodeFields, assigneeFields: assigneeFields)
          }

          public struct Fragments {
            public let reactionFields: ReactionFields
            public let commentFields: CommentFields
            public let lockableFields: LockableFields
            public let closableFields: ClosableFields
            public let labelableFields: LabelableFields
            public let updatableFields: UpdatableFields
            public let nodeFields: NodeFields
            public let assigneeFields: AssigneeFields
          }

          public struct Timeline: GraphQLMappable {
            public let __typename: String
            /// Information to aid in pagination.
            public let pageInfo: PageInfo
            /// A list of nodes.
            public let nodes: [Node?]?

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              pageInfo = try reader.value(for: Field(responseName: "pageInfo"))
              nodes = try reader.optionalList(for: Field(responseName: "nodes"))
            }

            public struct PageInfo: GraphQLMappable {
              public let __typename: String

              public let fragments: Fragments

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))

                let headPaging = try HeadPaging(reader: reader)
                fragments = Fragments(headPaging: headPaging)
              }

              public struct Fragments {
                public let headPaging: HeadPaging
              }
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
              public let asUnlockedEvent: AsUnlockedEvent?
              public let asReferencedEvent: AsReferencedEvent?
              public let asAssignedEvent: AsAssignedEvent?
              public let asUnassignedEvent: AsUnassignedEvent?
              public let asMilestonedEvent: AsMilestonedEvent?
              public let asDemilestonedEvent: AsDemilestonedEvent?
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
                asUnlockedEvent = try AsUnlockedEvent(reader: reader, ifTypeMatches: __typename)
                asReferencedEvent = try AsReferencedEvent(reader: reader, ifTypeMatches: __typename)
                asAssignedEvent = try AsAssignedEvent(reader: reader, ifTypeMatches: __typename)
                asUnassignedEvent = try AsUnassignedEvent(reader: reader, ifTypeMatches: __typename)
                asMilestonedEvent = try AsMilestonedEvent(reader: reader, ifTypeMatches: __typename)
                asDemilestonedEvent = try AsDemilestonedEvent(reader: reader, ifTypeMatches: __typename)
                asIssueComment = try AsIssueComment(reader: reader, ifTypeMatches: __typename)
              }

              public struct AsCommit: GraphQLConditionalFragment {
                public static let possibleTypes = ["Commit"]

                public let __typename: String
                /// Authorship details of the commit.
                public let author: Author?
                /// The Git object ID
                public let oid: String
                /// The Git commit message headline
                public let messageHeadline: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  author = try reader.optionalValue(for: Field(responseName: "author"))
                  oid = try reader.value(for: Field(responseName: "oid"))
                  messageHeadline = try reader.value(for: Field(responseName: "messageHeadline"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
                }

                public struct Author: GraphQLMappable {
                  public let __typename: String
                  /// The GitHub user corresponding to the email field. Null if no such user exists.
                  public let user: User?

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    user = try reader.optionalValue(for: Field(responseName: "user"))
                  }

                  public struct User: GraphQLMappable {
                    public let __typename: String
                    /// The username used to login.
                    public let login: String
                    /// A URL pointing to the user's public avatar.
                    public let avatarUrl: String

                    public init(reader: GraphQLResultReader) throws {
                      __typename = try reader.value(for: Field(responseName: "__typename"))
                      login = try reader.value(for: Field(responseName: "login"))
                      avatarUrl = try reader.value(for: Field(responseName: "avatarUrl"))
                    }
                  }
                }
              }

              public struct AsLabeledEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["LabeledEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the label associated with the 'labeled' event.
                public let label: Label
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  label = try reader.value(for: Field(responseName: "label"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the label associated with the 'unlabeled' event.
                public let label: Label
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  label = try reader.value(for: Field(responseName: "label"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the commit associated with the 'closed' event.
                public let closedCommit: ClosedCommit?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  closedCommit = try reader.optionalValue(for: Field(responseName: "closedCommit", fieldName: "commit"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct ClosedCommit: GraphQLMappable {
                  public let __typename: String
                  /// The Git object ID
                  public let oid: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    oid = try reader.value(for: Field(responseName: "oid"))
                  }
                }
              }

              public struct AsReopenedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["ReopenedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the current title of the issue or pull request.
                public let currentTitle: String
                /// Identifies the previous title of the issue or pull request.
                public let previousTitle: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  currentTitle = try reader.value(for: Field(responseName: "currentTitle"))
                  previousTitle = try reader.value(for: Field(responseName: "previousTitle"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

              public struct AsUnlockedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["UnlockedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

              public struct AsReferencedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["ReferencedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the commit associated with the 'referenced' event.
                public let refCommit: RefCommit?
                /// Identifies the repository associated with the 'referenced' event.
                public let commitRepository: CommitRepository
                /// Object referenced by event.
                public let subject: Subject

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  refCommit = try reader.optionalValue(for: Field(responseName: "refCommit", fieldName: "commit"))
                  commitRepository = try reader.value(for: Field(responseName: "commitRepository"))
                  subject = try reader.value(for: Field(responseName: "subject"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct RefCommit: GraphQLMappable {
                  public let __typename: String
                  /// The Git object ID
                  public let oid: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    oid = try reader.value(for: Field(responseName: "oid"))
                  }
                }

                public struct CommitRepository: GraphQLMappable {
                  public let __typename: String

                  public let fragments: Fragments

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))

                    let referencedRepositoryFields = try ReferencedRepositoryFields(reader: reader)
                    fragments = Fragments(referencedRepositoryFields: referencedRepositoryFields)
                  }

                  public struct Fragments {
                    public let referencedRepositoryFields: ReferencedRepositoryFields
                  }
                }

                public struct Subject: GraphQLMappable {
                  public let __typename: String

                  public let asIssue: AsIssue?
                  public let asPullRequest: AsPullRequest?

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))

                    asIssue = try AsIssue(reader: reader, ifTypeMatches: __typename)
                    asPullRequest = try AsPullRequest(reader: reader, ifTypeMatches: __typename)
                  }

                  public struct AsIssue: GraphQLConditionalFragment {
                    public static let possibleTypes = ["Issue"]

                    public let __typename: String
                    /// Identifies the issue title.
                    public let title: String
                    /// Identifies the issue number.
                    public let number: Int
                    /// `true` if the object is closed (definition of closed may depend on type)
                    public let closed: Bool

                    public init(reader: GraphQLResultReader) throws {
                      __typename = try reader.value(for: Field(responseName: "__typename"))
                      title = try reader.value(for: Field(responseName: "title"))
                      number = try reader.value(for: Field(responseName: "number"))
                      closed = try reader.value(for: Field(responseName: "closed"))
                    }
                  }

                  public struct AsPullRequest: GraphQLConditionalFragment {
                    public static let possibleTypes = ["PullRequest"]

                    public let __typename: String
                    /// Identifies the pull request title.
                    public let title: String
                    /// Identifies the pull request number.
                    public let number: Int
                    /// `true` if the pull request is closed
                    public let closed: Bool
                    /// Whether or not the pull request was merged.
                    public let merged: Bool

                    public init(reader: GraphQLResultReader) throws {
                      __typename = try reader.value(for: Field(responseName: "__typename"))
                      title = try reader.value(for: Field(responseName: "title"))
                      number = try reader.value(for: Field(responseName: "number"))
                      closed = try reader.value(for: Field(responseName: "closed"))
                      merged = try reader.value(for: Field(responseName: "merged"))
                    }
                  }
                }
              }

              public struct AsAssignedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["AssignedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the user who was assigned.
                public let user: User?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  user = try reader.optionalValue(for: Field(responseName: "user"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct User: GraphQLMappable {
                  public let __typename: String
                  /// The username used to login.
                  public let login: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    login = try reader.value(for: Field(responseName: "login"))
                  }
                }
              }

              public struct AsUnassignedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["UnassignedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the subject (user) who was unassigned.
                public let user: User?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  user = try reader.optionalValue(for: Field(responseName: "user"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct User: GraphQLMappable {
                  public let __typename: String
                  /// The username used to login.
                  public let login: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    login = try reader.value(for: Field(responseName: "login"))
                  }
                }
              }

              public struct AsMilestonedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["MilestonedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the milestone title associated with the 'milestoned' event.
                public let milestoneTitle: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  milestoneTitle = try reader.value(for: Field(responseName: "milestoneTitle"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

              public struct AsDemilestonedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["DemilestonedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the milestone title associated with the 'demilestoned' event.
                public let milestoneTitle: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  milestoneTitle = try reader.value(for: Field(responseName: "milestoneTitle"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                  let nodeFields = try NodeFields(reader: reader)
                  let reactionFields = try ReactionFields(reader: reader)
                  let commentFields = try CommentFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields, reactionFields: reactionFields, commentFields: commentFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
                  public let reactionFields: ReactionFields
                  public let commentFields: CommentFields
                }
              }
            }
          }
        }

        public struct AsPullRequest: GraphQLConditionalFragment {
          public static let possibleTypes = ["PullRequest"]

          public let __typename: String
          /// A list of events associated with a PullRequest.
          public let timeline: Timeline
          /// Identifies the pull request number.
          public let number: Int
          /// Identifies the pull request title.
          public let title: String
          /// A list of review requests associated with the pull request.
          public let reviewRequests: ReviewRequest?
          /// Whether or not the pull request was merged.
          public let merged: Bool

          public let fragments: Fragments

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            timeline = try reader.value(for: Field(responseName: "timeline", arguments: ["last": reader.variables["page_size"], "before": reader.variables["before"]]))
            number = try reader.value(for: Field(responseName: "number"))
            title = try reader.value(for: Field(responseName: "title"))
            reviewRequests = try reader.optionalValue(for: Field(responseName: "reviewRequests", arguments: ["first": reader.variables["page_size"]]))
            merged = try reader.value(for: Field(responseName: "merged"))

            let reactionFields = try ReactionFields(reader: reader)
            let commentFields = try CommentFields(reader: reader)
            let lockableFields = try LockableFields(reader: reader)
            let closableFields = try ClosableFields(reader: reader)
            let labelableFields = try LabelableFields(reader: reader)
            let updatableFields = try UpdatableFields(reader: reader)
            let nodeFields = try NodeFields(reader: reader)
            let assigneeFields = try AssigneeFields(reader: reader)
            fragments = Fragments(reactionFields: reactionFields, commentFields: commentFields, lockableFields: lockableFields, closableFields: closableFields, labelableFields: labelableFields, updatableFields: updatableFields, nodeFields: nodeFields, assigneeFields: assigneeFields)
          }

          public struct Fragments {
            public let reactionFields: ReactionFields
            public let commentFields: CommentFields
            public let lockableFields: LockableFields
            public let closableFields: ClosableFields
            public let labelableFields: LabelableFields
            public let updatableFields: UpdatableFields
            public let nodeFields: NodeFields
            public let assigneeFields: AssigneeFields
          }

          public struct Timeline: GraphQLMappable {
            public let __typename: String
            /// Information to aid in pagination.
            public let pageInfo: PageInfo
            /// A list of nodes.
            public let nodes: [Node?]?

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              pageInfo = try reader.value(for: Field(responseName: "pageInfo"))
              nodes = try reader.optionalList(for: Field(responseName: "nodes"))
            }

            public struct PageInfo: GraphQLMappable {
              public let __typename: String

              public let fragments: Fragments

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))

                let headPaging = try HeadPaging(reader: reader)
                fragments = Fragments(headPaging: headPaging)
              }

              public struct Fragments {
                public let headPaging: HeadPaging
              }
            }

            public struct Node: GraphQLMappable {
              public let __typename: String

              public let asCommit: AsCommit?
              public let asPullRequestReview: AsPullRequestReview?
              public let asLabeledEvent: AsLabeledEvent?
              public let asUnlabeledEvent: AsUnlabeledEvent?
              public let asClosedEvent: AsClosedEvent?
              public let asReopenedEvent: AsReopenedEvent?
              public let asRenamedTitleEvent: AsRenamedTitleEvent?
              public let asLockedEvent: AsLockedEvent?
              public let asUnlockedEvent: AsUnlockedEvent?
              public let asMergedEvent: AsMergedEvent?
              public let asReferencedEvent: AsReferencedEvent?
              public let asAssignedEvent: AsAssignedEvent?
              public let asUnassignedEvent: AsUnassignedEvent?
              public let asReviewRequestedEvent: AsReviewRequestedEvent?
              public let asReviewRequestRemovedEvent: AsReviewRequestRemovedEvent?
              public let asMilestonedEvent: AsMilestonedEvent?
              public let asDemilestonedEvent: AsDemilestonedEvent?
              public let asPullRequestReviewThread: AsPullRequestReviewThread?
              public let asIssueComment: AsIssueComment?

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))

                asCommit = try AsCommit(reader: reader, ifTypeMatches: __typename)
                asPullRequestReview = try AsPullRequestReview(reader: reader, ifTypeMatches: __typename)
                asLabeledEvent = try AsLabeledEvent(reader: reader, ifTypeMatches: __typename)
                asUnlabeledEvent = try AsUnlabeledEvent(reader: reader, ifTypeMatches: __typename)
                asClosedEvent = try AsClosedEvent(reader: reader, ifTypeMatches: __typename)
                asReopenedEvent = try AsReopenedEvent(reader: reader, ifTypeMatches: __typename)
                asRenamedTitleEvent = try AsRenamedTitleEvent(reader: reader, ifTypeMatches: __typename)
                asLockedEvent = try AsLockedEvent(reader: reader, ifTypeMatches: __typename)
                asUnlockedEvent = try AsUnlockedEvent(reader: reader, ifTypeMatches: __typename)
                asMergedEvent = try AsMergedEvent(reader: reader, ifTypeMatches: __typename)
                asReferencedEvent = try AsReferencedEvent(reader: reader, ifTypeMatches: __typename)
                asAssignedEvent = try AsAssignedEvent(reader: reader, ifTypeMatches: __typename)
                asUnassignedEvent = try AsUnassignedEvent(reader: reader, ifTypeMatches: __typename)
                asReviewRequestedEvent = try AsReviewRequestedEvent(reader: reader, ifTypeMatches: __typename)
                asReviewRequestRemovedEvent = try AsReviewRequestRemovedEvent(reader: reader, ifTypeMatches: __typename)
                asMilestonedEvent = try AsMilestonedEvent(reader: reader, ifTypeMatches: __typename)
                asDemilestonedEvent = try AsDemilestonedEvent(reader: reader, ifTypeMatches: __typename)
                asPullRequestReviewThread = try AsPullRequestReviewThread(reader: reader, ifTypeMatches: __typename)
                asIssueComment = try AsIssueComment(reader: reader, ifTypeMatches: __typename)
              }

              public struct AsCommit: GraphQLConditionalFragment {
                public static let possibleTypes = ["Commit"]

                public let __typename: String
                /// Authorship details of the commit.
                public let author: Author?
                /// The Git object ID
                public let oid: String
                /// The Git commit message headline
                public let messageHeadline: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  author = try reader.optionalValue(for: Field(responseName: "author"))
                  oid = try reader.value(for: Field(responseName: "oid"))
                  messageHeadline = try reader.value(for: Field(responseName: "messageHeadline"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
                }

                public struct Author: GraphQLMappable {
                  public let __typename: String
                  /// The GitHub user corresponding to the email field. Null if no such user exists.
                  public let user: User?

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    user = try reader.optionalValue(for: Field(responseName: "user"))
                  }

                  public struct User: GraphQLMappable {
                    public let __typename: String
                    /// The username used to login.
                    public let login: String
                    /// A URL pointing to the user's public avatar.
                    public let avatarUrl: String

                    public init(reader: GraphQLResultReader) throws {
                      __typename = try reader.value(for: Field(responseName: "__typename"))
                      login = try reader.value(for: Field(responseName: "login"))
                      avatarUrl = try reader.value(for: Field(responseName: "avatarUrl"))
                    }
                  }
                }
              }

              public struct AsPullRequestReview: GraphQLConditionalFragment {
                public static let possibleTypes = ["PullRequestReview"]

                public let __typename: String
                /// The actor who authored the comment.
                public let author: Author?
                /// Identifies the current state of the pull request review.
                public let state: PullRequestReviewState
                /// Identifies when the Pull Request Review was submitted
                public let submittedAt: String?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  author = try reader.optionalValue(for: Field(responseName: "author"))
                  state = try reader.value(for: Field(responseName: "state"))
                  submittedAt = try reader.optionalValue(for: Field(responseName: "submittedAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  let commentFields = try CommentFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields, commentFields: commentFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
                  public let commentFields: CommentFields
                }

                public struct Author: GraphQLMappable {
                  public let __typename: String
                  /// The username of the actor.
                  public let login: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    login = try reader.value(for: Field(responseName: "login"))
                  }
                }
              }

              public struct AsLabeledEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["LabeledEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the label associated with the 'labeled' event.
                public let label: Label
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  label = try reader.value(for: Field(responseName: "label"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the label associated with the 'unlabeled' event.
                public let label: Label
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  label = try reader.value(for: Field(responseName: "label"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the commit associated with the 'closed' event.
                public let closedCommit: ClosedCommit?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  closedCommit = try reader.optionalValue(for: Field(responseName: "closedCommit", fieldName: "commit"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct ClosedCommit: GraphQLMappable {
                  public let __typename: String
                  /// The Git object ID
                  public let oid: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    oid = try reader.value(for: Field(responseName: "oid"))
                  }
                }
              }

              public struct AsReopenedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["ReopenedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the current title of the issue or pull request.
                public let currentTitle: String
                /// Identifies the previous title of the issue or pull request.
                public let previousTitle: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  currentTitle = try reader.value(for: Field(responseName: "currentTitle"))
                  previousTitle = try reader.value(for: Field(responseName: "previousTitle"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

              public struct AsUnlockedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["UnlockedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

              public struct AsMergedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["MergedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the commit associated with the `merge` event.
                public let mergedCommit: MergedCommit?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  mergedCommit = try reader.optionalValue(for: Field(responseName: "mergedCommit", fieldName: "commit"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct MergedCommit: GraphQLMappable {
                  public let __typename: String
                  /// The Git object ID
                  public let oid: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    oid = try reader.value(for: Field(responseName: "oid"))
                  }
                }
              }

              public struct AsReferencedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["ReferencedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the repository associated with the 'referenced' event.
                public let commitRepository: CommitRepository
                /// Object referenced by event.
                public let subject: Subject

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  commitRepository = try reader.value(for: Field(responseName: "commitRepository"))
                  subject = try reader.value(for: Field(responseName: "subject"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct CommitRepository: GraphQLMappable {
                  public let __typename: String

                  public let fragments: Fragments

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))

                    let referencedRepositoryFields = try ReferencedRepositoryFields(reader: reader)
                    fragments = Fragments(referencedRepositoryFields: referencedRepositoryFields)
                  }

                  public struct Fragments {
                    public let referencedRepositoryFields: ReferencedRepositoryFields
                  }
                }

                public struct Subject: GraphQLMappable {
                  public let __typename: String

                  public let asIssue: AsIssue?
                  public let asPullRequest: AsPullRequest?

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))

                    asIssue = try AsIssue(reader: reader, ifTypeMatches: __typename)
                    asPullRequest = try AsPullRequest(reader: reader, ifTypeMatches: __typename)
                  }

                  public struct AsIssue: GraphQLConditionalFragment {
                    public static let possibleTypes = ["Issue"]

                    public let __typename: String
                    /// Identifies the issue title.
                    public let title: String
                    /// Identifies the issue number.
                    public let number: Int
                    /// `true` if the object is closed (definition of closed may depend on type)
                    public let closed: Bool

                    public init(reader: GraphQLResultReader) throws {
                      __typename = try reader.value(for: Field(responseName: "__typename"))
                      title = try reader.value(for: Field(responseName: "title"))
                      number = try reader.value(for: Field(responseName: "number"))
                      closed = try reader.value(for: Field(responseName: "closed"))
                    }
                  }

                  public struct AsPullRequest: GraphQLConditionalFragment {
                    public static let possibleTypes = ["PullRequest"]

                    public let __typename: String
                    /// Identifies the pull request title.
                    public let title: String
                    /// Identifies the pull request number.
                    public let number: Int
                    /// `true` if the pull request is closed
                    public let closed: Bool
                    /// Whether or not the pull request was merged.
                    public let merged: Bool

                    public init(reader: GraphQLResultReader) throws {
                      __typename = try reader.value(for: Field(responseName: "__typename"))
                      title = try reader.value(for: Field(responseName: "title"))
                      number = try reader.value(for: Field(responseName: "number"))
                      closed = try reader.value(for: Field(responseName: "closed"))
                      merged = try reader.value(for: Field(responseName: "merged"))
                    }
                  }
                }
              }

              public struct AsAssignedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["AssignedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the user who was assigned.
                public let user: User?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  user = try reader.optionalValue(for: Field(responseName: "user"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct User: GraphQLMappable {
                  public let __typename: String
                  /// The username used to login.
                  public let login: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    login = try reader.value(for: Field(responseName: "login"))
                  }
                }
              }

              public struct AsUnassignedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["UnassignedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the subject (user) who was unassigned.
                public let user: User?

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  user = try reader.optionalValue(for: Field(responseName: "user"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct User: GraphQLMappable {
                  public let __typename: String
                  /// The username used to login.
                  public let login: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    login = try reader.value(for: Field(responseName: "login"))
                  }
                }
              }

              public struct AsReviewRequestedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["ReviewRequestedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the user whose review was requested.
                public let subject: Subject

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  subject = try reader.value(for: Field(responseName: "subject"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct Subject: GraphQLMappable {
                  public let __typename: String
                  /// The username used to login.
                  public let login: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    login = try reader.value(for: Field(responseName: "login"))
                  }
                }
              }

              public struct AsReviewRequestRemovedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["ReviewRequestRemovedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the user whose review request was removed.
                public let subject: Subject

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  subject = try reader.value(for: Field(responseName: "subject"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

                public struct Subject: GraphQLMappable {
                  public let __typename: String
                  /// The username used to login.
                  public let login: String

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    login = try reader.value(for: Field(responseName: "login"))
                  }
                }
              }

              public struct AsMilestonedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["MilestonedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the milestone title associated with the 'milestoned' event.
                public let milestoneTitle: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  milestoneTitle = try reader.value(for: Field(responseName: "milestoneTitle"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

              public struct AsDemilestonedEvent: GraphQLConditionalFragment {
                public static let possibleTypes = ["DemilestonedEvent"]

                public let __typename: String
                /// Identifies the actor who performed the event.
                public let actor: Actor?
                /// Identifies the date and time when the object was created.
                public let createdAt: String
                /// Identifies the milestone title associated with the 'demilestoned' event.
                public let milestoneTitle: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  actor = try reader.optionalValue(for: Field(responseName: "actor"))
                  createdAt = try reader.value(for: Field(responseName: "createdAt"))
                  milestoneTitle = try reader.value(for: Field(responseName: "milestoneTitle"))

                  let nodeFields = try NodeFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
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

              public struct AsPullRequestReviewThread: GraphQLConditionalFragment {
                public static let possibleTypes = ["PullRequestReviewThread"]

                public let __typename: String
                /// A list of pull request comments associated with the thread.
                public let comments: Comment

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  comments = try reader.value(for: Field(responseName: "comments", arguments: ["first": reader.variables["page_size"]]))
                }

                public struct Comment: GraphQLMappable {
                  public let __typename: String
                  /// A list of nodes.
                  public let nodes: [Node?]?

                  public init(reader: GraphQLResultReader) throws {
                    __typename = try reader.value(for: Field(responseName: "__typename"))
                    nodes = try reader.optionalList(for: Field(responseName: "nodes"))
                  }

                  public struct Node: GraphQLMappable {
                    public let __typename: String
                    /// The path to which the comment applies.
                    public let path: String
                    /// The diff hunk to which the comment applies.
                    public let diffHunk: String

                    public let fragments: Fragments

                    public init(reader: GraphQLResultReader) throws {
                      __typename = try reader.value(for: Field(responseName: "__typename"))
                      path = try reader.value(for: Field(responseName: "path"))
                      diffHunk = try reader.value(for: Field(responseName: "diffHunk"))

                      let reactionFields = try ReactionFields(reader: reader)
                      let nodeFields = try NodeFields(reader: reader)
                      let commentFields = try CommentFields(reader: reader)
                      fragments = Fragments(reactionFields: reactionFields, nodeFields: nodeFields, commentFields: commentFields)
                    }

                    public struct Fragments {
                      public let reactionFields: ReactionFields
                      public let nodeFields: NodeFields
                      public let commentFields: CommentFields
                    }
                  }
                }
              }

              public struct AsIssueComment: GraphQLConditionalFragment {
                public static let possibleTypes = ["IssueComment"]

                public let __typename: String

                public let fragments: Fragments

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))

                  let nodeFields = try NodeFields(reader: reader)
                  let reactionFields = try ReactionFields(reader: reader)
                  let commentFields = try CommentFields(reader: reader)
                  fragments = Fragments(nodeFields: nodeFields, reactionFields: reactionFields, commentFields: commentFields)
                }

                public struct Fragments {
                  public let nodeFields: NodeFields
                  public let reactionFields: ReactionFields
                  public let commentFields: CommentFields
                }
              }
            }
          }

          public struct ReviewRequest: GraphQLMappable {
            public let __typename: String
            /// A list of nodes.
            public let nodes: [Node?]?

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              nodes = try reader.optionalList(for: Field(responseName: "nodes"))
            }

            public struct Node: GraphQLMappable {
              public let __typename: String
              /// Identifies the author associated with this review request.
              public let reviewer: Reviewer?

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                reviewer = try reader.optionalValue(for: Field(responseName: "reviewer"))
              }

              public struct Reviewer: GraphQLMappable {
                public let __typename: String
                /// The username used to login.
                public let login: String
                /// A URL pointing to the user's public avatar.
                public let avatarUrl: String

                public init(reader: GraphQLResultReader) throws {
                  __typename = try reader.value(for: Field(responseName: "__typename"))
                  login = try reader.value(for: Field(responseName: "login"))
                  avatarUrl = try reader.value(for: Field(responseName: "avatarUrl"))
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
  public static let operationDefinition =
    "mutation RemoveReaction($subject_id: ID!, $content: ReactionContent!) {" +
    "  removeReaction(input: {subjectId: $subject_id, content: $content}) {" +
    "    __typename" +
    "    subject {" +
    "      __typename" +
    "      ...reactionFields" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(ReactionFields.fragmentDefinition)

  public let subjectId: GraphQLID
  public let content: ReactionContent

  public init(subjectId: GraphQLID, content: ReactionContent) {
    self.subjectId = subjectId
    self.content = content
  }

  public var variables: GraphQLMap? {
    return ["subject_id": subjectId, "content": content]
  }

  public struct Data: GraphQLMappable {
    /// Removes a reaction from a subject.
    public let removeReaction: RemoveReaction?

    public init(reader: GraphQLResultReader) throws {
      removeReaction = try reader.optionalValue(for: Field(responseName: "removeReaction", arguments: ["input": ["subjectId": reader.variables["subject_id"], "content": reader.variables["content"]]]))
    }

    public struct RemoveReaction: GraphQLMappable {
      public let __typename: String
      /// The reactable subject.
      public let subject: Subject

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        subject = try reader.value(for: Field(responseName: "subject"))
      }

      public struct Subject: GraphQLMappable {
        public let __typename: String

        public let fragments: Fragments

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))

          let reactionFields = try ReactionFields(reader: reader)
          fragments = Fragments(reactionFields: reactionFields)
        }

        public struct Fragments {
          public let reactionFields: ReactionFields
        }
      }
    }
  }
}

public final class RepoIssuesAndPullRequestsQuery: GraphQLQuery {
  public static let operationDefinition =
    "query RepoIssuesAndPullRequests($owner: String!, $name: String!, $before: String, $includeIssues: Boolean!, $includePullRequests: Boolean!) {" +
    "  repository(owner: $owner, name: $name) {" +
    "    __typename" +
    "    issues(first: 25, orderBy: {field: UPDATED_AT, direction: DESC}, states: [OPEN, CLOSED], before: $before) @include(if: $includeIssues) {" +
    "      __typename" +
    "      nodes {" +
    "        __typename" +
    "        id" +
    "        title" +
    "        number" +
    "        createdAt" +
    "        state" +
    "        author {" +
    "          __typename" +
    "          login" +
    "        }" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        hasNextPage" +
    "        endCursor" +
    "      }" +
    "    }" +
    "    pullRequests(first: 25, orderBy: {field: UPDATED_AT, direction: DESC}, states: [OPEN, CLOSED, MERGED]) @include(if: $includePullRequests) {" +
    "      __typename" +
    "      nodes {" +
    "        __typename" +
    "        id" +
    "        title" +
    "        number" +
    "        createdAt" +
    "        state" +
    "        author {" +
    "          __typename" +
    "          login" +
    "        }" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        hasNextPage" +
    "        endCursor" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public let owner: String
  public let name: String
  public let before: String?
  public let includeIssues: Bool
  public let includePullRequests: Bool

  public init(owner: String, name: String, before: String? = nil, includeIssues: Bool, includePullRequests: Bool) {
    self.owner = owner
    self.name = name
    self.before = before
    self.includeIssues = includeIssues
    self.includePullRequests = includePullRequests
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "before": before, "includeIssues": includeIssues, "includePullRequests": includePullRequests]
  }

  public struct Data: GraphQLMappable {
    /// Lookup a given repository by the owner and repository name.
    public let repository: Repository?

    public init(reader: GraphQLResultReader) throws {
      repository = try reader.optionalValue(for: Field(responseName: "repository", arguments: ["owner": reader.variables["owner"], "name": reader.variables["name"]]))
    }

    public struct Repository: GraphQLMappable {
      public let __typename: String
      /// A list of issues that have been opened in the repository.
      public let issues: Issue?
      /// A list of pull requests that have been opened in the repository.
      public let pullRequests: PullRequest?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        issues = try reader.optionalValue(for: Field(responseName: "issues", arguments: ["first": 25, "orderBy": ["field": "UPDATED_AT", "direction": "DESC"], "states": ["OPEN", "CLOSED"], "before": reader.variables["before"]]))
        pullRequests = try reader.optionalValue(for: Field(responseName: "pullRequests", arguments: ["first": 25, "orderBy": ["field": "UPDATED_AT", "direction": "DESC"], "states": ["OPEN", "CLOSED", "MERGED"]]))
      }

      public struct Issue: GraphQLMappable {
        public let __typename: String
        /// A list of nodes.
        public let nodes: [Node?]?
        /// Information to aid in pagination.
        public let pageInfo: PageInfo

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          nodes = try reader.optionalList(for: Field(responseName: "nodes"))
          pageInfo = try reader.value(for: Field(responseName: "pageInfo"))
        }

        public struct Node: GraphQLMappable {
          public let __typename: String
          public let id: GraphQLID
          /// Identifies the issue title.
          public let title: String
          /// Identifies the issue number.
          public let number: Int
          /// Identifies the date and time when the object was created.
          public let createdAt: String
          /// Identifies the state of the issue.
          public let state: IssueState
          /// The actor who authored the comment.
          public let author: Author?

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            id = try reader.value(for: Field(responseName: "id"))
            title = try reader.value(for: Field(responseName: "title"))
            number = try reader.value(for: Field(responseName: "number"))
            createdAt = try reader.value(for: Field(responseName: "createdAt"))
            state = try reader.value(for: Field(responseName: "state"))
            author = try reader.optionalValue(for: Field(responseName: "author"))
          }

          public struct Author: GraphQLMappable {
            public let __typename: String
            /// The username of the actor.
            public let login: String

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              login = try reader.value(for: Field(responseName: "login"))
            }
          }
        }

        public struct PageInfo: GraphQLMappable {
          public let __typename: String
          /// When paginating forwards, are there more items?
          public let hasNextPage: Bool
          /// When paginating forwards, the cursor to continue.
          public let endCursor: String?

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            hasNextPage = try reader.value(for: Field(responseName: "hasNextPage"))
            endCursor = try reader.optionalValue(for: Field(responseName: "endCursor"))
          }
        }
      }

      public struct PullRequest: GraphQLMappable {
        public let __typename: String
        /// A list of nodes.
        public let nodes: [Node?]?
        /// Information to aid in pagination.
        public let pageInfo: PageInfo

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          nodes = try reader.optionalList(for: Field(responseName: "nodes"))
          pageInfo = try reader.value(for: Field(responseName: "pageInfo"))
        }

        public struct Node: GraphQLMappable {
          public let __typename: String
          public let id: GraphQLID
          /// Identifies the pull request title.
          public let title: String
          /// Identifies the pull request number.
          public let number: Int
          /// Identifies the date and time when the object was created.
          public let createdAt: String
          /// Identifies the state of the pull request.
          public let state: PullRequestState
          /// The actor who authored the comment.
          public let author: Author?

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            id = try reader.value(for: Field(responseName: "id"))
            title = try reader.value(for: Field(responseName: "title"))
            number = try reader.value(for: Field(responseName: "number"))
            createdAt = try reader.value(for: Field(responseName: "createdAt"))
            state = try reader.value(for: Field(responseName: "state"))
            author = try reader.optionalValue(for: Field(responseName: "author"))
          }

          public struct Author: GraphQLMappable {
            public let __typename: String
            /// The username of the actor.
            public let login: String

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              login = try reader.value(for: Field(responseName: "login"))
            }
          }
        }

        public struct PageInfo: GraphQLMappable {
          public let __typename: String
          /// When paginating forwards, are there more items?
          public let hasNextPage: Bool
          /// When paginating forwards, the cursor to continue.
          public let endCursor: String?

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            hasNextPage = try reader.value(for: Field(responseName: "hasNextPage"))
            endCursor = try reader.optionalValue(for: Field(responseName: "endCursor"))
          }
        }
      }
    }
  }
}

public final class SearchReposQuery: GraphQLQuery {
  public static let operationDefinition =
    "query SearchRepos($search: String!, $before: String) {" +
    "  search(first: 25, query: $search, type: REPOSITORY, before: $before) {" +
    "    __typename" +
    "    nodes {" +
    "      __typename" +
    "      ... on Repository {" +
    "        __typename" +
    "        id" +
    "        name" +
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

  public let search: String
  public let before: String?

  public init(search: String, before: String? = nil) {
    self.search = search
    self.before = before
  }

  public var variables: GraphQLMap? {
    return ["search": search, "before": before]
  }

  public struct Data: GraphQLMappable {
    /// Perform a search across resources.
    public let search: Search

    public init(reader: GraphQLResultReader) throws {
      search = try reader.value(for: Field(responseName: "search", arguments: ["first": 25, "query": reader.variables["search"], "type": "REPOSITORY", "before": reader.variables["before"]]))
    }

    public struct Search: GraphQLMappable {
      public let __typename: String
      /// A list of nodes.
      public let nodes: [Node?]?
      /// Information to aid in pagination.
      public let pageInfo: PageInfo
      /// The number of repositories that matched the search query.
      public let repositoryCount: Int

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        nodes = try reader.optionalList(for: Field(responseName: "nodes"))
        pageInfo = try reader.value(for: Field(responseName: "pageInfo"))
        repositoryCount = try reader.value(for: Field(responseName: "repositoryCount"))
      }

      public struct Node: GraphQLMappable {
        public let __typename: String

        public let asRepository: AsRepository?

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))

          asRepository = try AsRepository(reader: reader, ifTypeMatches: __typename)
        }

        public struct AsRepository: GraphQLConditionalFragment {
          public static let possibleTypes = ["Repository"]

          public let __typename: String
          public let id: GraphQLID
          /// The name of the repository.
          public let name: String
          /// The User owner of the repository.
          public let owner: Owner
          /// The description of the repository.
          public let description: String?
          /// Identifies when the repository was last pushed to.
          public let pushedAt: String?
          /// The primary language of the repository's code.
          public let primaryLanguage: PrimaryLanguage?
          /// A list of users who have starred this starrable.
          public let stargazers: Stargazer

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))
            id = try reader.value(for: Field(responseName: "id"))
            name = try reader.value(for: Field(responseName: "name"))
            owner = try reader.value(for: Field(responseName: "owner"))
            description = try reader.optionalValue(for: Field(responseName: "description"))
            pushedAt = try reader.optionalValue(for: Field(responseName: "pushedAt"))
            primaryLanguage = try reader.optionalValue(for: Field(responseName: "primaryLanguage"))
            stargazers = try reader.value(for: Field(responseName: "stargazers"))
          }

          public struct Owner: GraphQLMappable {
            public let __typename: String
            /// The username used to login.
            public let login: String

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              login = try reader.value(for: Field(responseName: "login"))
            }
          }

          public struct PrimaryLanguage: GraphQLMappable {
            public let __typename: String
            /// The name of the current language.
            public let name: String
            /// The color defined for the current language.
            public let color: String?

            public init(reader: GraphQLResultReader) throws {
              __typename = try reader.value(for: Field(responseName: "__typename"))
              name = try reader.value(for: Field(responseName: "name"))
              color = try reader.optionalValue(for: Field(responseName: "color"))
            }
          }

          public struct Stargazer: GraphQLMappable {
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

      public struct PageInfo: GraphQLMappable {
        public let __typename: String
        /// When paginating forwards, the cursor to continue.
        public let endCursor: String?
        /// When paginating forwards, are there more items?
        public let hasNextPage: Bool

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          endCursor = try reader.optionalValue(for: Field(responseName: "endCursor"))
          hasNextPage = try reader.value(for: Field(responseName: "hasNextPage"))
        }
      }
    }
  }
}

public struct ReactionFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
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

  public let __typename: String
  /// Can user react to this subject
  public let viewerCanReact: Bool
  /// A list of reactions grouped by content left on the subject.
  public let reactionGroups: [ReactionGroup]?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    viewerCanReact = try reader.value(for: Field(responseName: "viewerCanReact"))
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
      users = try reader.value(for: Field(responseName: "users", arguments: ["first": 3]))
      content = try reader.value(for: Field(responseName: "content"))
    }

    public struct User: GraphQLMappable {
      public let __typename: String
      /// A list of nodes.
      public let nodes: [Node?]?
      /// Identifies the total count of items in the connection.
      public let totalCount: Int

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        nodes = try reader.optionalList(for: Field(responseName: "nodes"))
        totalCount = try reader.value(for: Field(responseName: "totalCount"))
      }

      public struct Node: GraphQLMappable {
        public let __typename: String
        /// The username used to login.
        public let login: String

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          login = try reader.value(for: Field(responseName: "login"))
        }
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
    "  lastEditedAt" +
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
  /// The moment the editor made the last edit
  public let lastEditedAt: String?
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
    lastEditedAt = try reader.optionalValue(for: Field(responseName: "lastEditedAt"))
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

public struct LockableFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment lockableFields on Lockable {" +
    "  __typename" +
    "  locked" +
    "}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public let __typename: String
  /// `true` if the object is locked
  public let locked: Bool

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    locked = try reader.value(for: Field(responseName: "locked"))
  }
}

public struct ClosableFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment closableFields on Closable {" +
    "  __typename" +
    "  closed" +
    "}"

  public static let possibleTypes = ["Issue", "PullRequest"]

  public let __typename: String
  /// `true` if the object is closed (definition of closed may depend on type)
  public let closed: Bool

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    closed = try reader.value(for: Field(responseName: "closed"))
  }
}

public struct LabelableFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
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

  public let __typename: String
  /// A list of labels associated with the object.
  public let labels: Label?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    labels = try reader.optionalValue(for: Field(responseName: "labels", arguments: ["first": 100]))
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
}

public struct UpdatableFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment updatableFields on Updatable {" +
    "  __typename" +
    "  viewerCanUpdate" +
    "}"

  public static let possibleTypes = ["Project", "Issue", "CommitComment", "PullRequest", "IssueComment", "PullRequestReview", "PullRequestReviewComment", "GistComment"]

  public let __typename: String
  /// Check if the current viewer can update this object.
  public let viewerCanUpdate: Bool

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    viewerCanUpdate = try reader.value(for: Field(responseName: "viewerCanUpdate"))
  }
}

public struct NodeFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment nodeFields on Node {" +
    "  __typename" +
    "  id" +
    "}"

  public static let possibleTypes = ["Organization", "Project", "ProjectColumn", "ProjectCard", "Issue", "User", "Repository", "CommitComment", "Reaction", "Commit", "Status", "StatusContext", "Tree", "Ref", "PullRequest", "Label", "IssueComment", "PullRequestCommit", "ReviewRequest", "PullRequestReview", "PullRequestReviewComment", "CommitCommentThread", "PullRequestReviewThread", "ClosedEvent", "ReopenedEvent", "SubscribedEvent", "UnsubscribedEvent", "MergedEvent", "ReferencedEvent", "AssignedEvent", "UnassignedEvent", "LabeledEvent", "UnlabeledEvent", "MilestonedEvent", "DemilestonedEvent", "RenamedTitleEvent", "LockedEvent", "UnlockedEvent", "DeployedEvent", "Deployment", "DeploymentStatus", "HeadRefDeletedEvent", "HeadRefRestoredEvent", "HeadRefForcePushedEvent", "BaseRefForcePushedEvent", "ReviewRequestedEvent", "ReviewRequestRemovedEvent", "ReviewDismissedEvent", "Language", "Milestone", "ProtectedBranch", "PushAllowance", "Team", "ReviewDismissalAllowance", "Release", "ReleaseAsset", "RepositoryTopic", "Topic", "Gist", "GistComment", "OrganizationIdentityProvider", "ExternalIdentity", "Blob", "Bot", "RepositoryInvitation", "Tag", "AddedToProjectEvent", "BaseRefChangedEvent", "CommentDeletedEvent", "ConvertedNoteToIssueEvent", "MentionedEvent", "MovedColumnsInProjectEvent", "RemovedFromProjectEvent"]

  public let __typename: String
  /// ID of the object.
  public let id: GraphQLID

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
  }
}

public struct ReferencedRepositoryFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment referencedRepositoryFields on RepositoryInfo {" +
    "  __typename" +
    "  name" +
    "  owner {" +
    "    __typename" +
    "    login" +
    "  }" +
    "}"

  public static let possibleTypes = ["Repository", "RepositoryInvitationRepository"]

  public let __typename: String
  /// The name of the repository.
  public let name: String
  /// The User owner of the repository.
  public let owner: Owner

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    name = try reader.value(for: Field(responseName: "name"))
    owner = try reader.value(for: Field(responseName: "owner"))
  }

  public struct Owner: GraphQLMappable {
    public let __typename: String
    /// The username used to login.
    public let login: String

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      login = try reader.value(for: Field(responseName: "login"))
    }
  }
}

public struct AssigneeFields: GraphQLNamedFragment {
  public static let fragmentDefinition =
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

  public let __typename: String
  /// A list of Users assigned to this object.
  public let assignees: Assignee

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    assignees = try reader.value(for: Field(responseName: "assignees", arguments: ["first": reader.variables["page_size"]]))
  }

  public struct Assignee: GraphQLMappable {
    public let __typename: String
    /// A list of nodes.
    public let nodes: [Node?]?

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      nodes = try reader.optionalList(for: Field(responseName: "nodes"))
    }

    public struct Node: GraphQLMappable {
      public let __typename: String
      /// The username used to login.
      public let login: String
      /// A URL pointing to the user's public avatar.
      public let avatarUrl: String

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        login = try reader.value(for: Field(responseName: "login"))
        avatarUrl = try reader.value(for: Field(responseName: "avatarUrl"))
      }
    }
  }
}

public struct HeadPaging: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment headPaging on PageInfo {" +
    "  __typename" +
    "  hasPreviousPage" +
    "  startCursor" +
    "}"

  public static let possibleTypes = ["PageInfo"]

  public let __typename: String
  /// When paginating backwards, are there more items?
  public let hasPreviousPage: Bool
  /// When paginating backwards, the cursor to continue.
  public let startCursor: String?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    hasPreviousPage = try reader.value(for: Field(responseName: "hasPreviousPage"))
    startCursor = try reader.optionalValue(for: Field(responseName: "startCursor"))
  }
}