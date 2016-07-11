/**
 * ti-firebase
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

-(void)dealloc
{
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	[super didReceiveMemoryWarning:notification];
}


#pragma Public APIs

- (void)logEventWithName:(id)args
{
    ENSURE_UI_THREAD(logEventWithName, args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *name;
    NSDictionary *parameters;
    
    ENSURE_ARG_OR_NIL_FOR_KEY(name, args, @"name", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(parameters, args, @"parameters", NSDictionary);
	
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
@end
