//
//  ComunicacionParse.h
//  GreenActivist
//
//  Created by Edward Umaña Williams on 09/09/13.
//  Copyright (c) 2013 GoTouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ComunicacionParse : NSObject




- (void ) AgregarIdea:(NSString *)titulo  Descripcion:(NSString *)pDescripcion Imagen:(UIImage *)pImagen;
- (void ) AgregarDenuncia:(NSString *)titulo  Descripcion:(NSArray *)pDescripcion Imagen:(UIImage *)pImagen Cordenada_X:(NSString *)pCor_X Cordenada_Y:(NSString *)pCor_Y Institucion:(NSString *)pInstituacion;

-  (void ) ConsultarDenuciasTitulos;

-  (void) ConsultaDenunciaPorId:(NSString *)pId;


@end
