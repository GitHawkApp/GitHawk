//
//  Source.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Source: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let pullsUrl = "pulls_url"
    static let subscribersUrl = "subscribers_url"
    static let tagsUrl = "tags_url"
    static let cloneUrl = "clone_url"
    static let gitUrl = "git_url"
    static let size = "size"
    static let gitTagsUrl = "git_tags_url"
    static let subscribersCount = "subscribers_count"
    static let id = "id"
    static let defaultBranch = "default_branch"
    static let issueEventsUrl = "issue_events_url"
    static let mirrorUrl = "mirror_url"
    static let hasPages = "has_pages"
    static let downloadsUrl = "downloads_url"
    static let commentsUrl = "comments_url"
    static let homepage = "homepage"
    static let teamsUrl = "teams_url"
    static let url = "url"
    static let allowSquashMerge = "allow_squash_merge"
    static let hooksUrl = "hooks_url"
    static let htmlUrl = "html_url"
    static let issuesUrl = "issues_url"
    static let fullName = "full_name"
    static let fork = "fork"
    static let descriptionValue = "description"
    static let notificationsUrl = "notifications_url"
    static let sshUrl = "ssh_url"
    static let stargazersCount = "stargazers_count"
    static let allowMergeCommit = "allow_merge_commit"
    static let issueCommentUrl = "issue_comment_url"
    static let languagesUrl = "languages_url"
    static let branchesUrl = "branches_url"
    static let milestonesUrl = "milestones_url"
    static let assigneesUrl = "assignees_url"
    static let collaboratorsUrl = "collaborators_url"
    static let hasIssues = "has_issues"
    static let networkCount = "network_count"
    static let archiveUrl = "archive_url"
    static let createdAt = "created_at"
    static let compareUrl = "compare_url"
    static let openIssuesCount = "open_issues_count"
    static let labelsUrl = "labels_url"
    static let forksCount = "forks_count"
    static let eventsUrl = "events_url"
    static let blobsUrl = "blobs_url"
    static let hasDownloads = "has_downloads"
    static let svnUrl = "svn_url"
    static let forksUrl = "forks_url"
    static let private = "private"
    static let releasesUrl = "releases_url"
    static let language = "language"
    static let pushedAt = "pushed_at"
    static let contentsUrl = "contents_url"
    static let statusesUrl = "statuses_url"
    static let owner = "owner"
    static let allowRebaseMerge = "allow_rebase_merge"
    static let gitRefsUrl = "git_refs_url"
    static let stargazersUrl = "stargazers_url"
    static let name = "name"
    static let topics = "topics"
    static let updatedAt = "updated_at"
    static let subscriptionUrl = "subscription_url"
    static let contributorsUrl = "contributors_url"
    static let treesUrl = "trees_url"
    static let keysUrl = "keys_url"
    static let hasWiki = "has_wiki"
    static let gitCommitsUrl = "git_commits_url"
    static let commitsUrl = "commits_url"
    static let watchersCount = "watchers_count"
    static let deploymentsUrl = "deployments_url"
    static let permissions = "permissions"
    static let mergesUrl = "merges_url"
  }

  // MARK: Properties
  public var pullsUrl: String?
  public var subscribersUrl: String?
  public var tagsUrl: String?
  public var cloneUrl: String?
  public var gitUrl: String?
  public var size: Int?
  public var gitTagsUrl: String?
  public var subscribersCount: Int?
  public var id: Int?
  public var defaultBranch: String?
  public var issueEventsUrl: String?
  public var mirrorUrl: String?
  public var hasPages: Bool? = false
  public var downloadsUrl: String?
  public var commentsUrl: String?
  public var homepage: String?
  public var teamsUrl: String?
  public var url: String?
  public var allowSquashMerge: Bool? = false
  public var hooksUrl: String?
  public var htmlUrl: String?
  public var issuesUrl: String?
  public var fullName: String?
  public var fork: Bool? = false
  public var descriptionValue: String?
  public var notificationsUrl: String?
  public var sshUrl: String?
  public var stargazersCount: Int?
  public var allowMergeCommit: Bool? = false
  public var issueCommentUrl: String?
  public var languagesUrl: String?
  public var branchesUrl: String?
  public var milestonesUrl: String?
  public var assigneesUrl: String?
  public var collaboratorsUrl: String?
  public var hasIssues: Bool? = false
  public var networkCount: Int?
  public var archiveUrl: String?
  public var createdAt: String?
  public var compareUrl: String?
  public var openIssuesCount: Int?
  public var labelsUrl: String?
  public var forksCount: Int?
  public var eventsUrl: String?
  public var blobsUrl: String?
  public var hasDownloads: Bool? = false
  public var svnUrl: String?
  public var forksUrl: String?
  public var private: Bool? = false
  public var releasesUrl: String?
  public var language: String?
  public var pushedAt: String?
  public var contentsUrl: String?
  public var statusesUrl: String?
  public var owner: Owner?
  public var allowRebaseMerge: Bool? = false
  public var gitRefsUrl: String?
  public var stargazersUrl: String?
  public var name: String?
  public var topics: [String]?
  public var updatedAt: String?
  public var subscriptionUrl: String?
  public var contributorsUrl: String?
  public var treesUrl: String?
  public var keysUrl: String?
  public var hasWiki: Bool? = false
  public var gitCommitsUrl: String?
  public var commitsUrl: String?
  public var watchersCount: Int?
  public var deploymentsUrl: String?
  public var permissions: Permissions?
  public var mergesUrl: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    pullsUrl = json[SerializationKeys.pullsUrl].string
    subscribersUrl = json[SerializationKeys.subscribersUrl].string
    tagsUrl = json[SerializationKeys.tagsUrl].string
    cloneUrl = json[SerializationKeys.cloneUrl].string
    gitUrl = json[SerializationKeys.gitUrl].string
    size = json[SerializationKeys.size].int
    gitTagsUrl = json[SerializationKeys.gitTagsUrl].string
    subscribersCount = json[SerializationKeys.subscribersCount].int
    id = json[SerializationKeys.id].int
    defaultBranch = json[SerializationKeys.defaultBranch].string
    issueEventsUrl = json[SerializationKeys.issueEventsUrl].string
    mirrorUrl = json[SerializationKeys.mirrorUrl].string
    hasPages = json[SerializationKeys.hasPages].boolValue
    downloadsUrl = json[SerializationKeys.downloadsUrl].string
    commentsUrl = json[SerializationKeys.commentsUrl].string
    homepage = json[SerializationKeys.homepage].string
    teamsUrl = json[SerializationKeys.teamsUrl].string
    url = json[SerializationKeys.url].string
    allowSquashMerge = json[SerializationKeys.allowSquashMerge].boolValue
    hooksUrl = json[SerializationKeys.hooksUrl].string
    htmlUrl = json[SerializationKeys.htmlUrl].string
    issuesUrl = json[SerializationKeys.issuesUrl].string
    fullName = json[SerializationKeys.fullName].string
    fork = json[SerializationKeys.fork].boolValue
    descriptionValue = json[SerializationKeys.descriptionValue].string
    notificationsUrl = json[SerializationKeys.notificationsUrl].string
    sshUrl = json[SerializationKeys.sshUrl].string
    stargazersCount = json[SerializationKeys.stargazersCount].int
    allowMergeCommit = json[SerializationKeys.allowMergeCommit].boolValue
    issueCommentUrl = json[SerializationKeys.issueCommentUrl].string
    languagesUrl = json[SerializationKeys.languagesUrl].string
    branchesUrl = json[SerializationKeys.branchesUrl].string
    milestonesUrl = json[SerializationKeys.milestonesUrl].string
    assigneesUrl = json[SerializationKeys.assigneesUrl].string
    collaboratorsUrl = json[SerializationKeys.collaboratorsUrl].string
    hasIssues = json[SerializationKeys.hasIssues].boolValue
    networkCount = json[SerializationKeys.networkCount].int
    archiveUrl = json[SerializationKeys.archiveUrl].string
    createdAt = json[SerializationKeys.createdAt].string
    compareUrl = json[SerializationKeys.compareUrl].string
    openIssuesCount = json[SerializationKeys.openIssuesCount].int
    labelsUrl = json[SerializationKeys.labelsUrl].string
    forksCount = json[SerializationKeys.forksCount].int
    eventsUrl = json[SerializationKeys.eventsUrl].string
    blobsUrl = json[SerializationKeys.blobsUrl].string
    hasDownloads = json[SerializationKeys.hasDownloads].boolValue
    svnUrl = json[SerializationKeys.svnUrl].string
    forksUrl = json[SerializationKeys.forksUrl].string
    private = json[SerializationKeys.private].boolValue
    releasesUrl = json[SerializationKeys.releasesUrl].string
    language = json[SerializationKeys.language].string
    pushedAt = json[SerializationKeys.pushedAt].string
    contentsUrl = json[SerializationKeys.contentsUrl].string
    statusesUrl = json[SerializationKeys.statusesUrl].string
    owner = Owner(json: json[SerializationKeys.owner])
    allowRebaseMerge = json[SerializationKeys.allowRebaseMerge].boolValue
    gitRefsUrl = json[SerializationKeys.gitRefsUrl].string
    stargazersUrl = json[SerializationKeys.stargazersUrl].string
    name = json[SerializationKeys.name].string
    if let items = json[SerializationKeys.topics].array { topics = items.map { $0.stringValue } }
    updatedAt = json[SerializationKeys.updatedAt].string
    subscriptionUrl = json[SerializationKeys.subscriptionUrl].string
    contributorsUrl = json[SerializationKeys.contributorsUrl].string
    treesUrl = json[SerializationKeys.treesUrl].string
    keysUrl = json[SerializationKeys.keysUrl].string
    hasWiki = json[SerializationKeys.hasWiki].boolValue
    gitCommitsUrl = json[SerializationKeys.gitCommitsUrl].string
    commitsUrl = json[SerializationKeys.commitsUrl].string
    watchersCount = json[SerializationKeys.watchersCount].int
    deploymentsUrl = json[SerializationKeys.deploymentsUrl].string
    permissions = Permissions(json: json[SerializationKeys.permissions])
    mergesUrl = json[SerializationKeys.mergesUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pullsUrl { dictionary[SerializationKeys.pullsUrl] = value }
    if let value = subscribersUrl { dictionary[SerializationKeys.subscribersUrl] = value }
    if let value = tagsUrl { dictionary[SerializationKeys.tagsUrl] = value }
    if let value = cloneUrl { dictionary[SerializationKeys.cloneUrl] = value }
    if let value = gitUrl { dictionary[SerializationKeys.gitUrl] = value }
    if let value = size { dictionary[SerializationKeys.size] = value }
    if let value = gitTagsUrl { dictionary[SerializationKeys.gitTagsUrl] = value }
    if let value = subscribersCount { dictionary[SerializationKeys.subscribersCount] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = defaultBranch { dictionary[SerializationKeys.defaultBranch] = value }
    if let value = issueEventsUrl { dictionary[SerializationKeys.issueEventsUrl] = value }
    if let value = mirrorUrl { dictionary[SerializationKeys.mirrorUrl] = value }
    dictionary[SerializationKeys.hasPages] = hasPages
    if let value = downloadsUrl { dictionary[SerializationKeys.downloadsUrl] = value }
    if let value = commentsUrl { dictionary[SerializationKeys.commentsUrl] = value }
    if let value = homepage { dictionary[SerializationKeys.homepage] = value }
    if let value = teamsUrl { dictionary[SerializationKeys.teamsUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    dictionary[SerializationKeys.allowSquashMerge] = allowSquashMerge
    if let value = hooksUrl { dictionary[SerializationKeys.hooksUrl] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    if let value = issuesUrl { dictionary[SerializationKeys.issuesUrl] = value }
    if let value = fullName { dictionary[SerializationKeys.fullName] = value }
    dictionary[SerializationKeys.fork] = fork
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = notificationsUrl { dictionary[SerializationKeys.notificationsUrl] = value }
    if let value = sshUrl { dictionary[SerializationKeys.sshUrl] = value }
    if let value = stargazersCount { dictionary[SerializationKeys.stargazersCount] = value }
    dictionary[SerializationKeys.allowMergeCommit] = allowMergeCommit
    if let value = issueCommentUrl { dictionary[SerializationKeys.issueCommentUrl] = value }
    if let value = languagesUrl { dictionary[SerializationKeys.languagesUrl] = value }
    if let value = branchesUrl { dictionary[SerializationKeys.branchesUrl] = value }
    if let value = milestonesUrl { dictionary[SerializationKeys.milestonesUrl] = value }
    if let value = assigneesUrl { dictionary[SerializationKeys.assigneesUrl] = value }
    if let value = collaboratorsUrl { dictionary[SerializationKeys.collaboratorsUrl] = value }
    dictionary[SerializationKeys.hasIssues] = hasIssues
    if let value = networkCount { dictionary[SerializationKeys.networkCount] = value }
    if let value = archiveUrl { dictionary[SerializationKeys.archiveUrl] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = compareUrl { dictionary[SerializationKeys.compareUrl] = value }
    if let value = openIssuesCount { dictionary[SerializationKeys.openIssuesCount] = value }
    if let value = labelsUrl { dictionary[SerializationKeys.labelsUrl] = value }
    if let value = forksCount { dictionary[SerializationKeys.forksCount] = value }
    if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
    if let value = blobsUrl { dictionary[SerializationKeys.blobsUrl] = value }
    dictionary[SerializationKeys.hasDownloads] = hasDownloads
    if let value = svnUrl { dictionary[SerializationKeys.svnUrl] = value }
    if let value = forksUrl { dictionary[SerializationKeys.forksUrl] = value }
    dictionary[SerializationKeys.private] = private
    if let value = releasesUrl { dictionary[SerializationKeys.releasesUrl] = value }
    if let value = language { dictionary[SerializationKeys.language] = value }
    if let value = pushedAt { dictionary[SerializationKeys.pushedAt] = value }
    if let value = contentsUrl { dictionary[SerializationKeys.contentsUrl] = value }
    if let value = statusesUrl { dictionary[SerializationKeys.statusesUrl] = value }
    if let value = owner { dictionary[SerializationKeys.owner] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.allowRebaseMerge] = allowRebaseMerge
    if let value = gitRefsUrl { dictionary[SerializationKeys.gitRefsUrl] = value }
    if let value = stargazersUrl { dictionary[SerializationKeys.stargazersUrl] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = topics { dictionary[SerializationKeys.topics] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = subscriptionUrl { dictionary[SerializationKeys.subscriptionUrl] = value }
    if let value = contributorsUrl { dictionary[SerializationKeys.contributorsUrl] = value }
    if let value = treesUrl { dictionary[SerializationKeys.treesUrl] = value }
    if let value = keysUrl { dictionary[SerializationKeys.keysUrl] = value }
    dictionary[SerializationKeys.hasWiki] = hasWiki
    if let value = gitCommitsUrl { dictionary[SerializationKeys.gitCommitsUrl] = value }
    if let value = commitsUrl { dictionary[SerializationKeys.commitsUrl] = value }
    if let value = watchersCount { dictionary[SerializationKeys.watchersCount] = value }
    if let value = deploymentsUrl { dictionary[SerializationKeys.deploymentsUrl] = value }
    if let value = permissions { dictionary[SerializationKeys.permissions] = value.dictionaryRepresentation() }
    if let value = mergesUrl { dictionary[SerializationKeys.mergesUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.pullsUrl = aDecoder.decodeObject(forKey: SerializationKeys.pullsUrl) as? String
    self.subscribersUrl = aDecoder.decodeObject(forKey: SerializationKeys.subscribersUrl) as? String
    self.tagsUrl = aDecoder.decodeObject(forKey: SerializationKeys.tagsUrl) as? String
    self.cloneUrl = aDecoder.decodeObject(forKey: SerializationKeys.cloneUrl) as? String
    self.gitUrl = aDecoder.decodeObject(forKey: SerializationKeys.gitUrl) as? String
    self.size = aDecoder.decodeObject(forKey: SerializationKeys.size) as? Int
    self.gitTagsUrl = aDecoder.decodeObject(forKey: SerializationKeys.gitTagsUrl) as? String
    self.subscribersCount = aDecoder.decodeObject(forKey: SerializationKeys.subscribersCount) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.defaultBranch = aDecoder.decodeObject(forKey: SerializationKeys.defaultBranch) as? String
    self.issueEventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.issueEventsUrl) as? String
    self.mirrorUrl = aDecoder.decodeObject(forKey: SerializationKeys.mirrorUrl) as? String
    self.hasPages = aDecoder.decodeBool(forKey: SerializationKeys.hasPages)
    self.downloadsUrl = aDecoder.decodeObject(forKey: SerializationKeys.downloadsUrl) as? String
    self.commentsUrl = aDecoder.decodeObject(forKey: SerializationKeys.commentsUrl) as? String
    self.homepage = aDecoder.decodeObject(forKey: SerializationKeys.homepage) as? String
    self.teamsUrl = aDecoder.decodeObject(forKey: SerializationKeys.teamsUrl) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.allowSquashMerge = aDecoder.decodeBool(forKey: SerializationKeys.allowSquashMerge)
    self.hooksUrl = aDecoder.decodeObject(forKey: SerializationKeys.hooksUrl) as? String
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.issuesUrl = aDecoder.decodeObject(forKey: SerializationKeys.issuesUrl) as? String
    self.fullName = aDecoder.decodeObject(forKey: SerializationKeys.fullName) as? String
    self.fork = aDecoder.decodeBool(forKey: SerializationKeys.fork)
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.notificationsUrl = aDecoder.decodeObject(forKey: SerializationKeys.notificationsUrl) as? String
    self.sshUrl = aDecoder.decodeObject(forKey: SerializationKeys.sshUrl) as? String
    self.stargazersCount = aDecoder.decodeObject(forKey: SerializationKeys.stargazersCount) as? Int
    self.allowMergeCommit = aDecoder.decodeBool(forKey: SerializationKeys.allowMergeCommit)
    self.issueCommentUrl = aDecoder.decodeObject(forKey: SerializationKeys.issueCommentUrl) as? String
    self.languagesUrl = aDecoder.decodeObject(forKey: SerializationKeys.languagesUrl) as? String
    self.branchesUrl = aDecoder.decodeObject(forKey: SerializationKeys.branchesUrl) as? String
    self.milestonesUrl = aDecoder.decodeObject(forKey: SerializationKeys.milestonesUrl) as? String
    self.assigneesUrl = aDecoder.decodeObject(forKey: SerializationKeys.assigneesUrl) as? String
    self.collaboratorsUrl = aDecoder.decodeObject(forKey: SerializationKeys.collaboratorsUrl) as? String
    self.hasIssues = aDecoder.decodeBool(forKey: SerializationKeys.hasIssues)
    self.networkCount = aDecoder.decodeObject(forKey: SerializationKeys.networkCount) as? Int
    self.archiveUrl = aDecoder.decodeObject(forKey: SerializationKeys.archiveUrl) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.compareUrl = aDecoder.decodeObject(forKey: SerializationKeys.compareUrl) as? String
    self.openIssuesCount = aDecoder.decodeObject(forKey: SerializationKeys.openIssuesCount) as? Int
    self.labelsUrl = aDecoder.decodeObject(forKey: SerializationKeys.labelsUrl) as? String
    self.forksCount = aDecoder.decodeObject(forKey: SerializationKeys.forksCount) as? Int
    self.eventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.eventsUrl) as? String
    self.blobsUrl = aDecoder.decodeObject(forKey: SerializationKeys.blobsUrl) as? String
    self.hasDownloads = aDecoder.decodeBool(forKey: SerializationKeys.hasDownloads)
    self.svnUrl = aDecoder.decodeObject(forKey: SerializationKeys.svnUrl) as? String
    self.forksUrl = aDecoder.decodeObject(forKey: SerializationKeys.forksUrl) as? String
    self.private = aDecoder.decodeBool(forKey: SerializationKeys.private)
    self.releasesUrl = aDecoder.decodeObject(forKey: SerializationKeys.releasesUrl) as? String
    self.language = aDecoder.decodeObject(forKey: SerializationKeys.language) as? String
    self.pushedAt = aDecoder.decodeObject(forKey: SerializationKeys.pushedAt) as? String
    self.contentsUrl = aDecoder.decodeObject(forKey: SerializationKeys.contentsUrl) as? String
    self.statusesUrl = aDecoder.decodeObject(forKey: SerializationKeys.statusesUrl) as? String
    self.owner = aDecoder.decodeObject(forKey: SerializationKeys.owner) as? Owner
    self.allowRebaseMerge = aDecoder.decodeBool(forKey: SerializationKeys.allowRebaseMerge)
    self.gitRefsUrl = aDecoder.decodeObject(forKey: SerializationKeys.gitRefsUrl) as? String
    self.stargazersUrl = aDecoder.decodeObject(forKey: SerializationKeys.stargazersUrl) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.topics = aDecoder.decodeObject(forKey: SerializationKeys.topics) as? [String]
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.subscriptionUrl = aDecoder.decodeObject(forKey: SerializationKeys.subscriptionUrl) as? String
    self.contributorsUrl = aDecoder.decodeObject(forKey: SerializationKeys.contributorsUrl) as? String
    self.treesUrl = aDecoder.decodeObject(forKey: SerializationKeys.treesUrl) as? String
    self.keysUrl = aDecoder.decodeObject(forKey: SerializationKeys.keysUrl) as? String
    self.hasWiki = aDecoder.decodeBool(forKey: SerializationKeys.hasWiki)
    self.gitCommitsUrl = aDecoder.decodeObject(forKey: SerializationKeys.gitCommitsUrl) as? String
    self.commitsUrl = aDecoder.decodeObject(forKey: SerializationKeys.commitsUrl) as? String
    self.watchersCount = aDecoder.decodeObject(forKey: SerializationKeys.watchersCount) as? Int
    self.deploymentsUrl = aDecoder.decodeObject(forKey: SerializationKeys.deploymentsUrl) as? String
    self.permissions = aDecoder.decodeObject(forKey: SerializationKeys.permissions) as? Permissions
    self.mergesUrl = aDecoder.decodeObject(forKey: SerializationKeys.mergesUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(pullsUrl, forKey: SerializationKeys.pullsUrl)
    aCoder.encode(subscribersUrl, forKey: SerializationKeys.subscribersUrl)
    aCoder.encode(tagsUrl, forKey: SerializationKeys.tagsUrl)
    aCoder.encode(cloneUrl, forKey: SerializationKeys.cloneUrl)
    aCoder.encode(gitUrl, forKey: SerializationKeys.gitUrl)
    aCoder.encode(size, forKey: SerializationKeys.size)
    aCoder.encode(gitTagsUrl, forKey: SerializationKeys.gitTagsUrl)
    aCoder.encode(subscribersCount, forKey: SerializationKeys.subscribersCount)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(defaultBranch, forKey: SerializationKeys.defaultBranch)
    aCoder.encode(issueEventsUrl, forKey: SerializationKeys.issueEventsUrl)
    aCoder.encode(mirrorUrl, forKey: SerializationKeys.mirrorUrl)
    aCoder.encode(hasPages, forKey: SerializationKeys.hasPages)
    aCoder.encode(downloadsUrl, forKey: SerializationKeys.downloadsUrl)
    aCoder.encode(commentsUrl, forKey: SerializationKeys.commentsUrl)
    aCoder.encode(homepage, forKey: SerializationKeys.homepage)
    aCoder.encode(teamsUrl, forKey: SerializationKeys.teamsUrl)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(allowSquashMerge, forKey: SerializationKeys.allowSquashMerge)
    aCoder.encode(hooksUrl, forKey: SerializationKeys.hooksUrl)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(issuesUrl, forKey: SerializationKeys.issuesUrl)
    aCoder.encode(fullName, forKey: SerializationKeys.fullName)
    aCoder.encode(fork, forKey: SerializationKeys.fork)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(notificationsUrl, forKey: SerializationKeys.notificationsUrl)
    aCoder.encode(sshUrl, forKey: SerializationKeys.sshUrl)
    aCoder.encode(stargazersCount, forKey: SerializationKeys.stargazersCount)
    aCoder.encode(allowMergeCommit, forKey: SerializationKeys.allowMergeCommit)
    aCoder.encode(issueCommentUrl, forKey: SerializationKeys.issueCommentUrl)
    aCoder.encode(languagesUrl, forKey: SerializationKeys.languagesUrl)
    aCoder.encode(branchesUrl, forKey: SerializationKeys.branchesUrl)
    aCoder.encode(milestonesUrl, forKey: SerializationKeys.milestonesUrl)
    aCoder.encode(assigneesUrl, forKey: SerializationKeys.assigneesUrl)
    aCoder.encode(collaboratorsUrl, forKey: SerializationKeys.collaboratorsUrl)
    aCoder.encode(hasIssues, forKey: SerializationKeys.hasIssues)
    aCoder.encode(networkCount, forKey: SerializationKeys.networkCount)
    aCoder.encode(archiveUrl, forKey: SerializationKeys.archiveUrl)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(compareUrl, forKey: SerializationKeys.compareUrl)
    aCoder.encode(openIssuesCount, forKey: SerializationKeys.openIssuesCount)
    aCoder.encode(labelsUrl, forKey: SerializationKeys.labelsUrl)
    aCoder.encode(forksCount, forKey: SerializationKeys.forksCount)
    aCoder.encode(eventsUrl, forKey: SerializationKeys.eventsUrl)
    aCoder.encode(blobsUrl, forKey: SerializationKeys.blobsUrl)
    aCoder.encode(hasDownloads, forKey: SerializationKeys.hasDownloads)
    aCoder.encode(svnUrl, forKey: SerializationKeys.svnUrl)
    aCoder.encode(forksUrl, forKey: SerializationKeys.forksUrl)
    aCoder.encode(private, forKey: SerializationKeys.private)
    aCoder.encode(releasesUrl, forKey: SerializationKeys.releasesUrl)
    aCoder.encode(language, forKey: SerializationKeys.language)
    aCoder.encode(pushedAt, forKey: SerializationKeys.pushedAt)
    aCoder.encode(contentsUrl, forKey: SerializationKeys.contentsUrl)
    aCoder.encode(statusesUrl, forKey: SerializationKeys.statusesUrl)
    aCoder.encode(owner, forKey: SerializationKeys.owner)
    aCoder.encode(allowRebaseMerge, forKey: SerializationKeys.allowRebaseMerge)
    aCoder.encode(gitRefsUrl, forKey: SerializationKeys.gitRefsUrl)
    aCoder.encode(stargazersUrl, forKey: SerializationKeys.stargazersUrl)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(topics, forKey: SerializationKeys.topics)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(subscriptionUrl, forKey: SerializationKeys.subscriptionUrl)
    aCoder.encode(contributorsUrl, forKey: SerializationKeys.contributorsUrl)
    aCoder.encode(treesUrl, forKey: SerializationKeys.treesUrl)
    aCoder.encode(keysUrl, forKey: SerializationKeys.keysUrl)
    aCoder.encode(hasWiki, forKey: SerializationKeys.hasWiki)
    aCoder.encode(gitCommitsUrl, forKey: SerializationKeys.gitCommitsUrl)
    aCoder.encode(commitsUrl, forKey: SerializationKeys.commitsUrl)
    aCoder.encode(watchersCount, forKey: SerializationKeys.watchersCount)
    aCoder.encode(deploymentsUrl, forKey: SerializationKeys.deploymentsUrl)
    aCoder.encode(permissions, forKey: SerializationKeys.permissions)
    aCoder.encode(mergesUrl, forKey: SerializationKeys.mergesUrl)
  }

}
