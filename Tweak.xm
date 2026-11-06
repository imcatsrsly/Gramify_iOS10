#import <UIKit/UIKit.h>

@interface SHAppDelegate : NSObject <UIApplicationDelegate>
@end

%hook SHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL result = %orig;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reskin tweak is working"
                                                      message:@"Hook fired on launch"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [alert show];
    return result;
}

%end
