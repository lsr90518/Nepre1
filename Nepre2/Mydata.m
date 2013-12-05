//
//  Mydata.m
//  Nepre2
//
//  Created by Lsr on 12/4/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "Mydata.h"

@implementation Mydata
+ (Mydata *)sharedSingleton
{
    static Mydata *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[Mydata alloc] init];
        
        return sharedSingleton;
    }
}

@end
