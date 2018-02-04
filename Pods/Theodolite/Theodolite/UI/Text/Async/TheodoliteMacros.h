//
//  TheodoliteMacros.h
//  Theodolite
//
//  Created by Oliver Rickard on 10/31/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

#ifndef TheodoliteMacros_h
#define TheodoliteMacros_h

#define TheodoliteAssertMainThread() NSAssert([NSThread currentThread].isMainThread, @"Must be called on main thread")
#define TheodoliteCAssertMainThread() NSCAssert([NSThread currentThread].isMainThread, @"Must be called on main thread")
#define TheodoliteAssertNil(value, explanation) NSAssert(value == nil, explanation)
#define TheodoliteAssertNotNil(value, explanation) NSAssert(value != nil, explanation)

#endif /* TheodoliteMacros_h */
