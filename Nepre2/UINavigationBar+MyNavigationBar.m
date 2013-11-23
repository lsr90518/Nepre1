//
//  UINavigationBar+MyNavigationBar.m
//  Nepre2
//
//  Created by Lsr on 11/23/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "UINavigationBar+MyNavigationBar.h"

@implementation UINavigationBar (MyNavigationBar)

-(void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"FoodNavibar"];
    [image drawInRect:CGRectMake(0,0,self.frame.size.width,30)];
}

@end
