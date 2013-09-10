//

#import "LoginViewController.h"
#import "UserDetailsViewController.h"
#import "ViewController.h"
#import <Parse/Parse.h>

@implementation LoginViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Facebook Profile";
    
    // Check if user is cached and linked to Facebook, if so, bypass login    
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:NO];
        
    }
    
}


#pragma mark - Login mehtods

/* Login to facebook method */
- (IBAction)loginButtonTouchHandler:(id)sender  {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    [prefs setObject:@"0" forKey:@"keyLogged"];
    [prefs setObject:@"Anonimous" forKey:@"UserName"];
    
    
    NSLog([prefs stringForKey:@"keyLogged"]);
    
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        //[_activityIndicator stopAnimating]; // Hide loading indicator
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
           // [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
            //[self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            
            
            
            
            
            // saving an NSInteger
            [prefs setObject:@"Anonimous" forKey:@"UserName"];
            [prefs setObject:@"0" forKey:@"keyLogged"];
            // This is suggested to synch prefs, but is not needed (I didn't put it in my tut)
            [prefs synchronize];
            
            
            // Send request to Facebook
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                // handle response
                if (!error) {
                    // Parse the data received
                    NSDictionary *userData = (NSDictionary *)result;
                    
                    NSString *facebookID = userData[@"id"];
                    
                    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                    
                    
                    NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
                    
                    if (facebookID) {
                        userProfile[@"facebookId"] = facebookID;
                        
                        [prefs setObject:facebookID forKey:@"facebookId"];
                    }
                    
                    if (userData[@"name"]) {
                        userProfile[@"name"] = userData[@"name"];
                        [prefs setObject:userData[@"name"] forKey:@"UserName"];
                    }
                    [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
                    [[PFUser currentUser] saveInBackground];
                    
                } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                            isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
                    NSLog(@"The facebook session was invalidated");
                    
                } else {
                    NSLog(@"Some other error: %@", error);
                }
            }];
            

        }
    }];
    
   // [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

@end
