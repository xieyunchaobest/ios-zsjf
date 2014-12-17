//
//  Product.m
//  mos
//
//  Created by zhangyuc on 13-2-22.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//


#import "Product.h"

@implementation Product

@synthesize type, name,forumId;


+ (id)productWithType:(NSString *)type name:(NSString *)name forumId:(NSString *)forumId
{
	Product *newProduct = [[[self alloc] init] autorelease];
	newProduct.type = type;
	newProduct.name = name;
    newProduct.forumId = forumId;
	return newProduct;
}


- (void)dealloc
{
	[type release];
	[name release];
    [forumId release];
	[super dealloc];
}

@end
