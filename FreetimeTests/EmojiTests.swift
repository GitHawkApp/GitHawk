//
//  EmojiTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 6/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

final class EmojiTests: XCTestCase {

    func test_replacingEmoji() {
        let text = "Lorem ipsum dolor sit amet, mei no ignota commodo, dolorem luptatum in qui. Iusto regione inermis ea quo, te eos consul utroque scaevola. Ea per possim salutandi. At tota aperiam ius, facilisi recusabo accommodare vel cu. Cibo omnium utamur et pro, :apple: temporibus eu cum.\nCum paulo definitionem at, vel atqui tempor ad. Ex minimum percipit erroribus vis, qui erroribus persequeris te, et augue :chart_with_upwards_trend: mediocritatem eum. Et mei cibo dicta, vis reque :dancers: at, suas mutat corrumpit eos eu. Sint eruditi eos ei, ad pri esse omnes, dolorem blandit voluptatibus an ius.\nOption eligendi id eum, ne sea porro :small_red_triangle_down: assueverit, sed modo diam in. Id vim eripuit intellegebat, ad quo consul constituto, at vix natum interpretaris. Id his tritani vituperata, ea minim quidam aliquip vis, animal pertinacia ad sit. Mel impedit interpretaris ne, iusto oblique platonem vel at, duo illud populo adversarium in. Ius ex quas rebum luptatum. Quot vero audire in qui.\nEx vix solet dolorem deleniti, mea semper quodsi cu, sit deseruisse quaerendum ne. Per :eight_spoked_asterisk: adhuc altera at. Ad sit debet disputando. Vide indoctum sea ne. Vocent neglegentur ei mea, noster :cop: eum cu, an tantas dictas eripuit mea.\nAt exerci explicari suscipiantur mea, agam paulo cum in. Veri deseruisse est ei, per cu audire sapientem suavitate. Sea cu adhuc facete, pri facilis apeirian ad. Agam postea oblique duo in, et laudem suscipit his, eos cu tale quodsi appetere. Pri cu malis doctus, id vel partem diceret.\nNam ut congue discere salutatus, ea amet diam eam, ut singulis legendos omittantur sea. :smile: aliquam pertinacia duo an. No nam quidam prompta, labore noluisse sed te. Singulis repudiandae sed an, no sit percipit philosophia definitionem, id has :busts_in_silhouette: option. Ex quo fabulas signiferumque. At usu quas movet alterum, populo noluisse et pri.\nDico alterum probatus pro et, etiam accumsan vim in. Quo te nonumy euripidis, mel no diam case iriure. Everti timeam qui ut, id nostro sadipscing pri. Usu tamquam voluptua at, blandit vituperata mea cu. Ad reque definitiones vis, recusabo periculis vel an, nominavi copiosae nec cu.\nVocibus mediocrem ea eos. Vel ea novum mediocritatem, id sed consul perpetua delicatissimi, mollis facilisi sed ut. Ubique deseruisse ne duo. Id sit recusabo gloriatur. An ius vidit suscipit honestatis.\nEssent feugait vel in. Putent pertinacia eloquentiam sit ne, pri veri admodum in. At sed epicuri repudiare argumentum. Velit dolore iudicabit pri ne, in prima adhuc eligendi vis, in sit verear tibique iudicabit. In vel labore doctus ancillae, id iudico prodesset duo.\nVel cu soleat eripuit principes, ea :smile: agam harum dolorum, an mel dicant graeci :vertical_traffic_light:. Ad per iudico eirmod, assum omnium an eos. Mea tale epicuri appellantur in, placerat dissentias et est, et ius oblique electram. Et vis nullam verear nominati, meliore periculis constituam in per, eos ea elit vitae."
        measure {
            for _ in 0..<10 {
                let _ = replaceGithubEmojiRegex(string: text)
            }
        }
    }
    
}
