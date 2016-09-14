//
//  Classes+CoreDataProperties.h
//  coredata
//
//  Created by jinou on 16/7/25.
//  Copyright © 2016年 qcy.jinou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Classes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *c_id;
@property (nullable, nonatomic, retain) NSString *c_name;
@property (nullable, nonatomic, retain) NSSet<Student *> *c_student;

@end

@interface Classes (CoreDataGeneratedAccessors)

- (void)addC_studentObject:(Student *)value;
- (void)removeC_studentObject:(Student *)value;
- (void)addC_student:(NSSet<Student *> *)values;
- (void)removeC_student:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
