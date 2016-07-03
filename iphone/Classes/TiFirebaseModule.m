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

#pragma Public APIs

- (void)init:(id)unused
{
    [FIRApp configure];
}

- (void)logEventWithName:(id)args
{
    ENSURE_UI_THREAD(logEventWithName, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *name;
    NSDictionary *parameters;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(name, args, @"name", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(parameters, args, @"parameter", NSDictionary);
	
 	[FIRAnalytics logEventWithName:name
                        parameters:parameters];
}

+ (void)setUserPropertyString:(id)args
{
    ENSURE_UI_THREAD(setUserPropertyString, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *value;
    NSString *name;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(value, args, @"value", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(name, args, @"name", NSString);
    
	[FIRAnalytics setUserPropertyString:value
                                forName:name];
}

- (void)createUserWithEmail:(id)args
{
    ENSURE_UI_THREAD(createUserWithEmail, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *email;
    NSString *password;
    KrollCallback *successCallback;
    KrollCallback *errorCallback;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(email, args, @"email", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(password, args, @"password", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(successCallback, args, @"success", KrollCallback);
    ENSURE_ARG_OR_NIL_FOR_KEY(errorCallback, args, @"error", KrollCallback);

	[[FIRAuth auth] createUserWithEmail:email
                               password:password
                             completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                 if(errorCallback && error) {
                                        [errorCallback call:@[[self dictionaryFromError:error]] thisObject:nil];
                                 } else if(successCallback) {
                                     [successCallback call:@[[self dictionaryFromUser:user]] thisObject:nil];
                                 }
                             }];

}

- (void)signInWithEmail:(id)args
{
    ENSURE_UI_THREAD(signInWithEmail, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *email;
    NSString *password;
    KrollCallback *successCallback;
    KrollCallback *errorCallback;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(email, args, @"email", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(password, args, @"password", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(successCallback, args, @"success", KrollCallback);
    ENSURE_ARG_OR_NIL_FOR_KEY(errorCallback, args, @"error", KrollCallback);

	[[FIRAuth auth] signInWithEmail:email
                           password: password
                         completion:^(FIRUser *user, NSError *error) {

                            if(errorCallback && error) {
                                [errorCallback call:@[[self dictionaryFromError:error]] thisObject:nil];
                            } else if(successCallback) {
                                [successCallback call:@[[self dictionaryFromUser:user]] thisObject:nil];
                            }
                         }];
}

- (void)signOut:(id)args
{
    ENSURE_UI_THREAD(signOut, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    KrollCallback *successCallback;
    KrollCallback *errorCallback;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(successCallback, args, @"success", KrollCallback);
    ENSURE_ARG_OR_NIL_FOR_KEY(errorCallback, args, @"error", KrollCallback);

	NSError *error;
	[[FIRAuth auth] signOut:&error];
	
    if(!error && successCallback) {
		// Sign-out succeeded
		[successCallback call:@[@"success"] thisObject:nil];
	} else if(errorCallback && error) {
		[errorCallback call:@[[self dictionaryFromError:error]] thisObject:nil];
	}
}

#pragma mark Utilities

- (NSDictionary *)dictionaryFromError:(NSError *)error
{

    if (!error) {
        return nil;
    }

    return @{
        @"code": NUMINTEGER([error code]),
        @"description": [error localizedDescription]
    };
}

- (NSDictionary *)dictionaryFromUser:(FIRUser *_Nullable) user
{
    if (!user) {
        return nil;
    }
    
    return @{
        @"email": [user email],
        @"providerID": [user providerData],
        @"uid": [user uid]
    };
}

@end
