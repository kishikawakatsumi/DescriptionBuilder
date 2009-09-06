//
//  Settings.h
//  TimeSignal
//
//  Created by KISHIKAWA Katsumi on 09/07/20.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject {
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

+ (Settings *)sharedSettings;

@end
