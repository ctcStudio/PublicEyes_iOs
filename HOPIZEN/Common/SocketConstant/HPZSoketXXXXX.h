//
//  HPZSoketXXXXX.h
//  CameraDemo
//
//  Created by Thuy Do Thanh on 12/27/16.
//  Copyright © 2016 Thuy Do Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HPZSoketXXXXX;

@protocol HPZSoketXXXXXDelegate <NSObject>

- (void)socketDidConnect;
- (void)messageReceived:(NSString *)message;

@end

@interface HPZSoketXXXXX : NSObject

@property (nonatomic, strong) id <HPZSoketXXXXXDelegate> delegate;

- (instancetype)initWithHost:(NSString *)ihost port:(int)iport;


#pragma - mark send message

- (void) sendMessageToServer:(NSString *)mesage;

@end
