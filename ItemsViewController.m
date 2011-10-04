//
//  ItemsViewController.m
//  Inventory
//
//  Created by Kenton Newby on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "PossessionStore.h"
#import "Possession.h"

@implementation ItemsViewController

- (id)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        // create a new bar button item that will send addNewPosession: to ItemsViewController
        // set this bar button item as the right item in the navigationItem
        // release the add button object
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPossession:)];
        [[self navigationItem] setRightBarButtonItem:addButton];
        [addButton release];
        
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
        // create a new bar button item to send toggleEditingMode: to IVC
        // set this bar button item as the left item in the navigationItem
        // release the edit button object
        //UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditingMode:)];
        //[[self navigationItem] setLeftBarButtonItem:editButton];
        //[editButton release];
        
        // set the title of the navigation item
        [[self navigationItem] setTitle:@"Home Inventory"];
        
    }
    
    return self;
}

- (IBAction)addNewPossession:(id)sender
{
    [[PossessionStore defaultStore] createPossession];
    [[self tableView] reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[PossessionStore defaultStore] allPossessions] count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Check for a reusable cell first and use that if one exists
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // Create an instance of UITableViewCell with default appearance
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"] autorelease];
    }

    

    
    // Set text on the cell with the description of the nth possession
    Possession *p = [[[PossessionStore defaultStore] allPossessions] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[p description]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PossessionStore *ps = [PossessionStore defaultStore];
        NSArray *possessions = [ps allPossessions];
        Possession *p = [possessions objectAtIndex:[indexPath row]];
        [ps removePossession:p];
        
        // we also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[PossessionStore defaultStore] movePossessionAtIndex:[fromIndexPath row] 
                                                  toIndex:[toIndexPath row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create an instance of ItemDetailViewController
    ItemDetailViewController *dvc = [[[ItemDetailViewController alloc] init] autorelease];
    
    NSArray *possessions = [[PossessionStore defaultStore] allPossessions];
    
    // Give the detail view controller a pointer to the possession object in the selected row
    [dvc setPossession:[possessions objectAtIndex:[indexPath row]]];
    
    // push the *dvc onto the top of the NavigationController's stack
    [[self navigationController] pushViewController:dvc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self tableView] reloadData];
}

@end
