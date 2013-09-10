//
//  IdeasController
//  GreenActivist
//
//  Created by Edward Umaña Williams on 10/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import "IdeasController.h"

@interface IdeasController ()

@end

@implementation IdeasController
@synthesize buttonLoad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
}

- (IBAction)loadDataButton:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Idea"];
    [query whereKey:@"titulo" notEqualTo:@"1231f34"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //  NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            objectArray = [[NSArray alloc] initWithArray:objects];
            
            [myTableView reloadData];
            
            for (PFObject *object in objects) {
                NSLog(@"%@", object);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return objectArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[objectArray objectAtIndex:indexPath.row] objectForKey:@"titulo"];
    
    
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
