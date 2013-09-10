//
//  DenunciasController.h
//  GreenActivist
//
//  Created by Edward Umaña Williams on 10/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DenunciasController : UIViewController  <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *myTableView;
    NSArray *objectArray;
}

- (IBAction)loadDataButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonLoad;

@end
