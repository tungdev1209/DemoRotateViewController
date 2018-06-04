//
//  UIDevice+Utilities.m
//  eLearning
//
//  Created by dong ha on 5/28/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import "UIDevice+Extension.h"

@implementation UIDevice(e)

+(BOOL)isIphone {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

@end
