//
//  ViewController.m
//  WKScriptMessageHandler
//
//  Created by kun shen on 2017/3/13.
//  Copyright © 2017年 kun shen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *pushWKWebViewVCButton;

- (IBAction)doPushWKWebViewVC:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.pushWKWebViewVCButton setBackgroundColor:[UIColor redColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - Button functions

- (IBAction)doPushWKWebViewVC:(id)sender {
    
    [self performSegueWithIdentifier:@"gotoWKWebViewViewController" sender:self];
}

@end
