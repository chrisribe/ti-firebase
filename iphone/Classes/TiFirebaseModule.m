/**
 * ti-firebase
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiFirebaseModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiFirebaseModule

#pragma mark Internal

- (id)moduleGUID
{
	return @"1dc51f4a-d89b-4df2-89da-278d5a246c90";
}

- (NSString*)moduleId
{
	return @"ti.firebase";
}

#pragma mark Lifecycle

- (void)startup
{
	[super startup];
	NSLog(@"[INFO] %@ loaded",self);
}
-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup
-(void)dealloc
{
	// release any resources that have been retained by the module
    RELEASE_TO_NIL(firAuth);
	RELEASE_TO_NIL(firAnalytics);
	[super dealloc];
}

#pragma mark Internal Memory Management
-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
    RELEASE_TO_NIL(firAuth);
	RELEASE_TO_NIL(firAnalytics);
	[super didReceiveMemoryWarning:notification];
}

#pragma Public APIs (FIRApp Class entry point)

- (void)configure:(id)unused
{
    [FIRApp configure];
}


#pragma Public APIs (FIRAuth Class entry point)

-(TiFirebaseAuthModule*)FIRAuth
{
    if (firAuth==nil)
    {
        return [[[TiFirebaseAuthModule alloc] _initWithPageContext:[self executionContext]] autorelease];
    }
    return firAuth;
}

#pragma Public APIs (FIRAnalytics Class entry point)
-(TiFirebaseAnalyticsModule*)FIRAnalytics
{
    if (firAnalytics==nil)
    {
        return [[[TiFirebaseAnalyticsModule alloc] _initWithPageContext:[self executionContext]] autorelease];
    }
    return firAnalytics;
}


#pragma mark Utilities

+ (NSDictionary *_Nullable)dictionaryFromError:(NSError *_Nullable)error
{
    if (!error) {
        return nil;
    }

    return @{
        @"code": NUMINTEGER([error code]),
        @"description": [error localizedDescription]
    };
}

+ (NSDictionary *_Nullable)dictionaryFromUser:(FIRUser *_Nullable) user
{
    if (!user) {
        return nil;
    }

    return @{
        @"email": [user email],
        @"providerID": [user providerID],
        @"uid": [user uid],// Provider-specific UID
		@"photoURL": ([user photoURL].absoluteString ?: [NSNull null]),
		@"displayName": ([user displayName] ?: [NSNull null])
    };
}

@end
