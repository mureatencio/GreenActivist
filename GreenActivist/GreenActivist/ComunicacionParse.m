//
//  ComunicacionParse.m
//  GreenActivist
//
//  Created by Edward Umaña Williams on 09/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import "ComunicacionParse.h"


@implementation ComunicacionParse




- (void) AgregarIdea:(NSString *)pTitulo  Descripcion:(NSArray *)pDescripcion Imagen:(UIImage *)pImagen
{
    
    //PFObject *Idea = [PFObject objectWithClassName:@"Idea"];
   /// [gameScore setObject:[NSNumber numberWithInt:1337] forKey:@"score"];
   // [gameScore setObject:@"Sean Plott" forKey:@"playerName"];
 //   [gameScore setObject:[NSNumber numberWithBool:NO] forKey:@"cheatMode"];
 //   [gameScore saveInBackground];

    if(pImagen==NULL)
    {
        PFObject *Idea = [PFObject objectWithClassName:@"Idea"];
        [Idea setObject:pTitulo forKey:@"titulo"];
        [Idea setObject:pDescripcion forKey:@"descripcion"];
        [Idea save];
        
    }
    else{
        NSData *imageData = UIImagePNGRepresentation(pImagen);
        PFFile *imageFile = [PFFile fileWithName:pTitulo data:imageData];
        [imageFile save];

        
        PFObject *Idea = [PFObject objectWithClassName:@"Idea"];
        [Idea setObject:pTitulo forKey:@"titulo"];
        [Idea setObject:pDescripcion forKey:@"descripcion"];
        [Idea setObject:imageFile    forKey:@"imageFile"];
        [Idea save];
        
    }
    
    
    
     
   

}

- (void) AgregarDenuncia:(NSString *)pTitulo  Descripcion:(NSString *)pDescripcion Imagen:(UIImage *)pImagen Cordenada_X:(NSString*)pCor_X Cordenada_Y:(NSString *)pCor_Y Institucion:(NSString *)pInstituacion
{
    
    if(pImagen==NULL)
    {
        PFObject *Denuncia = [PFObject objectWithClassName:@"Denuncia"];
        [Denuncia setObject:pTitulo forKey:@"titulo"];
        [Denuncia setObject:pDescripcion forKey:@"descripcion"];
        [Denuncia setObject:pCor_X forKey:@"Cor_X"];
        [Denuncia setObject:pCor_Y forKey:@"Cor_Y"];
        [Denuncia setObject:pInstituacion forKey:@"institucion"];
        [Denuncia save];
    }
    else{
      
        NSData *imageData = UIImagePNGRepresentation(pImagen);
        PFFile *imageFile = [PFFile fileWithName:pTitulo data:imageData];
        [imageFile save];
        
        PFObject *Denuncia = [PFObject objectWithClassName:@"Denuncia"];
        [Denuncia setObject:imageFile    forKey:@"imagen"];
        [Denuncia setObject:pTitulo forKey:@"titulo"];
        [Denuncia setObject:pDescripcion forKey:@"descripcion"];
        [Denuncia setObject:pCor_X forKey:@"Cor_X"];
        [Denuncia setObject:pCor_Y forKey:@"Cor_Y"];
        [Denuncia setObject:pInstituacion forKey:@"institucion"];
        [Denuncia save];

        
    }
        
    
}

-  (void) ConsultarDenuciasTitulos{
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Denuncia"];
       
    [query whereKey:@"titulo" notEqualTo:@"asdsafasdf"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@",  [object objectForKey:@"titulo"]);
                            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
   

    
}

-  (void) ConsultaDenunciaPorId:(NSString *)pId{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Denuncia"];
    [query whereKey:@"objectId" equalTo:pId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
  
    
    
}








@end
