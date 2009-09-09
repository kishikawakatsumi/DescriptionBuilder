//
//  TestObject.h
//  DescriptionBuilder
//
//  Created by KISHIKAWA Katsumi on 09/09/07.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObject : NSObject {
	NSUInteger version;
	BOOL autoLock;
	BOOL twentyFourHourTime;
	NSString *alarmSound;
	float alarmVolume;
}

@property (nonatomic) NSUInteger version;
@property (nonatomic) BOOL autoLock;
@property (nonatomic) BOOL twentyFourHourTime;
@property (nonatomic, retain) NSString *alarmSound;
@property (nonatomic) float alarmVolume;

+ (TestObject *)sharedObject;

@end
