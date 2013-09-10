//
//  ViewControllerCreateIdea.m
//  GreenActivist
//
//  Created by GoTouch on 09/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import "ViewControllerCreateIdea.h"
#import "AppDelegate.h"
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
