//
//  ViewController.m
//  LoadingDemo
//
//  Created by jiejin on 16/4/12.
//  Copyright © 2016年 jiejin. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"

@interface ViewController ()

@property (nonatomic, strong) LoadingView *loading;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.isLoading = YES;
    self.loading = [LoadingView shareObjectWithSuperView:self.view];
    
    [self.loading start];
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 120, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked{

    if(self.isLoading){
    
        [self.loading stop];
        self.isLoading = NO;
    }else{
    
        [self.loading start];
        self.isLoading = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
