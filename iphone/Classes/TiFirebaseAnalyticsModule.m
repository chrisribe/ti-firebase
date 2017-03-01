/**
 * ti-firebase FIRAnalytics
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiFirebaseModule.h"
#import "TiFirebaseAnalyticsModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiFirebaseAnalyticsModule

#pragma Public APIs

- (void)logEventWithName:(id)args
{
    ENSURE_UI_THREAD(logEventWithName, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *name;
    NSMutableDictionary *parameters;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(name, args, @"name", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(parameters, args, @"parameters", NSMutableDictionary);

    // Convert numerical parameters to NSNumber (firebase expects numbers not string numbers)
    NSNumberFormatter *nFormatter = [[NSNumberFormatter alloc] init];
    nFormatter.numberStyle = NSNumberFormatterDecimalStyle;

    NSArray *keysCopy = [[parameters allKeys] copy];
    
    for (NSString *key in keysCopy) {
        NSNumber *strNumber = [nFormatter numberFromString:[parameters valueForKey:key]];
        
        // If a number was converted from string then not nil
        if (strNumber != nil) {
            [parameters setValue:strNumber forKey:key];
        }
    }
    
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

- (void)setUserID:(id)value
{
    ENSURE_UI_THREAD(setUserID, value);
    ENSURE_SINGLE_ARG(value, NSString);
    
    [FIRAnalytics setUserID:[TiUtils stringValue:value]];
}

- (void)setScreenName:(id)args
{
    ENSURE_UI_THREAD(setScreenName, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *screenName;
    NSString *screenClass;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(screenName, args, @"screenName", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(screenClass, args, @"screenClass", NSString);
    
    [FIRAnalytics setScreenName:screenName
                    screenClass:screenClass];
}

@end
