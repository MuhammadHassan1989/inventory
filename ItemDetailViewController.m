//
//  ItemDetailViewController.m
//  Inventory
//
//  Created by Kenton Newby on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"

@implementation ItemDetailViewController

@synthesize possession;

- (void)viewDidLoad 
{   
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    [nameField setText:[possession possessionName]];
    [serialNumberField setText:[possession serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", [possession valueInDollars]]];
    
    // create a date formatter to handle the date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] autorelease];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateLabel setText:[dateFormatter stringFromDate:[possession dateCreated]]];
    
    // change the navigation item to display the name of the possession
    [[self navigationItem] setTitle:[possession possessionName]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear the first responder
    [[self view] endEditing:YES];
    
    // "Save" changes to possession
    [possession setPossessionName:[nameField text]];
    [possession setSerialNumber:[serialNumberField text]];
    [possession setValueInDollars:[[valueField text] intValue]];
}

- (void)dealloc 
{
    [possession release];
    [nameField release];
    [serialNumberField release];
    [valueField release];
    [dateLabel release];
    [super dealloc];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    
    [nameField release];
    nameField = nil;
    
    [serialNumberField release];
    serialNumberField = nil;
    
    [valueField release];
    valueField = nil;
    
    [dateLabel release];
    dateLabel = nil;
}
@end
