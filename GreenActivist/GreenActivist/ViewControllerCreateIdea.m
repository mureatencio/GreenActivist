//
//  ViewControllerCreateIdea.m
//  GreenActivist
//
//  Created by GoTouch on 09/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import "ViewControllerCreateIdea.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "ComunicacionParse.h"

@interface ViewControllerCreateIdea ()

@end

@implementation ViewControllerCreateIdea

@synthesize imageView, choosePhotoBtn, takePhotoBtn, popoverImageViewController, descriptionTag, tittleTag;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.popoverImageViewController dismissPopoverAnimated:YES];
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
    NSString * description;
    NSString * tittle;
    if ([self.imageView image]!=NULL) {
        complaintImage = [self.imageView image];
    }
    description = self.descriptionTag.text;
    tittle = self.tittleTag.text;
    /* Espacio para enviar los parámetros a parse*/
    ComunicacionParse *Parse = [[ComunicacionParse alloc] init];
    [Parse AgregarIdea:tittle Descripcion:description Imagen:complaintImage];
    
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
            //shareParams.link = [NSURL URLWithString:@"http://www.facebook.com"];
            shareParams.name = @"Checkout my Friend Smash greatness!";
            shareParams.caption= @"Come smash me back!";
            
            //shareParams.picture= [NSURL URLWithString:@"http://htsargentina.info/blog/wp-content/uploads/2013/08/app_store.jpeg"];
            shareParams.description =@"sdakjhasdkjhasdkjhasdkjhasdkjhasdkjhasdkjh";
            [NSString stringWithFormat:@"I just smashed %d friends! Can you beat my score?", 200];
            
            
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
                NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                @"Nombre", @"name",
                                                @"caption", @"caption",
                                                @"description", @"description",
                                                nil];
                
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



-(void)viewDidDisappear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
