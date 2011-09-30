//
//  PosessionStore.h
//  Inventory
//
//  Created by Kenton Newby on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Possession;

@interface PossessionStore : NSObject
{
    NSMutableArray *allPossessions;
}

+ (PossessionStore *)defaultStore;

- (void)removePossession:(Possession *)p;
- (NSArray *)allPossessions;
- (Possession *)createPossession;
- (void)movePossessionAtIndex:(int)from toIndex:(int)to;


@end