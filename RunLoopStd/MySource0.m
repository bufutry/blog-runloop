//
//  MySource0.m
//  RunLoop
//
//  Created by ysx on 2021/3/28.
//

#import "MySource0.h"
#import <Foundation/Foundation.h>


void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    MySource0* obj = (__bridge MySource0*)info;
    uiapp
    UIAppDelegate*   del = [UIAppDelegate sharedAppDelegate];
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
 
    [del performSelectorOnMainThread:@selector(registerSource:)
                                withObject:theContext waitUntilDone:NO];
}

void RunLoopSourcePerformRoutine (void *info)
{
    RunLoopSource*  obj = (RunLoopSource*)info;
    [obj sourceFired];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource* obj = (RunLoopSource*)info;
    AppDelegate* del = [AppDelegate sharedAppDelegate];
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
 
    [del performSelectorOnMainThread:@selector(removeSource:)
                                withObject:theContext waitUntilDone:YES];
}


@implementation MySource0

- (id)init
{
    CFRunLoopSourceContext context = {0, self, NULL, NULL, NULL, NULL, NULL,

    &RunLoopSourceScheduleRoutine,

    RunLoopSourceCancelRoutine,

    RunLoopSourcePerformRoutine};

    runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);

    commands = [[NSMutableArray alloc] init];

    return self;
}

- (void)addToCurrentRunLoop

{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();

    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}
- (void)invalidate{
    
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop
{
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runloop);
}

@end
