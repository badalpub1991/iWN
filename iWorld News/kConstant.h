//
//  kConstant.h
//  bitbigdiary
//
//  Created by Nitin Gohel on 21/07/13.
//
//

#ifndef bitbigdiary_kConstant_h
#define bitbigdiary_kConstant_h




#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)



#define isiPhone4s  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone6plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE




#define isiPad2 ([[UIScreen mainScreen] bounds].size.height == 1024)?TRUE:FALSE
#define isiPadAir ([[UIScreen mainScreen] bounds].size.height == 1024)?TRUE:FALSE
#define isiPadRatina ([[UIScreen mainScreen] bounds].size.height == 1024)?TRUE:FALSE


#define AdMob_ID @"ca-app-pub-3225124349268589/4240460551" 
#endif



