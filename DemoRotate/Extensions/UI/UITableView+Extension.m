//
//  TableView+Utilities.m
//  eLearning
//
//  Created by dong ha on 5/26/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import "UITableView+Extension.h"
#import "UIView+Extension.h"

@implementation UITableView (e)
-(void)updateHeightWithContentSize:(void(^)(CGSize))completedBlock {
    CGRect rect = self.frame;
    rect.size.height = 20000;
    self.frame = rect;
    [self reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self adjustHeightConstraintToSuperView:@(self.contentSize.height) isSetValue:YES];
        if (completedBlock) {
            completedBlock(self.contentSize);
        }
    });
}

-(void)getFullContentSize:(void(^)(CGSize))completedBlock {
    [self reloadData];
    float oldHeight = self.frame.size.height;
    CGRect rect = self.frame;
    rect.size.height = 20000;
    self.frame = rect;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect rect = self.frame;
        rect.size.height = oldHeight;
        self.frame = rect;        
        if (completedBlock) {
            completedBlock(self.contentSize);
        }
    });
}
@end
