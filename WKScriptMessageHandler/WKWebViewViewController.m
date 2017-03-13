//
//  WKWebViewViewController.m
//  WKScriptMessageHandler
//
//  Created by kun shen on 2017/3/13.
//  Copyright © 2017年 kun shen. All rights reserved.
//

#import "WKWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewViewController ()
<
WKScriptMessageHandler,
WKUIDelegate
>

@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"WKScriptMessageHandler";
    
    [self initWKWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark
#pragma mark - Configuration

- (void)initWKWebView {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    
    [configuration.userContentController addScriptMessageHandler:self name:@"ShowMessageFromWKWebView"];
    
    NSString *webViewURLStr = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:webViewURLStr];
    [self.wkWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
}

#pragma mark
#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"body:%@", message.body);
    
    if ([message.name isEqualToString:@"ShowMessageFromWKWebView"]) {
        [self showMessageWithParams:message.body];
    }
}

#pragma mark
#pragma mark - WKUIDelegate

/*
 *响应JS里的alert提醒
 */
/*
function asyncAlert(alertStr) {
    setTimeout(function() {
        alert(alertStr);
    }, 1);
}
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark
#pragma mark - Show Message

- (void)showMessageWithParams:(NSDictionary *)dict {
    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *messageStr = [dict objectForKey:@"message"];
    NSString *titleStr = [dict objectForKey:@"title"];
    NSLog(@"title:%@", titleStr);
    NSLog(@"messageStr:%@", messageStr);
    
    // do it
    
    // 将结果返回给js
    NSString *returnJSStr = [NSString stringWithFormat:@"showMessageFromWKWebViewResult('%@')", @"message传到OC成功，message传到OC成功，message传到OC成功，message传到OC成功，message传到OC成功，message传到OC成功"];
    [self.wkWebView evaluateJavaScript:returnJSStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        NSLog(@"%@,%@", result, error);
    }];
}

@end
