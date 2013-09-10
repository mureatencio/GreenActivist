//
//  ViewControllerCreateIdea.h
//  GreenActivist
//
//  Created by GoTouch on 09/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerCreateIdea :  UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
    
}

@property (strong, nonatomic) IBOutlet UITextField *tittleTag;
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, strong) IBOutlet UIButton * takePhotoBtn;

@property (strong) UIPopoverController *popoverImageViewController;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTag;

- (IBAction)getPhoto:(id)sender;
- (IBAction)sendComplaint:(id)sender;


@end
