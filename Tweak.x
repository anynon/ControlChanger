#import <UIKit/UIKit.h>

@interface SBFluidSwitcherScreenEdgePanGestureRecognizer : UIScreenEdgePanGestureRecognizer
@end

@interface SBGrabberTongue: NSObject
-(void)dismissWithStyle:(long long)arg1 animated:(BOOL)arg2;
@end

@interface SBControlCenterController: NSObject
+(id)sharedInstance;
+(void)presentAnimated:(BOOL)arg1;
@end

static NSInteger cornerPreference; 
static double touchArea;

%group bottomGrabber

%hook SBFluidSwitcherGestureManager

- (void)grabberTongueBeganPulling:(SBGrabberTongue *)arg1 withDistance:(double)arg2 andVelocity:(double)arg3 andGesture:(SBFluidSwitcherScreenEdgePanGestureRecognizer *)arg4  {
    
    CGPoint initialTouchPoint = [arg4 locationInView:arg4.view];
    CGFloat screenWidth = arg4.view.bounds.size.width;

    if (cornerPreference == 0 && initialTouchPoint.x >= screenWidth * (1 - touchArea)) {
        [[objc_getClass("SBControlCenterController") sharedInstance] presentAnimated:YES];
    }
    else if (cornerPreference == 1 && initialTouchPoint.x <= screenWidth * touchArea) {
        [[objc_getClass("SBControlCenterController") sharedInstance] presentAnimated:YES];
    }
    else {
        %orig;
    }
}

%end

%end

// %group topGrabber // Doesn't fully work, because the coversheet still pulls down
// %hook SBCoverSheetPrimarySlidingViewController

// - (void)grabberTongueBeganPulling:(SBGrabberTongue *)arg1 withDistance:(double)arg2 andVelocity:(double)arg3 andGesture:(SBFluidSwitcherScreenEdgePanGestureRecognizer *)arg4  {
    
//     CGPoint initialTouchPoint = [arg4 locationInView:arg4.view];
//     CGFloat screenWidth = arg4.view.bounds.size.width;

//     if (cornerPreference == 3 && initialTouchPoint.x >= screenWidth * (1 - touchArea)) {
//         [[objc_getClass("SBControlCenterController") sharedInstance] presentAnimated:YES];
//     }
//     else if (cornerPreference == 2 && initialTouchPoint.x <= screenWidth * touchArea) {
//         [[objc_getClass("SBControlCenterController") sharedInstance] presentAnimated:YES];
//     }
//     else {
//         %orig;
//     }
// }

// %end
// %end


%group removeOriginalGesture

%hook SBControlCenterController

- (BOOL)allowShowTransitionSystemGesture {
	return NO;
}

%end

%end


%ctor {
    NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] initWithSuiteName:@"com.ryannair05.controlchanger"];

    cornerPreference = [defaults integerForKey:@"swipePosition"];

	touchArea = [defaults doubleForKey:@"touchPoint"];

	if (!touchArea) {
		touchArea = 0.33;
	}
    
    // if (cornerPreference == 0 || cornerPreference == 1) {
        %init(bottomGrabber);
    // }
    // else {
    // 	%init(topGrabber);
    // }

    if (![defaults boolForKey:@"swipePosition"]) {
        %init(removeOriginalGesture);
    }

    %init;
}
