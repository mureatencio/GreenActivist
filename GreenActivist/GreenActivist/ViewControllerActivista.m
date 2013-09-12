//
//  ViewControllerActivista.m
//  GreenActivist
//
//  Created by GoTouch on 11/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import "ViewControllerActivista.h"

@interface ViewControllerActivista ()

@end

@implementation ViewControllerActivista

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)like:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you!!"
                                                    message:@"Your colaborating to preserve the environment!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
