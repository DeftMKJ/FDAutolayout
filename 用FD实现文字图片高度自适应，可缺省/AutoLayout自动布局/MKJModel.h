//
//  MKJModel.h
//  AutoLayout自动布局
//
//  Created by 宓珂璟 on 16/5/5.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MKJModel : NSObject

@property (nonatomic,copy) NSString *headImageURL;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *mainImageURL;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,assign) CGFloat mainHeight;
@property (nonatomic,assign) CGFloat mainWidth;

@end
