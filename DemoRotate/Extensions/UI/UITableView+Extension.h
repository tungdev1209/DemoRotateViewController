//
//  TableView+Utilities.h
//  eLearning
//
//  Created by dong ha on 5/26/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (e)
-(void)updateHeightWithContentSize:(void(^)(CGSize))completedBlock;
-(void)getFullContentSize:(void(^)(CGSize))completedBlock;
@end
