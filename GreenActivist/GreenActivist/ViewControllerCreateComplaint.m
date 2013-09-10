//
//  ViewControllerCreateComplaint.m
//  GreenActivist
//
//  Created by GoTouch on 10/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import "ViewControllerCreateComplaint.h"
#import "AppDelegate.h"
#import "ComunicacionParse.h"
#import <Parse/Parse.h>

@interface ViewControllerCreateComplaint ()

@end

@implementation ViewControllerCreateComplaint


@synthesize imageView, choosePhotoBtn, takePhotoBtn, popoverImageViewController, labelX, labelY, myPickerView, itemsArray, tittleTag;

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    itemsArray = [[NSArray alloc] initWithObjects:@"Local Police", @"MINAET", @"WWF", @"GreenPeace", @"Turtle Protectors", nil];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.popoverImageViewController dismissPopoverAnimated:YES];
}

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [itemsArray count];
}

#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [itemsArray objectAtIndex:row];
}



//funcion para tomar fotografias identifica el botón que fue presionado y actua
-(IBAction) getPhoto:(id) sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
	if((UIButton *) sender == choosePhotoBtn) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    [imgPicker setDelegate:self];
    
    if((UIButton *) sender == choosePhotoBtn) {
		[imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        //picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
        [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
		//picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
    
    
    
    
    [imgPicker setAllowsEditing:YES];
    [imgPicker setModalPresentationStyle:UIModalPresentationCurrentContext];
    
    UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:imgPicker];
    // popOver.delegate = self;
    self.popoverImageViewController = popOver;
    [self.popoverImageViewController presentPopoverFromRect:CGRectMake(100, 100, 460, 160) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

//funcion que prepara y envia parametros a parse
- (IBAction)sendComplaint:(id)sender {
    UIImage * complaintImage;
    NSString * coordinateX;
    NSString * coordinateY;
    NSString * description;
    NSString * titulo;
    NSString * autoridad;
    if ([self.imageView image]!=NULL) {
        complaintImage = [self.imageView image];
    }
    
    if (self.allowGPS.on) {
        coordinateX = self.labelX.text;
        coordinateY = self.labelY.text;
    }else{
        coordinateX = 0;
        coordinateY = 0;
    }
    description = self.descriptionTag.text;
    NSInteger row;
    row = [myPickerView selectedRowInComponent:0];
    
    titulo = self.tittleTag.text;
    autoridad = [itemsArray objectAtIndex:row];
    
    /* Espacio para enviar los parámetros a parse*/
    
   ComunicacionParse *Parse = [[ComunicacionParse alloc] init];
    [Parse AgregarDenuncia:titulo Descripcion:description Imagen:complaintImage Cordenada_X:coordinateX Cordenada_Y:coordinateY Institucion:autoridad];
    
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            // This function will invoke the Feed Dialog to post to a user's Timeline and News Feed
            // It will attemnt to use the Facebook Native Share dialog
            // If that's not supported we'll fall back to the web based dialog.
            
            // Prepare the native share dialog parameters
            FBShareDialogParams *shareParams = [[FBShareDialogParams alloc] init];
            //shareParams.link = [NSURL URLWithString:linkURL];
            shareParams.name = @"Checkout my Friend Smash greatness!";
            shareParams.caption= @"Come smash me back!";
            
            //shareParams.picture= [NSURL URLWithString:complaintImage];
            //shareParams.description =@"sdakjhasdkjhasdkjhasdkjhasdkjhasdkjhasdkjh";
            //[NSString stringWithFormat:@"I just smashed %d friends! Can you beat my score?", nScore];
            
            
            if ([FBDialogs canPresentShareDialogWithParams:shareParams]){
                
                [FBDialogs presentShareDialogWithParams:shareParams
                                            clientState:nil
                                                handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                    if(error) {
                                                        NSLog(@"Error publishing story.");
                                                    } else if (results[@"completionGesture"] && [results[@"completionGesture"] isEqualToString:@"cancel"]) {
                                                        NSLog(@"User canceled story publishing.");
                                                    } else {
                                                        NSLog(@"Story published.");
                                                    }
                                                }];
                
            }else {
                
                // Prepare the web dialog parameters
                NSDictionary *params = @{
                                         @"name" : shareParams.name,
                                         @"caption" : shareParams.caption
                                         };
                
                // Invoke the dialog
                [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                                       parameters:params
                                                          handler:
                 ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                     if (error) {
                         NSLog(@"Error publishing story.");
                     } else {
                         if (result == FBWebDialogResultDialogNotCompleted) {
                             NSLog(@"User canceled story publishing.");
                         } else {
                             NSLog(@"Story published.");
                         }
                     }}];
            }
            
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
    

}

//coloca la imagen seleccionada en el uiimageview y cierra el selector.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self.popoverImageViewController dismissPopoverAnimated:YES];
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSLog( @"Agregada fotografia");
}

//funcion para mantener actualizada la locación
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (self.allowGPS.on) {
        self.labelX.text = [NSString stringWithFormat: @"%f", newLocation.coordinate.latitude];
        self.labelY.text = [NSString stringWithFormat: @"%f", newLocation.coordinate.longitude];
    }
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [locationManager stopMonitoringSignificantLocationChanges];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

