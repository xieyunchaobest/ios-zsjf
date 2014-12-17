//
//  Product.h
//  mos
//
//  Created by zhangyuc on 13-2-22.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

//知识库产品类 Added by zhangyuc 2013-02-22
@interface Product : NSObject {
	NSString *type;
	NSString *name;
}

@property (nonatomic, copy) NSString *type, *name, *forumId;


+ (id)productWithType:(NSString *)type name:(NSString *)name forumId:(NSString *)forumId;

@end