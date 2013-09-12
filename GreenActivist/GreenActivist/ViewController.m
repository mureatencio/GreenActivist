//
//  ViewController.m
//  GreenActivist
//
//  Created by GoTouch on 09/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize avatar, showTurtle;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    /* Prueba Parse*/
    /*
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
    */
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.labelName.text = [prefs stringForKey:@"UserName"];
    
    NSArray *animacionMono = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"frog1.png"],
                              [UIImage imageNamed:@"frog2.png"],
                              [UIImage imageNamed:@"frog3.png"],
                              [UIImage imageNamed:@"frog4.png"],
                              [UIImage imageNamed:@"frog5.png"],
                              nil];
    
    NSArray *animacionTurtle = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"turtle1.png"],
                             [UIImage imageNamed:@"turtle2.png"],
                             [UIImage imageNamed:@"turtle3.png"],
                            [UIImage imageNamed:@"turtle4.png"],                              nil];
    
    if(self.showTurtle){
    avatar.animationImages = animacionMono;
    avatar.animationDuration = 1.0;
    avatar.animationRepeatCount = 0;
    }else{
        avatar.animationImages = animacionTurtle;
        avatar.animationDuration = 1.0;
        avatar.animationRepeatCount = 0;
    }
    [avatar startAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cambiarAnimacion:(id)sender {
    if (self.showTurtle) {
        self.showTurtle = false;
        [self.avatar stopAnimating];
        NSArray *animacionMono = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"frog1.png"],
                                  [UIImage imageNamed:@"frog2.png"],
                                  [UIImage imageNamed:@"frog3.png"],
                                  [UIImage imageNamed:@"frog4.png"],
                                  [UIImage imageNamed:@"frog5.png"],
                                  nil];
        avatar.animationImages = animacionMono;
        avatar.animationDuration = 1.0;
        avatar.animationRepeatCount = 0;
        [self.avatar startAnimating];
        
    }else{
        self.showTurtle = true;
        [self.avatar stopAnimating];
        NSArray *animacionTurtle = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"turtle1.png"],
                                    [UIImage imageNamed:@"turtle2.png"],
                                    [UIImage imageNamed:@"turtle3.png"],
                                    [UIImage imageNamed:@"turtle4.png"],                              nil];
        avatar.animationImages = animacionTurtle;
        avatar.animationDuration = 1.0;
        avatar.animationRepeatCount = 0;
        [self.avatar startAnimating];
    }
}
@end
