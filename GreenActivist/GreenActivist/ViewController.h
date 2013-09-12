//
//  ViewController.h
//  GreenActivist
//
//  Created by GoTouch on 09/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelName;
- (IBAction)cambiarAnimacion:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property bool showTurtle;
@end
