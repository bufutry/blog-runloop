//
//  MySource0.h
//  RunLoop
//
//  Created by ysx on 2021/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);
void RunLoopSourcePerformRoutine (void *info);
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);

@interface MySource0 : NSObject
{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray* commands;
}

- (id)init;
- (void)addToCurrentRunLoop;
- (void)invalidate;

// Handler method
- (void)sourceFired;
 
// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data;
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end

@interface RunLoopContext : NSObject
{
    CFRunLoopRef        runLoop;
    MySource0*        source;
}
@property (readonly) CFRunLoopRef runLoop;
@property (readonly) MySource0* source;
 
- (id)initWithSource:(MySource0*)src andLoop:(CFRunLoopRef)loop;
@end

NS_ASSUME_NONNULL_END
