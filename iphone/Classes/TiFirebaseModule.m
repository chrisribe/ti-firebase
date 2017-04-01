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
	NSLog(@"[DEBUG] %@ loaded",self);
}

#pragma Public APIs (FIRApp Class entry point)

- (void)configure:(id)unused
{
    [FIRApp configure];
}

- (id)projectID
{
    return [[FIROptions defaultOptions] projectID];
}

#pragma Public APIs (FIRAuth Class entry point)

- (TiFirebaseAuthModule*)FIRAuth
{
    if (firAuth == nil) {
        return [[TiFirebaseAuthModule alloc] _initWithPageContext:[self executionContext]];
    }
    return firAuth;
}

#pragma Public APIs (FIRAnalytics Class entry point)
- (TiFirebaseAnalyticsModule*)FIRAnalytics
{
    if (firAnalytics == nil) {
        return [[TiFirebaseAnalyticsModule alloc] _initWithPageContext:[self executionContext]];
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

+ (NSDictionary * _Nullable)dictionaryFromUser:(FIRUser *_Nullable) user
{
    if (!user) {
        return nil;
    }

    return @{
        @"email": [user email],
        @"providerID": [user providerID],
        @"uid": [user uid],// Provider-specific UID
		@"photoURL": NULL_IF_NIL([[user photoURL] absoluteString]),
		@"displayName": NULL_IF_NIL([user displayName])
    };
}

@end
