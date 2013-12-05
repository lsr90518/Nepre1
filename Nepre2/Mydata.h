//
//  Mydata.h
//  Nepre2
//
//  Created by Lsr on 12/4/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mydata : NSObject
{
}

+ (Mydata *)sharedSingleton;
@property (nonatomic,retain) NSString *testGlobal;
@property (retain, nonatomic) NSMutableArray *foodViewArray;
@property (retain, nonatomic) NSMutableArray *userList;
@property (retain, nonatomic) NSMutableArray *usernameList;
@property (retain, nonatomic) NSString *nowGoProfile;

@property (retain, nonatomic) NSString *detailLocation;

@property (retain, nonatomic) NSMutableArray *imageViewnameArray;
@property (retain, nonatomic) NSMutableArray *imageViewheightArray;
@property (retain, nonatomic) NSMutableArray *imageViewwidthArray;
@property (retain, nonatomic) NSMutableArray *imageViewidArray;
@property (retain, nonatomic) NSMutableArray *imageViewlatArray;
@property (retain, nonatomic) NSMutableArray *imageViewlngArray;

@property (retain, nonatomic) NSMutableArray *followList;
@property (retain, nonatomic) NSMutableArray *followerList;
@property (retain, nonatomic) NSString *detailImageTag;

@end
