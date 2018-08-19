//
//  Action.js
//  FreetimeAction Extension
//
//  Created by Florent Vilmart on 2018-08-19.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

var Action = function() {};

Action.prototype = {
    
    run: function(arguments) {
        arguments.completionFunction({ "location" : window.location.href })
    },
    
    finalize: function(arguments) {
        if (arguments["error"]) {
            alert(arguments["error"])
            return
        }

        if (arguments["location"]) {
            window.location.href = arguments["location"]
        }
    }
    
};
    
var ExtensionPreprocessingJS = new Action
