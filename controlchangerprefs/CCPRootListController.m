#import <Foundation/Foundation.h>
#import "CCPRootListController.h"

@implementation CCPRootListController

- (instancetype)init {
    self = [super init];

    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Respring"style:UIBarButtonItemStylePlain target:self action:@selector(respring:)];
	}

	return self;

}

- (void)respring:(id)sender {
    UIVisualEffectView* blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
    [blurView setFrame:self.view.bounds];
    [blurView setAlpha:0.0];
    [[self view] addSubview:blurView];
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [blurView setAlpha:1.0];
    } completion:^(BOOL finished) {
        pid_t pid;
        int status;
        const char* args[] = {"sbreload", NULL};
        #ifdef THEOS_PACKAGE_INSTALL_PREFIX
         posix_spawn(&pid, "/var/jb/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
        #else
        posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
        #endif

        waitpid(pid, &status, WEXITED);
    }];
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
