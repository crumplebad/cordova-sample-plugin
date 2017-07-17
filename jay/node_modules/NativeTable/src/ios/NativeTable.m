#import "NativeTable.h"
#import <Cordova/CDV.h>

@implementation NativeTable {
    CGRect originalWebViewFrame;
    NSArray* tableDataSource;
    int tableHeight;
}

- (void)test:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  NSString* msg = [command.arguments objectAtIndex:0];

  if (msg == nil || [msg length] == 0) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  } else {
    UIAlertView *toast = [
      [UIAlertView alloc] initWithTitle:@""
        message:msg
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil, nil];

    [toast show];
        
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), 
//dispatch_get_main_queue(), ^{
//      [toast dismissWithClickedButtonIndex:0 animated:YES];
//    });
      
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK 
messageAsString:msg];
  }

  [self.commandDelegate sendPluginResult:pluginResult 
callbackId:command.callbackId];
}

- (void)createTable:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    tableDataSource = [command.arguments objectAtIndex:0];
    tableHeight = [command.arguments objectAtIndex:1];
    
    if (tableDataSource == nil || [tableDataSource count] == 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    } else {
        UIAlertView *toast = [
                              [UIAlertView alloc] initWithTitle:@""
                              message:@"Table!!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        
        [toast show];
        
        self.mainTableView = [UITableView new];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        self.webView.superview.autoresizesSubviews = YES;
        [self.webView.superview addSubview:self.mainTableView];

        originalWebViewFrame = self.webView.frame;
        CGRect mainTableFrame, CDWebViewFrame;
        CDWebViewFrame = CGRectMake(
                                    originalWebViewFrame.origin.x,
                                    originalWebViewFrame.origin.y,
                                    originalWebViewFrame.size.width,
                                    originalWebViewFrame.size.height - tableHeight
                                    );
        
        mainTableFrame = CGRectMake(
                                    CDWebViewFrame.origin.x,
                                    CDWebViewFrame.origin.y + CDWebViewFrame.size.height,
                                    CDWebViewFrame.size.width,
                                    tableHeight
                                    );
        
        [self.webView setFrame:CDWebViewFrame];
        [_mainTableView setFrame:mainTableFrame];

        [self.mainTableView reloadData];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                         messageAsString:@"ready!"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult 
                                callbackId:command.callbackId];
    
    
    
}

-(CDVPlugin*) initWithWebView:(UIWebView*)theWebView
{
//    self = (JaysTable*)[super initWithWebView:theWebView];
    if (self)
    {
        //NSLog(@"NativeTable Initialized!");
        
    }
    return self;
}



#pragma mark - tableView delegate and datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if(nil != tableDataSource){
        return [tableDataSource count];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[tableDataSource objectAtIndex:indexPath.row] valueForKey:@"textLabel"];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];

    
    return cell;
}

@end
