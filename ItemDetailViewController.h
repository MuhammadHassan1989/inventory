//
//  ItemDetailViewController.h
//  Inventory
//
//  Created by Kenton Newby on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Possession;

@interface ItemDetailViewController : UIViewController
{

    IBOutlet UITextField *nameField;
    IBOutlet UITextField *serialNumberField;
    IBOutlet UITextField *valueField;
    IBOutlet UILabel *dateLabel;
    
    Possession *possession;
}

@property (nonatomic, retain) Possession *possession;

@end
