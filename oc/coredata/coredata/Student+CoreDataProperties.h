//
//  Student+CoreDataProperties.h
//  coredata
//
//  Created by jinou on 16/7/25.
//  Copyright © 2016年 qcy.jinou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *s_id;
@property (nullable, nonatomic, retain) NSString *s_name;
@property (nullable, nonatomic, retain) Classes *s_class;

@end

NS_ASSUME_NONNULL_END
