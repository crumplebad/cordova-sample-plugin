#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>


@interface NativeTable : CDVPlugin<UITableViewDelegate,UITableViewDataSource>{
    
}


@property (nonatomic, assign) UITableView *mainTableView;

- (void)test:(CDVInvokedUrlCommand*)command;
- (void)createTable:(CDVInvokedUrlCommand*)command;

@end
