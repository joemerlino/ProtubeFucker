#include <dispatch/dispatch.h>
static BOOL start = NO;
%hook UIAlertView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles{
	if([title containsString:@"not verify app"]){
		start = YES;
		return nil;
	}
	return %orig;
}
%end
%hookf(dispatch_time_t, dispatch_time, dispatch_time_t base, int64_t offset){
	if(start){
		start = NO;
		return -1;
	}
	return %orig;
}