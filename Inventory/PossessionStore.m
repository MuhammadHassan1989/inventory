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

- (void)removePossession:(Possession *)p
{
    [allPossessions removeObjectIdenticalTo:p];
}

- (void)movePossessionAtIndex:(int)from toIndex:(int)to
{   
    if (from == to) {
        return;
    }
    
    // get pointer to object being removed
    Possession *p = [[self allPossessions] objectAtIndex:from];
    
    // retain it...(retain count of p = 2)
    [p retain];
    
    // remove p from array, it is automatically sent release...(retain count o fp = 1)
    [allPossessions removeObjectAtIndex:from];
    
    // insert p into array at the new location, retained by array (retain count of p = 2)
    [allPossessions insertObject:p atIndex:to];
    
    // release p (retain count = 1, only owner is now array)
    [p release];
}

@end
