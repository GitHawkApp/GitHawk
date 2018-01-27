//
//  SetupMockNetworkEnvironment.h
//  Freetime
//
//  Created by Ryan Nystrom on 1/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

#import <Foundation/Foundation.h>

// returns NO when no mock environment setup
extern BOOL SetupMockNetworkEnvironment(NSURLSessionConfiguration *config);
