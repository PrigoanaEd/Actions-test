#import "YTPlayerViewController.h"

@interface YTSegmentableInlinePlayerBarView : UIView
@property (nonatomic, readonly, assign) CGFloat totalTime;
@property (nonatomic, readwrite, strong) YTPlayerViewController *playerViewController;
@end
