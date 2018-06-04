//
//  NSObject+Extension.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject(e)

-(void)getDataFromObject:(NSObject *)object {
    unsigned int count;
    objc_property_t *props = class_copyPropertyList([object class], &count);
    
    NSString *keypath;
    NSMutableDictionary *objectKeypaths = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; ++i){
        keypath = [NSString stringWithUTF8String:property_getName(props[i])];
        [objectKeypaths setObject:@1 forKey:keypath];
    }
    free(props);
    
    objc_property_t *selfProps = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; ++i){
        keypath = [NSString stringWithUTF8String:property_getName(selfProps[i])];
        if ([objectKeypaths objectForKey:keypath]) {
            [self setValue:[object valueForKey:keypath] forKey:keypath];
        }
    }
    
    free(selfProps);
}

-(void)sendDataToObject:(NSObject *)object {
    unsigned int count;
    objc_property_t *props = class_copyPropertyList([self class], &count);
    
    NSString *keypath;
    NSMutableDictionary *selfKeypaths = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; ++i){
        keypath = [NSString stringWithUTF8String:property_getName(props[i])];
        [selfKeypaths setObject:@1 forKey:keypath];
    }
    free(props);
    
    objc_property_t *objProps = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; ++i){
        keypath = [NSString stringWithUTF8String:property_getName(objProps[i])];
        if ([selfKeypaths objectForKey:keypath]) {
            [object setValue:[self valueForKey:keypath] forKey:keypath];
        }
    }
    
    free(objProps);
}

@end
