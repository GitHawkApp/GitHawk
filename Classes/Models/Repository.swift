import Foundation
final class Repository: NSObject, NSCoding {
  struct Keys {
    static let pulls_url = "pulls_url"
    static let subscribers_url = "subscribers_url"
    static let tags_url = "tags_url"
    static let clone_url = "clone_url"
    static let git_url = "git_url"
    static let size = "size"
    static let git_tags_url = "git_tags_url"
    static let subscribers_count = "subscribers_count"
    static let id = "id"
    static let default_branch = "default_branch"
    static let issue_events_url = "issue_events_url"
    static let mirror_url = "mirror_url"
    static let has_pages = "has_pages"
    static let downloads_url = "downloads_url"
    static let comments_url = "comments_url"
    static let homepage = "homepage"
    static let teams_url = "teams_url"
    static let url = "url"
    static let allow_squash_merge = "allow_squash_merge"
    static let hooks_url = "hooks_url"
    static let html_url = "html_url"
    static let issues_url = "issues_url"
    static let full_name = "full_name"
    static let fork = "fork"
    static let description = "description"
    static let notifications_url = "notifications_url"
    static let ssh_url = "ssh_url"
    static let stargazers_count = "stargazers_count"
    static let allow_merge_commit = "allow_merge_commit"
    static let issue_comment_url = "issue_comment_url"
    static let languages_url = "languages_url"
    static let branches_url = "branches_url"
    static let milestones_url = "milestones_url"
    static let assignees_url = "assignees_url"
    static let collaborators_url = "collaborators_url"
    static let has_issues = "has_issues"
    static let network_count = "network_count"
    static let archive_url = "archive_url"
    static let created_at = "created_at"
    static let compare_url = "compare_url"
    static let open_issues_count = "open_issues_count"
    static let labels_url = "labels_url"
    static let forks_count = "forks_count"
    static let events_url = "events_url"
    static let blobs_url = "blobs_url"
    static let has_downloads = "has_downloads"
    static let svn_url = "svn_url"
    static let forks_url = "forks_url"
    static let source = "source"
    static let private_ = "private"
    static let releases_url = "releases_url"
    static let language = "language"
    static let pushed_at = "pushed_at"
    static let contents_url = "contents_url"
    static let statuses_url = "statuses_url"
    static let parent = "parent"
    static let owner = "owner"
    static let allow_rebase_merge = "allow_rebase_merge"
    static let git_refs_url = "git_refs_url"
    static let stargazers_url = "stargazers_url"
    static let name = "name"
    static let topics = "topics"
    static let updated_at = "updated_at"
    static let subscription_url = "subscription_url"
    static let contributors_url = "contributors_url"
    static let trees_url = "trees_url"
    static let keys_url = "keys_url"
    static let has_wiki = "has_wiki"
    static let git_commits_url = "git_commits_url"
    static let commits_url = "commits_url"
    static let watchers_count = "watchers_count"
    static let organization = "organization"
    static let deployments_url = "deployments_url"
    static let permissions = "permissions"
    static let merges_url = "merges_url"
  }
  let pulls_url: String?
  let subscribers_url: String?
  let tags_url: String?
  let clone_url: String?
  let git_url: String?
  let size: NSNumber?
  let git_tags_url: String?
  let subscribers_count: NSNumber?
  let id: NSNumber
  let default_branch: String?
  let issue_events_url: String?
  let mirror_url: String?
  let has_pages: Bool?
  let downloads_url: String?
  let comments_url: String?
  let homepage: String?
  let teams_url: String?
  let url: String
  let allow_squash_merge: Bool?
  let hooks_url: String?
  let html_url: String
  let issues_url: String?
  let full_name: String
  let fork: Bool
  let description: String
  let notifications_url: String?
  let ssh_url: String?
  let stargazers_count: NSNumber?
  let allow_merge_commit: Bool?
  let issue_comment_url: String?
  let languages_url: String?
  let branches_url: String?
  let milestones_url: String?
  let assignees_url: String?
  let collaborators_url: String?
  let has_issues: Bool?
  let network_count: NSNumber?
  let archive_url: String?
  let created_at: String?
  let compare_url: String?
  let open_issues_count: NSNumber?
  let labels_url: String?
  let forks_count: NSNumber?
  let events_url: String?
  let blobs_url: String?
  let has_downloads: Bool?
  let svn_url: String?
  let forks_url: String?
  let source: Repository?
  let private_: Bool
  let releases_url: String?
  let language: String?
  let pushed_at: String?
  let contents_url: String?
  let statuses_url: String?
  let parent: Repository?
  let owner: User
  let allow_rebase_merge: Bool?
  let git_refs_url: String?
  let stargazers_url: String?
  let name: String
  let topics: [String]?
  let updated_at: String?
  let subscription_url: String?
  let contributors_url: String?
  let trees_url: String?
  let keys_url: String?
  let has_wiki: Bool?
  let git_commits_url: String?
  let commits_url: String?
  let watchers_count: NSNumber?
  let organization: Organization?
  let deployments_url: String?
  let permissions: Permission?
  let merges_url: String?
  convenience init?(json: [String: Any]?) {
    let pulls_url = json?[Keys.pulls_url] as? String
    let subscribers_url = json?[Keys.subscribers_url] as? String
    let tags_url = json?[Keys.tags_url] as? String
    let clone_url = json?[Keys.clone_url] as? String
    let git_url = json?[Keys.git_url] as? String
    let size = json?[Keys.size] as? NSNumber
    let git_tags_url = json?[Keys.git_tags_url] as? String
    let subscribers_count = json?[Keys.subscribers_count] as? NSNumber
    guard let id = json?[Keys.id] as? NSNumber else { return nil }
    let default_branch = json?[Keys.default_branch] as? String
    let issue_events_url = json?[Keys.issue_events_url] as? String
    let mirror_url = json?[Keys.mirror_url] as? String
    let has_pages = json?[Keys.has_pages] as? Bool
    let downloads_url = json?[Keys.downloads_url] as? String
    let comments_url = json?[Keys.comments_url] as? String
    let homepage = json?[Keys.homepage] as? String
    let teams_url = json?[Keys.teams_url] as? String
    guard let url = json?[Keys.url] as? String else { return nil }
    let allow_squash_merge = json?[Keys.allow_squash_merge] as? Bool
    let hooks_url = json?[Keys.hooks_url] as? String
    guard let html_url = json?[Keys.html_url] as? String else { return nil }
    let issues_url = json?[Keys.issues_url] as? String
    guard let full_name = json?[Keys.full_name] as? String else { return nil }
    guard let fork = json?[Keys.fork] as? Bool else { return nil }
    guard let description = json?[Keys.description] as? String else { return nil }
    let notifications_url = json?[Keys.notifications_url] as? String
    let ssh_url = json?[Keys.ssh_url] as? String
    let stargazers_count = json?[Keys.stargazers_count] as? NSNumber
    let allow_merge_commit = json?[Keys.allow_merge_commit] as? Bool
    let issue_comment_url = json?[Keys.issue_comment_url] as? String
    let languages_url = json?[Keys.languages_url] as? String
    let branches_url = json?[Keys.branches_url] as? String
    let milestones_url = json?[Keys.milestones_url] as? String
    let assignees_url = json?[Keys.assignees_url] as? String
    let collaborators_url = json?[Keys.collaborators_url] as? String
    let has_issues = json?[Keys.has_issues] as? Bool
    let network_count = json?[Keys.network_count] as? NSNumber
    let archive_url = json?[Keys.archive_url] as? String
    let created_at = json?[Keys.created_at] as? String
    let compare_url = json?[Keys.compare_url] as? String
    let open_issues_count = json?[Keys.open_issues_count] as? NSNumber
    let labels_url = json?[Keys.labels_url] as? String
    let forks_count = json?[Keys.forks_count] as? NSNumber
    let events_url = json?[Keys.events_url] as? String
    let blobs_url = json?[Keys.blobs_url] as? String
    let has_downloads = json?[Keys.has_downloads] as? Bool
    let svn_url = json?[Keys.svn_url] as? String
    let forks_url = json?[Keys.forks_url] as? String
    let sourceJSON = json?[Keys.source] as? [String: Any]
    let source = Repository(json: sourceJSON)
    guard let private_ = json?[Keys.private_] as? Bool else { return nil }
    let releases_url = json?[Keys.releases_url] as? String
    let language = json?[Keys.language] as? String
    let pushed_at = json?[Keys.pushed_at] as? String
    let contents_url = json?[Keys.contents_url] as? String
    let statuses_url = json?[Keys.statuses_url] as? String
    let parentJSON = json?[Keys.parent] as? [String: Any]
    let parent = Repository(json: parentJSON)
    guard let ownerJSON = json?[Keys.owner] as? [String: Any] else { return nil }
    guard let owner = User(json: ownerJSON) else { return nil }
    let allow_rebase_merge = json?[Keys.allow_rebase_merge] as? Bool
    let git_refs_url = json?[Keys.git_refs_url] as? String
    let stargazers_url = json?[Keys.stargazers_url] as? String
    guard let name = json?[Keys.name] as? String else { return nil }
    let topics = json?[Keys.topics] as? [String]
    let updated_at = json?[Keys.updated_at] as? String
    let subscription_url = json?[Keys.subscription_url] as? String
    let contributors_url = json?[Keys.contributors_url] as? String
    let trees_url = json?[Keys.trees_url] as? String
    let keys_url = json?[Keys.keys_url] as? String
    let has_wiki = json?[Keys.has_wiki] as? Bool
    let git_commits_url = json?[Keys.git_commits_url] as? String
    let commits_url = json?[Keys.commits_url] as? String
    let watchers_count = json?[Keys.watchers_count] as? NSNumber
    let organizationJSON = json?[Keys.organization] as? [String: Any]
    let organization = Organization(json: organizationJSON)
    let deployments_url = json?[Keys.deployments_url] as? String
    let permissionsJSON = json?[Keys.permissions] as? [String: Any]
    let permissions = Permission(json: permissionsJSON)
    let merges_url = json?[Keys.merges_url] as? String
    self.init(
      pulls_url: pulls_url,
      subscribers_url: subscribers_url,
      tags_url: tags_url,
      clone_url: clone_url,
      git_url: git_url,
      size: size,
      git_tags_url: git_tags_url,
      subscribers_count: subscribers_count,
      id: id,
      default_branch: default_branch,
      issue_events_url: issue_events_url,
      mirror_url: mirror_url,
      has_pages: has_pages,
      downloads_url: downloads_url,
      comments_url: comments_url,
      homepage: homepage,
      teams_url: teams_url,
      url: url,
      allow_squash_merge: allow_squash_merge,
      hooks_url: hooks_url,
      html_url: html_url,
      issues_url: issues_url,
      full_name: full_name,
      fork: fork,
      description: description,
      notifications_url: notifications_url,
      ssh_url: ssh_url,
      stargazers_count: stargazers_count,
      allow_merge_commit: allow_merge_commit,
      issue_comment_url: issue_comment_url,
      languages_url: languages_url,
      branches_url: branches_url,
      milestones_url: milestones_url,
      assignees_url: assignees_url,
      collaborators_url: collaborators_url,
      has_issues: has_issues,
      network_count: network_count,
      archive_url: archive_url,
      created_at: created_at,
      compare_url: compare_url,
      open_issues_count: open_issues_count,
      labels_url: labels_url,
      forks_count: forks_count,
      events_url: events_url,
      blobs_url: blobs_url,
      has_downloads: has_downloads,
      svn_url: svn_url,
      forks_url: forks_url,
      source: source,
      private_: private_,
      releases_url: releases_url,
      language: language,
      pushed_at: pushed_at,
      contents_url: contents_url,
      statuses_url: statuses_url,
      parent: parent,
      owner: owner,
      allow_rebase_merge: allow_rebase_merge,
      git_refs_url: git_refs_url,
      stargazers_url: stargazers_url,
      name: name,
      topics: topics,
      updated_at: updated_at,
      subscription_url: subscription_url,
      contributors_url: contributors_url,
      trees_url: trees_url,
      keys_url: keys_url,
      has_wiki: has_wiki,
      git_commits_url: git_commits_url,
      commits_url: commits_url,
      watchers_count: watchers_count,
      organization: organization,
      deployments_url: deployments_url,
      permissions: permissions,
      merges_url: merges_url
    )
  }
  init(
    pulls_url: String?,
    subscribers_url: String?,
    tags_url: String?,
    clone_url: String?,
    git_url: String?,
    size: NSNumber?,
    git_tags_url: String?,
    subscribers_count: NSNumber?,
    id: NSNumber,
    default_branch: String?,
    issue_events_url: String?,
    mirror_url: String?,
    has_pages: Bool?,
    downloads_url: String?,
    comments_url: String?,
    homepage: String?,
    teams_url: String?,
    url: String,
    allow_squash_merge: Bool?,
    hooks_url: String?,
    html_url: String,
    issues_url: String?,
    full_name: String,
    fork: Bool,
    description: String,
    notifications_url: String?,
    ssh_url: String?,
    stargazers_count: NSNumber?,
    allow_merge_commit: Bool?,
    issue_comment_url: String?,
    languages_url: String?,
    branches_url: String?,
    milestones_url: String?,
    assignees_url: String?,
    collaborators_url: String?,
    has_issues: Bool?,
    network_count: NSNumber?,
    archive_url: String?,
    created_at: String?,
    compare_url: String?,
    open_issues_count: NSNumber?,
    labels_url: String?,
    forks_count: NSNumber?,
    events_url: String?,
    blobs_url: String?,
    has_downloads: Bool?,
    svn_url: String?,
    forks_url: String?,
    source: Repository?,
    private_: Bool,
    releases_url: String?,
    language: String?,
    pushed_at: String?,
    contents_url: String?,
    statuses_url: String?,
    parent: Repository?,
    owner: User,
    allow_rebase_merge: Bool?,
    git_refs_url: String?,
    stargazers_url: String?,
    name: String,
    topics: [String]?,
    updated_at: String?,
    subscription_url: String?,
    contributors_url: String?,
    trees_url: String?,
    keys_url: String?,
    has_wiki: Bool?,
    git_commits_url: String?,
    commits_url: String?,
    watchers_count: NSNumber?,
    organization: Organization?,
    deployments_url: String?,
    permissions: Permission?,
    merges_url: String?
    ) {
    self.pulls_url = pulls_url
    self.subscribers_url = subscribers_url
    self.tags_url = tags_url
    self.clone_url = clone_url
    self.git_url = git_url
    self.size = size
    self.git_tags_url = git_tags_url
    self.subscribers_count = subscribers_count
    self.id = id
    self.default_branch = default_branch
    self.issue_events_url = issue_events_url
    self.mirror_url = mirror_url
    self.has_pages = has_pages
    self.downloads_url = downloads_url
    self.comments_url = comments_url
    self.homepage = homepage
    self.teams_url = teams_url
    self.url = url
    self.allow_squash_merge = allow_squash_merge
    self.hooks_url = hooks_url
    self.html_url = html_url
    self.issues_url = issues_url
    self.full_name = full_name
    self.fork = fork
    self.description = description
    self.notifications_url = notifications_url
    self.ssh_url = ssh_url
    self.stargazers_count = stargazers_count
    self.allow_merge_commit = allow_merge_commit
    self.issue_comment_url = issue_comment_url
    self.languages_url = languages_url
    self.branches_url = branches_url
    self.milestones_url = milestones_url
    self.assignees_url = assignees_url
    self.collaborators_url = collaborators_url
    self.has_issues = has_issues
    self.network_count = network_count
    self.archive_url = archive_url
    self.created_at = created_at
    self.compare_url = compare_url
    self.open_issues_count = open_issues_count
    self.labels_url = labels_url
    self.forks_count = forks_count
    self.events_url = events_url
    self.blobs_url = blobs_url
    self.has_downloads = has_downloads
    self.svn_url = svn_url
    self.forks_url = forks_url
    self.source = source
    self.private_ = private_
    self.releases_url = releases_url
    self.language = language
    self.pushed_at = pushed_at
    self.contents_url = contents_url
    self.statuses_url = statuses_url
    self.parent = parent
    self.owner = owner
    self.allow_rebase_merge = allow_rebase_merge
    self.git_refs_url = git_refs_url
    self.stargazers_url = stargazers_url
    self.name = name
    self.topics = topics
    self.updated_at = updated_at
    self.subscription_url = subscription_url
    self.contributors_url = contributors_url
    self.trees_url = trees_url
    self.keys_url = keys_url
    self.has_wiki = has_wiki
    self.git_commits_url = git_commits_url
    self.commits_url = commits_url
    self.watchers_count = watchers_count
    self.organization = organization
    self.deployments_url = deployments_url
    self.permissions = permissions
    self.merges_url = merges_url
  }
  convenience init?(coder aDecoder: NSCoder) {
    let pulls_url = aDecoder.decodeObject(forKey: Keys.pulls_url) as? String
    let subscribers_url = aDecoder.decodeObject(forKey: Keys.subscribers_url) as? String
    let tags_url = aDecoder.decodeObject(forKey: Keys.tags_url) as? String
    let clone_url = aDecoder.decodeObject(forKey: Keys.clone_url) as? String
    let git_url = aDecoder.decodeObject(forKey: Keys.git_url) as? String
    let size = aDecoder.decodeObject(forKey: Keys.size) as? NSNumber
    let git_tags_url = aDecoder.decodeObject(forKey: Keys.git_tags_url) as? String
    let subscribers_count = aDecoder.decodeObject(forKey: Keys.subscribers_count) as? NSNumber
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber else { return nil }
    let default_branch = aDecoder.decodeObject(forKey: Keys.default_branch) as? String
    let issue_events_url = aDecoder.decodeObject(forKey: Keys.issue_events_url) as? String
    let mirror_url = aDecoder.decodeObject(forKey: Keys.mirror_url) as? String
    let has_pages = aDecoder.decodeBool(forKey: Keys.has_pages)
    let downloads_url = aDecoder.decodeObject(forKey: Keys.downloads_url) as? String
    let comments_url = aDecoder.decodeObject(forKey: Keys.comments_url) as? String
    let homepage = aDecoder.decodeObject(forKey: Keys.homepage) as? String
    let teams_url = aDecoder.decodeObject(forKey: Keys.teams_url) as? String
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    let allow_squash_merge = aDecoder.decodeBool(forKey: Keys.allow_squash_merge)
    let hooks_url = aDecoder.decodeObject(forKey: Keys.hooks_url) as? String
    guard let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String else { return nil }
    let issues_url = aDecoder.decodeObject(forKey: Keys.issues_url) as? String
    guard let full_name = aDecoder.decodeObject(forKey: Keys.full_name) as? String else { return nil }
    let fork = aDecoder.decodeBool(forKey: Keys.fork)
    guard let description = aDecoder.decodeObject(forKey: Keys.description) as? String else { return nil }
    let notifications_url = aDecoder.decodeObject(forKey: Keys.notifications_url) as? String
    let ssh_url = aDecoder.decodeObject(forKey: Keys.ssh_url) as? String
    let stargazers_count = aDecoder.decodeObject(forKey: Keys.stargazers_count) as? NSNumber
    let allow_merge_commit = aDecoder.decodeBool(forKey: Keys.allow_merge_commit)
    let issue_comment_url = aDecoder.decodeObject(forKey: Keys.issue_comment_url) as? String
    let languages_url = aDecoder.decodeObject(forKey: Keys.languages_url) as? String
    let branches_url = aDecoder.decodeObject(forKey: Keys.branches_url) as? String
    let milestones_url = aDecoder.decodeObject(forKey: Keys.milestones_url) as? String
    let assignees_url = aDecoder.decodeObject(forKey: Keys.assignees_url) as? String
    let collaborators_url = aDecoder.decodeObject(forKey: Keys.collaborators_url) as? String
    let has_issues = aDecoder.decodeBool(forKey: Keys.has_issues)
    let network_count = aDecoder.decodeObject(forKey: Keys.network_count) as? NSNumber
    let archive_url = aDecoder.decodeObject(forKey: Keys.archive_url) as? String
    let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String
    let compare_url = aDecoder.decodeObject(forKey: Keys.compare_url) as? String
    let open_issues_count = aDecoder.decodeObject(forKey: Keys.open_issues_count) as? NSNumber
    let labels_url = aDecoder.decodeObject(forKey: Keys.labels_url) as? String
    let forks_count = aDecoder.decodeObject(forKey: Keys.forks_count) as? NSNumber
    let events_url = aDecoder.decodeObject(forKey: Keys.events_url) as? String
    let blobs_url = aDecoder.decodeObject(forKey: Keys.blobs_url) as? String
    let has_downloads = aDecoder.decodeBool(forKey: Keys.has_downloads)
    let svn_url = aDecoder.decodeObject(forKey: Keys.svn_url) as? String
    let forks_url = aDecoder.decodeObject(forKey: Keys.forks_url) as? String
    let source = aDecoder.decodeObject(forKey: Keys.source) as? Repository
    let private_ = aDecoder.decodeBool(forKey: Keys.private_)
    let releases_url = aDecoder.decodeObject(forKey: Keys.releases_url) as? String
    let language = aDecoder.decodeObject(forKey: Keys.language) as? String
    let pushed_at = aDecoder.decodeObject(forKey: Keys.pushed_at) as? String
    let contents_url = aDecoder.decodeObject(forKey: Keys.contents_url) as? String
    let statuses_url = aDecoder.decodeObject(forKey: Keys.statuses_url) as? String
    let parent = aDecoder.decodeObject(forKey: Keys.parent) as? Repository
    guard let owner = aDecoder.decodeObject(forKey: Keys.owner) as? User else { return nil }
    let allow_rebase_merge = aDecoder.decodeBool(forKey: Keys.allow_rebase_merge)
    let git_refs_url = aDecoder.decodeObject(forKey: Keys.git_refs_url) as? String
    let stargazers_url = aDecoder.decodeObject(forKey: Keys.stargazers_url) as? String
    guard let name = aDecoder.decodeObject(forKey: Keys.name) as? String else { return nil }
    let topics = aDecoder.decodeObject(forKey: Keys.topics) as? [String]
    let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String
    let subscription_url = aDecoder.decodeObject(forKey: Keys.subscription_url) as? String
    let contributors_url = aDecoder.decodeObject(forKey: Keys.contributors_url) as? String
    let trees_url = aDecoder.decodeObject(forKey: Keys.trees_url) as? String
    let keys_url = aDecoder.decodeObject(forKey: Keys.keys_url) as? String
    let has_wiki = aDecoder.decodeBool(forKey: Keys.has_wiki)
    let git_commits_url = aDecoder.decodeObject(forKey: Keys.git_commits_url) as? String
    let commits_url = aDecoder.decodeObject(forKey: Keys.commits_url) as? String
    let watchers_count = aDecoder.decodeObject(forKey: Keys.watchers_count) as? NSNumber
    let organization = aDecoder.decodeObject(forKey: Keys.organization) as? Organization
    let deployments_url = aDecoder.decodeObject(forKey: Keys.deployments_url) as? String
    let permissions = aDecoder.decodeObject(forKey: Keys.permissions) as? Permission
    let merges_url = aDecoder.decodeObject(forKey: Keys.merges_url) as? String
    self.init(
      pulls_url: pulls_url,
      subscribers_url: subscribers_url,
      tags_url: tags_url,
      clone_url: clone_url,
      git_url: git_url,
      size: size,
      git_tags_url: git_tags_url,
      subscribers_count: subscribers_count,
      id: id,
      default_branch: default_branch,
      issue_events_url: issue_events_url,
      mirror_url: mirror_url,
      has_pages: has_pages,
      downloads_url: downloads_url,
      comments_url: comments_url,
      homepage: homepage,
      teams_url: teams_url,
      url: url,
      allow_squash_merge: allow_squash_merge,
      hooks_url: hooks_url,
      html_url: html_url,
      issues_url: issues_url,
      full_name: full_name,
      fork: fork,
      description: description,
      notifications_url: notifications_url,
      ssh_url: ssh_url,
      stargazers_count: stargazers_count,
      allow_merge_commit: allow_merge_commit,
      issue_comment_url: issue_comment_url,
      languages_url: languages_url,
      branches_url: branches_url,
      milestones_url: milestones_url,
      assignees_url: assignees_url,
      collaborators_url: collaborators_url,
      has_issues: has_issues,
      network_count: network_count,
      archive_url: archive_url,
      created_at: created_at,
      compare_url: compare_url,
      open_issues_count: open_issues_count,
      labels_url: labels_url,
      forks_count: forks_count,
      events_url: events_url,
      blobs_url: blobs_url,
      has_downloads: has_downloads,
      svn_url: svn_url,
      forks_url: forks_url,
      source: source,
      private_: private_,
      releases_url: releases_url,
      language: language,
      pushed_at: pushed_at,
      contents_url: contents_url,
      statuses_url: statuses_url,
      parent: parent,
      owner: owner,
      allow_rebase_merge: allow_rebase_merge,
      git_refs_url: git_refs_url,
      stargazers_url: stargazers_url,
      name: name,
      topics: topics,
      updated_at: updated_at,
      subscription_url: subscription_url,
      contributors_url: contributors_url,
      trees_url: trees_url,
      keys_url: keys_url,
      has_wiki: has_wiki,
      git_commits_url: git_commits_url,
      commits_url: commits_url,
      watchers_count: watchers_count,
      organization: organization,
      deployments_url: deployments_url,
      permissions: permissions,
      merges_url: merges_url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(pulls_url, forKey: Keys.pulls_url)
    aCoder.encode(subscribers_url, forKey: Keys.subscribers_url)
    aCoder.encode(tags_url, forKey: Keys.tags_url)
    aCoder.encode(clone_url, forKey: Keys.clone_url)
    aCoder.encode(git_url, forKey: Keys.git_url)
    aCoder.encode(size, forKey: Keys.size)
    aCoder.encode(git_tags_url, forKey: Keys.git_tags_url)
    aCoder.encode(subscribers_count, forKey: Keys.subscribers_count)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(default_branch, forKey: Keys.default_branch)
    aCoder.encode(issue_events_url, forKey: Keys.issue_events_url)
    aCoder.encode(mirror_url, forKey: Keys.mirror_url)
    aCoder.encode(has_pages, forKey: Keys.has_pages)
    aCoder.encode(downloads_url, forKey: Keys.downloads_url)
    aCoder.encode(comments_url, forKey: Keys.comments_url)
    aCoder.encode(homepage, forKey: Keys.homepage)
    aCoder.encode(teams_url, forKey: Keys.teams_url)
    aCoder.encode(url, forKey: Keys.url)
    aCoder.encode(allow_squash_merge, forKey: Keys.allow_squash_merge)
    aCoder.encode(hooks_url, forKey: Keys.hooks_url)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(issues_url, forKey: Keys.issues_url)
    aCoder.encode(full_name, forKey: Keys.full_name)
    aCoder.encode(fork, forKey: Keys.fork)
    aCoder.encode(description, forKey: Keys.description)
    aCoder.encode(notifications_url, forKey: Keys.notifications_url)
    aCoder.encode(ssh_url, forKey: Keys.ssh_url)
    aCoder.encode(stargazers_count, forKey: Keys.stargazers_count)
    aCoder.encode(allow_merge_commit, forKey: Keys.allow_merge_commit)
    aCoder.encode(issue_comment_url, forKey: Keys.issue_comment_url)
    aCoder.encode(languages_url, forKey: Keys.languages_url)
    aCoder.encode(branches_url, forKey: Keys.branches_url)
    aCoder.encode(milestones_url, forKey: Keys.milestones_url)
    aCoder.encode(assignees_url, forKey: Keys.assignees_url)
    aCoder.encode(collaborators_url, forKey: Keys.collaborators_url)
    aCoder.encode(has_issues, forKey: Keys.has_issues)
    aCoder.encode(network_count, forKey: Keys.network_count)
    aCoder.encode(archive_url, forKey: Keys.archive_url)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(compare_url, forKey: Keys.compare_url)
    aCoder.encode(open_issues_count, forKey: Keys.open_issues_count)
    aCoder.encode(labels_url, forKey: Keys.labels_url)
    aCoder.encode(forks_count, forKey: Keys.forks_count)
    aCoder.encode(events_url, forKey: Keys.events_url)
    aCoder.encode(blobs_url, forKey: Keys.blobs_url)
    aCoder.encode(has_downloads, forKey: Keys.has_downloads)
    aCoder.encode(svn_url, forKey: Keys.svn_url)
    aCoder.encode(forks_url, forKey: Keys.forks_url)
    aCoder.encode(source, forKey: Keys.source)
    aCoder.encode(private_, forKey: Keys.private_)
    aCoder.encode(releases_url, forKey: Keys.releases_url)
    aCoder.encode(language, forKey: Keys.language)
    aCoder.encode(pushed_at, forKey: Keys.pushed_at)
    aCoder.encode(contents_url, forKey: Keys.contents_url)
    aCoder.encode(statuses_url, forKey: Keys.statuses_url)
    aCoder.encode(parent, forKey: Keys.parent)
    aCoder.encode(owner, forKey: Keys.owner)
    aCoder.encode(allow_rebase_merge, forKey: Keys.allow_rebase_merge)
    aCoder.encode(git_refs_url, forKey: Keys.git_refs_url)
    aCoder.encode(stargazers_url, forKey: Keys.stargazers_url)
    aCoder.encode(name, forKey: Keys.name)
    aCoder.encode(topics, forKey: Keys.topics)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(subscription_url, forKey: Keys.subscription_url)
    aCoder.encode(contributors_url, forKey: Keys.contributors_url)
    aCoder.encode(trees_url, forKey: Keys.trees_url)
    aCoder.encode(keys_url, forKey: Keys.keys_url)
    aCoder.encode(has_wiki, forKey: Keys.has_wiki)
    aCoder.encode(git_commits_url, forKey: Keys.git_commits_url)
    aCoder.encode(commits_url, forKey: Keys.commits_url)
    aCoder.encode(watchers_count, forKey: Keys.watchers_count)
    aCoder.encode(organization, forKey: Keys.organization)
    aCoder.encode(deployments_url, forKey: Keys.deployments_url)
    aCoder.encode(permissions, forKey: Keys.permissions)
    aCoder.encode(merges_url, forKey: Keys.merges_url)
  }
}