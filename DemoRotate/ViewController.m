//
//  ViewController.m
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "RotateViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)presentPressed:(id)sender {
    RotateViewController *vc = [[RotateViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
