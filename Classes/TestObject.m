//
//  Settings.m
//  DescriptionBuilder
//
//  Created by KISHIKAWA Katsumi on 09/09/07.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

#import "TestObject.h"
#import "DescriptionBuilder.h"

@implementation TestObject

static TestObject *sharedObject;

@synthesize version;
@synthesize autoLock;
@synthesize twentyFourHourTime;
@synthesize alarmSound;
@synthesize alarmVolume;

+ (TestObject *)sharedObject {
	if (!sharedObject) {
		sharedObject = [[TestObject alloc] init];
	}
	return sharedObject;
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
    return [DescriptionBuilder reflectDescription:self];
}

@end
