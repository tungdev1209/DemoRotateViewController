//
//  UIColor+Utilities.h
//  eLearning
//
//  Created by dong ha on 5/28/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ColorRGB(r, g, b) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0f]
#define ColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (e)

@end

