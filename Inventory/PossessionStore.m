//
//  PosessionStore.m
//  Inventory
//
//  Created by Kenton Newby on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PossessionStore.h"
#import "Possession.h"

// create a global static variable to hole the instance of PossessionStore where the class can access it
static PossessionStore *defaultStore = nil;

@implementation PossessionStore

+ (PossessionStore *)defaultStore
{
  if (!defaultStore)
  {
      // create the singleton defaultStore
      defaultStore = [[super allocWithZone:NULL] init];
  }
    return defaultStore;
}

// Prevent creation of additional instances
+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    // If we already have an instance of PossessionStore...
    if (defaultStore) {
        return defaultStore;    
    }
    
    self = [super init];
    if (self) {
        allPossessions = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)retain
{
    return self;
}

- (oneway void)release
{
    // do nothing
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (NSArray *)allPossessions
{
    return allPossessions;
}

- (Possession *)createPossession
{
    Possession *p = [Possession randomPossession];
    [allPossessions addObject:p];
    return p;
}

@end
