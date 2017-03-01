/**
 * ti-firebase FIRAuth
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiFirebaseModule.h"
#import "TiFirebaseAuthModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiFirebaseAuthModule

#pragma Public APIs

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

- (void)setUserPropertyString:(id)args
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
                                 if (errorCallback && error) {
                                     [errorCallback call:@[[TiFirebaseModule dictionaryFromError:error]] thisObject:nil];
                                 } else if (successCallback) {
                                     [successCallback call:@[[TiFirebaseModule dictionaryFromUser:user]] thisObject:nil];
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
                             if (errorCallback && error) {
                                 [errorCallback call:@[[TiFirebaseModule dictionaryFromError:error]] thisObject:nil];
                             } else if (successCallback) {
                                 [successCallback call:@[[TiFirebaseModule dictionaryFromUser:user]] thisObject:nil];
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
	
	NSError *authError;
	BOOL status = [[FIRAuth auth] signOut:&authError];//Note: odd signOut seems to always return true!?
	
    if (status && successCallback) {
        // Sign-out succeeded
        [successCallback call:@[@"success"] thisObject:nil];
    } else if (errorCallback) {
        [errorCallback call:@[[TiFirebaseModule dictionaryFromError:authError]] thisObject:nil];
    }
}

- (void)sendPasswordResetWithEmail:(id)args
{
    ENSURE_UI_THREAD(sendPasswordResetWithEmail, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    KrollCallback *successCallback;
    KrollCallback *errorCallback;
    NSString *email;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(successCallback, args, @"success", KrollCallback);
    ENSURE_ARG_OR_NIL_FOR_KEY(errorCallback, args, @"error", KrollCallback);
    ENSURE_ARG_FOR_KEY(email, args, @"email", NSString);

    [[FIRAuth auth] sendPasswordResetWithEmail:email
                                    completion:^(NSError *error) {
                                        if (errorCallback && error) {
                                            [errorCallback call:@[@{@"success": NUMBOOL(NO)}] thisObject:nil];
                                        } else if (successCallback) {
                                            [successCallback call:@[@{@"success": NUMBOOL(YES)}] thisObject:nil];
                                        }
                                    }];
}

- (NSDictionary *)currentUser
{
    return [TiFirebaseModule dictionaryFromUser:[[FIRAuth auth] currentUser]];
}
@end
