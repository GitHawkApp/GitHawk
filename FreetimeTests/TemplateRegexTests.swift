//
//  TemplateRegexTests.swift
//  FreetimeTests
//
//  Created by Ehud Adler on 11/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class TemplateRegexTests: XCTestCase {


    func test_createTemplate() {


        let file = """
        -----
        name: foo
        about: bar
        -----
        Lorem ipsum dolor sit amet, mei no ignota commodo, dolorem luptatum in qui. Iusto regione inermis ea quo, te eos consul utroque scaevola. Ea per possim salutandi. At tota aperiam ius, facilisi recusabo accommodare vel cu. Cibo omnium utamur et pro, :apple: temporibus eu cum.\nCum paulo definitionem at, vel atqui tempor ad. Ex minimum percipit erroribus vis, qui erroribus persequeris te, et augue :chart_with_upwards_trend: mediocritatem eum. Et mei cibo dicta, vis reque :dancers: at, suas mutat corrumpit eos eu. Sint eruditi eos ei, ad pri esse omnes, dolorem blandit voluptatibus an ius.\nOption eligendi id eum, ne sea porro :small_red_triangle_down: assueverit, sed modo diam in. Id vim eripuit intellegebat, ad quo consul constituto, at vix natum interpretaris. Id his tritani vituperata, ea minim quidam aliquip vis, animal pertinacia ad sit. Mel impedit
        """

        let validTemplate = IssueTemplate(title: "foo", template: "Lorem ipsum dolor sit amet, mei no ignota commodo, dolorem luptatum in qui. Iusto regione inermis ea quo, te eos consul utroque scaevola. Ea per possim salutandi. At tota aperiam ius, facilisi recusabo accommodare vel cu. Cibo omnium utamur et pro, :apple: temporibus eu cum.\nCum paulo definitionem at, vel atqui tempor ad. Ex minimum percipit erroribus vis, qui erroribus persequeris te, et augue :chart_with_upwards_trend: mediocritatem eum. Et mei cibo dicta, vis reque :dancers: at, suas mutat corrumpit eos eu. Sint eruditi eos ei, ad pri esse omnes, dolorem blandit voluptatibus an ius.\nOption eligendi id eum, ne sea porro :small_red_triangle_down: assueverit, sed modo diam in. Id vim eripuit intellegebat, ad quo consul constituto, at vix natum interpretaris. Id his tritani vituperata, ea minim quidam aliquip vis, animal pertinacia ad sit. Mel impedit")

        let repo = RepositoryDetails(
            owner: "GitHawkApp",
            name: "GitHawk",
            defaultBranch: "master",
            hasIssuesEnabled: true
        )

        let client = GithubClient()

        client.createTemplate(repo: repo, filename: "", testingFile: file, completion: { (result) in
            switch result {
            case .success(let template):
                XCTAssertEqual(template.title, validTemplate.title)
                XCTAssertEqual(template.template, validTemplate.template)

            case .error(let error):
                XCTFail(error.debugDescription)
            }
        })
    }
    func test_getNameAndDescriptionFromTemplateDetails() {
        let validStr = """
        -----
        name: foo
        about: bar
        -----
        """

        let names = validStr.matches(regex: String.getRegexForLine(after: "name"))
        let name = names.first?.trimmingCharacters(in: .whitespaces)

        let abouts = validStr.matches(regex: String.getRegexForLine(after: "about"))
        let about = abouts.first?.trimmingCharacters(in: .whitespaces)

        let nameAndDescription = IssueTemplateHelper.getNameAndDescription(fromTemplatefile: validStr)

        XCTAssertEqual(name, "foo")
        XCTAssertEqual(about, "bar")

        XCTAssertEqual(nameAndDescription.name, "foo")
        XCTAssertEqual(nameAndDescription.about, "bar")

    }

    func test_cleaningUpDetailsFromTemplate() {
        let template = """
        -----
        name: foo
        about: bar
        -----
        Lorem ipsum dolor sit amet, mei no ignota commodo, dolorem luptatum in qui. Iusto regione inermis ea quo, te eos consul utroque scaevola. Ea per possim salutandi. At tota aperiam ius, facilisi recusabo accommodare vel cu. Cibo omnium utamur et pro, :apple: temporibus eu cum.\nCum paulo definitionem at, vel atqui tempor ad. Ex minimum percipit erroribus vis, qui erroribus persequeris te, et augue :chart_with_upwards_trend: mediocritatem eum. Et mei cibo dicta, vis reque :dancers: at, suas mutat corrumpit eos eu. Sint eruditi eos ei, ad pri esse omnes, dolorem blandit voluptatibus an ius.\nOption eligendi id eum, ne sea porro :small_red_triangle_down: assueverit, sed modo diam in. Id vim eripuit intellegebat, ad quo consul constituto, at vix natum interpretaris. Id his tritani vituperata, ea minim quidam aliquip vis, animal pertinacia ad sit. Mel impedit
        """

        var cleanedFile = ""
        if let textToClean = template.matches(regex: "([-]{3,})([\\s\\S]*)([-]{3,})").first {
            if let range = template.range(of: textToClean) {
                cleanedFile = template.replacingOccurrences(
                    of: textToClean,
                    with: "",
                    options: .literal,
                    range: range
                )
            }
            cleanedFile = cleanedFile.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        XCTAssertEqual(cleanedFile, "Lorem ipsum dolor sit amet, mei no ignota commodo, dolorem luptatum in qui. Iusto regione inermis ea quo, te eos consul utroque scaevola. Ea per possim salutandi. At tota aperiam ius, facilisi recusabo accommodare vel cu. Cibo omnium utamur et pro, :apple: temporibus eu cum.\nCum paulo definitionem at, vel atqui tempor ad. Ex minimum percipit erroribus vis, qui erroribus persequeris te, et augue :chart_with_upwards_trend: mediocritatem eum. Et mei cibo dicta, vis reque :dancers: at, suas mutat corrumpit eos eu. Sint eruditi eos ei, ad pri esse omnes, dolorem blandit voluptatibus an ius.\nOption eligendi id eum, ne sea porro :small_red_triangle_down: assueverit, sed modo diam in. Id vim eripuit intellegebat, ad quo consul constituto, at vix natum interpretaris. Id his tritani vituperata, ea minim quidam aliquip vis, animal pertinacia ad sit. Mel impedit")

    }

}
