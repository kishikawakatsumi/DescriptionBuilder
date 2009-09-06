//
//  Settings.m
//  TimeSignal
//
//  Created by KISHIKAWA Katsumi on 09/07/20.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "Settings.h"
#import "DescriptionBuilder.h"

@implementation Settings

static Settings *sharedSettings;

@synthesize version;
@synthesize autoLock;
@synthesize twentyFourHourTime;
@synthesize alarmSound;
@synthesize alarmVolume;

+ (Settings *)sharedSettings {
	if (!sharedSettings) {
		sharedSettings = [[Settings alloc] init];
	}
	return sharedSettings;
}

- (id)init {
	if (self = [super init]) {
		version = 100;
		autoLock = NO;
		twentyFourHourTime = YES;
		self.alarmSound = @"digital-alarm";
		alarmVolume = 1.0f;
	}
	return self;
}

- (void)dealloc {
	[alarmSound release];
	[super dealloc];
}

- (NSString *)description {
    return [DescriptionBuilder reflectDescription];
}

@end
