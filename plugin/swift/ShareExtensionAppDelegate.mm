#import "ShareExtensionAppDelegate.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@implementation ShareExtensionAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Hi there");
    [self logMemoryUsage]; // Optionally, log memory usage when loading the source URL

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"extension" initialProperties:nil];

    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
    NSLog(@"Running in Debug mode");
    return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
    NSLog(@"Running in Release mode");
    return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

// Method to log total physical memory
- (void)logMemoryUsage {
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    unsigned long long totalMemory = processInfo.physicalMemory;
    NSLog(@"Total physical memory: %llu MB", totalMemory / (1024 * 1024));
}

@end
