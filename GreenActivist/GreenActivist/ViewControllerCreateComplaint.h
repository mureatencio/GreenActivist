//
//  ViewControllerCreateComplaint.h
//  GreenActivist
//
//  Created by GoTouch on 10/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewControllerCreateComplaint : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
    CLLocationManager *locationManager;
    
}
@property (nonatomic, strong) NSArray *itemsArray;
@property (strong, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, strong) IBOutlet UIButton * takePhotoBtn;
@property ( strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) ALAssetsLibrary *library;
@property (strong, nonatomic) IBOutlet UISwitch *allowGPS;
@property (strong) UIPopoverController *popoverImageViewController;
@property (strong, nonatomic) IBOutlet UITextView*descriptionTag;
@property (strong, nonatomic) IBOutlet UILabel *labelX;
@property (strong, nonatomic) IBOutlet UILabel *labelY;

- (IBAction)getPhoto:(id)sender;
- (IBAction)sendComplaint:(id)sender;


@end
