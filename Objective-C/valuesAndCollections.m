#import <Foundation/Foundation.h>
//示例代码：https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/FoundationTypesandCollections/FoundationTypesandCollections.html#//apple_ref/doc/uid/TP40011210-CH7-SW1
@interface XYZCalculator : NSObject
@property double currentValue;
@end
//所有c库的基础类型都在OC中有效
@implementation XYZCalculator
- (void)increment {
  self.currentValue++;
}
- (void)decrement {
  self.currentValue--;
}
- (void)multiplyBy:(double)factor {
  self.currentValue *= factor;
}
@end
/**
 * OC定义的额外原始类型
 * BOOL类型持有了bolean值，YES/NO。YES逻辑上等于true|1,NO等于false|0
 * Cocoa和Cocoa Touch对象方法的参数都使用特殊的数值类型。NSInterger/CGFloat
 **/
// @protocol NSTableViewDataSource <NSObject>
// NSInterger 是一种动态类型，在32位上用int,在64位上用long
// NSUInterger 跟上面同理
// - (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
// @end
void testString() {
  // NSStringde的各种创建的方法初始化
  // NSString是不可变独享
  // TODO 疑问：为什么，后面的消息上要改成参数名
  NSString *firstString =
      [[NSString alloc] initWithCString:"Hello World!"
                               encoding:NSUTF8StringEncoding];
  NSString *secondString = [NSString stringWithCString:"Hello World!"
                                              encoding:NSUTF8StringEncoding];
  NSString *thridString = @"Hello World!";
  //将给定的字符串添加到消息对象上
  NSString *name1 = @"John";
  NSString *name2 = [name1 stringByAppendingString:@"ny"];
  NSLog(@"不可变字符串：%@ %d", name2, name1 == name2);
  NSMutableString *mName = [NSMutableString stringWithString:@"John"];
  [mName appendString:@"ny"];
  NSLog(@"可变字符串：%@", mName);
  //构建字符串的时候格式化
  NSString *magicString =
      [NSString stringWithFormat:@"The magic number is %i", 5];
  NSLog(@"构建格式化的字符串：%@", magicString);
}
void testNumber() {
  // NSNumber表示c的任何scalar类型。包括char double float int long short
  // unsinged .还包括 OC的BOOL 同NSString一样，NSNumber有各种创建实例的方式
  NSNumber *magicNumber = [[NSNumber alloc] initWithInt:42];
  NSNumber *unsignedNumber = [[NSNumber alloc] initWithUnsignedInt:42u];
  NSNumber *longNumber = [[NSNumber alloc] initWithLong:42];
  NSNumber *boolNumber = [[NSNumber alloc] initWithBool:TRUE];
  NSNumber *simpleFloat = [NSNumber numberWithFloat:3.14f];
  NSNumber *betterDouble = [NSNumber numberWithDouble:3.1415926535];
  NSNumber *someChar = [NSNumber numberWithChar:'T'];
  //也可以使用OC的字面量写法
  NSNumber *magicNumber1 = @42;
  NSNumber *unsignedNumber1 = @42u;
  NSNumber *longNumber1 = @42l;
  NSNumber *boolNumber1 = @TRUE;
  NSNumber *simpleFloat1 = @3.14f;
  NSNumber *betterDouble1 = @3.1415926535;
  NSNumber *someChar1 = @'T';
  //可以通过scalar value来访问值
  int scalarMagic = [magicNumber intValue];
  unsigned int scalarUnsigned = [unsignedNumber unsignedIntValue];
  long scalarLong = [longNumber longValue];
  BOOL scalarBool = [boolNumber boolValue];
  float scalarSimpleFloat = [simpleFloat floatValue];
  double scalarBetterDouble = [betterDouble doubleValue];
  char scalarChar = [someChar charValue];

  //还支持使用OC的类型来初始化
  NSInteger anInteger = 64;
  NSUInteger anUnsignedInteger = 100;
  NSNumber *firstInteger = [[NSNumber alloc] initWithInteger:anInteger];
  NSNumber *secondInteger =
      [NSNumber numberWithUnsignedInteger:anUnsignedInteger];
  NSInteger integerCheck = [firstInteger integerValue];
  NSUInteger unsignedCheck = [secondInteger unsignedIntegerValue];
  NSLog(@"NSInteger %ld", anInteger);
}
typedef struct {
  int i;
  float f;
} MyIntegerFloatStruct;
testValue() {
  NSString *mainString = @"This is a long string";
  //找到并返回第一次出现目标字符串的范围
  NSRange substringRange = [mainString rangeOfString:@"long"];
  //可以使用NSValue来表示其他值。将结构体转成NSValue对象
  NSValue *rangeValue = [NSValue valueWithRange:substringRange];
  //从NSValue中取出数据
  NSRange substringRange2 = [rangeValue rangeValue];
  NSLog(@"long的位置: %lu %lu", substringRange2.location,
        substringRange.length);

  //如果有特殊的需求，需要将c结构体包括成OC类型，可以创建NSValue实例，然后value指针
  MyIntegerFloatStruct aStruct;
  aStruct.i = 42;
  aStruct.f = 3.14;
  // value指针指向结构体，并通过encode创建正确的类型
  NSValue *structValue = [NSValue value:&aStruct
                           withObjCType:@encode(MyIntegerFloatStruct)];
  //取出来
  MyIntegerFloatStruct aStruct2;
  [structValue getValue:&aStruct2];
  NSLog(@"MyIntegerFloatStruct %d", aStruct2.i);
}
//有序的集合
testArray() {
  // arrayWithObjects和initWithObjects都将nil作为数组终结符。如果数组中有一项是nil，会提前终结数组
  id firstObject = @"someString";
  id secondObject = nil;
  id thirdObject = @"anotherString";
  NSArray *someArray1 =
      [NSArray arrayWithObjects:firstObject, secondObject, thirdObject, nil];
  //数组字面量,不需要nil终结符，而且会被认为是无效值。NSNULL可以插入这个
  NSArray *someArray = @[ firstObject, thirdObject ];
  //用NSNULL来表示nil
  NSArray *array = @[ @"string", [NSNull null], @42 ];
  for (id object in array) {
    if (object == [NSNull null]) {
      NSLog(@"Found a null object");
    }
  }
  //查询数组对象
  NSUInteger numberOfItems = [someArray count];
  if ([someArray containsObject:firstObject]) {
    NSLog(@"在someArray中找到了 %@", firstObject);
  }
  //根据数组索引查找值
  if ([someArray count] > 0) {
    NSLog(@"First item is:%@ Second item is:%@", [someArray objectAtIndex:0],
          someArray[1]);
  }
  //排序数组，因为数组是不可变的，所以这些排序方法会返回一个新的数组
  NSArray *unsortedStrings = @[ @"gammaString", @"alphaString", @"betaString" ];
  NSArray *sortedStrings =
      [unsortedStrings sortedArrayUsingSelector:@selector(compare:)];
  NSLog(@"sortedArray:%@", sortedStrings);
  //在不可变数组中插入可变字符串，变化它
  NSMutableString *mutableString = [NSMutableString stringWithString:@"Hello"];
  NSArray *immutableArray = @[ mutableString ];
  if ([immutableArray count] > 0) {
    id string = immutableArray[0];
    // NSMutableString
    // class返回它的class，isKindleOfClass对比实例string是否是字符串
    if ([string isKindOfClass:[NSMutableString class]]) {
      //如果是字符串，就给修改给它加字符串
      [string appendString:@" World!"];
    }
  }
  // NSMutableArray可以对数组初始化之后还能继续修改其中它
  NSMutableArray *mutableArray = [NSMutableArray array];
  [mutableArray addObject:@"gamma"];
  [mutableArray addObject:@"alpha"];
  [mutableArray addObject:@"beta"];
  //将0的位置换成新的值
  [mutableArray replaceObjectAtIndex:0 withObject:@"epsilon"];
  NSLog(@"%@", mutableArray);
}
//无序的集合
testSet() {
  //因为不需要维护顺序，所以它的性能要比array要好
  //下面是使用初始化工厂方法
  NSSet *simpleSet = [NSSet setWithObjects:@"Hello, World!", @42, nil];
  //对于相同的元素，直插入一次
  NSNumber *number = @42;
  NSSet *numberSet = [NSSet setWithObjects:number, number, number, number, nil];
  NSLog(@"set length: %ld", [numberSet count]);
  // numberSet only contains one object
}
// Dictionaries对于给定的键存储对象，键加快索引
//最好的用法是将字符串对象作为键,也可以将其他对象作为键
//作为键的对象要能够支持NSCopying，复制以供字典使用。
testDic() {
  // dictionaryWithObjectsAndKeys和initWithObjectsAndKeys必须提前指定好键
  NSDictionary *dictionary1 = [NSDictionary
      dictionaryWithObjectsAndKeys:@"anObject", @"Hello, World!",
                                   @"helloString", @42, @"magicNumber",
                                   @"aValue", nil];
  //字面量语法
  NSDictionary *dictionary =
      @{@"helloString" : @"Hello, World!",
        @"magicNumber" : @42};
  //字典查询，没找到会返回nil
  NSNumber *storeNumber1 = [dictionary objectForKey:@"magicNumber"];
  //还有下标语法直接访问
  NSNumber *storeNumber = dictionary[@"magicNumber"];
  NSLog(@"%@", storeNumber);
  //如果想要能够修改用NSMutableDictionary,@创建的是不可变字典，所以不能用它创建
  NSMutableDictionary *mdictionary = [NSMutableDictionary dictionary];
  [mdictionary setObject:@"another string" forKey:@"newItem"];
  mdictionary[@"newItem2"] = @"new item 2";
  NSLog(@"mdictionary %@", mdictionary);
  [mdictionary removeObjectForKey:@"newItem"];
  NSLog(@"mdictionary %@", mdictionary);
}
testPersist() {
  NSURL *fileURL = [NSURL URLWithString:@"array.txt"
                          relativeToURL:[NSURL fileURLWithPath:@"file:///"]];
  NSLog(@"absoluteURL = %@", [fileURL absoluteURL]);

  NSArray *array = @[ @"first", @"second", @"third" ];
  BOOL success = [array writeToURL:fileURL atomically:YES];
  if (!success) {
    NSLog(@"写入错误了");
  }
}
enumerateCollection() {
  //不能在遍历期间修改数组，即使这个数组是可变的
  NSArray *array = @[ @3, @4, @2 ];
  int count = [array count];
  //传统的c遍历方式
  for (int index = 0; index < count; index++) {
    id eachObject = [array objectAtIndex:index];
    NSLog(@"for item %@", eachObject);
  }
  //集合类都遵守NSFastEnumeration协议，可以使用更快的遍历方式
  for (id item in array) {
    NSLog(@"in item %@", item);
  }
  //反向迭代器
  for (id item in [array reverseObjectEnumerator]) {
    NSLog(@"反向 item %@", item);
  }
  id eachObject;
  //从数组中获取迭代器对象
  NSEnumerator *enumerator = [array objectEnumerator];
  //手动轮训迭代器的nextObject。二元表达式的求值结果是 left hide side
  //但是在条件分支中设置变量会跟=/==搞混,最好是加上（）强调一下是赋值操作
  while ((eachObject = [enumerator nextObject])) {
    NSLog(@"手动 Current object is: %@", eachObject);
  }
  //迭代字典
  NSDictionary *dictionary =
      @{@"helloString" : @"Hello, World!",
        @"magicNumber" : @42};
  for (NSString *eachKey in dictionary) {
    id object = dictionary[eachKey];
    NSLog(@"Object: %@ for key: %@", object, eachKey);
  }
}
int main(int argc, const char *argv[]) {
  testString();
  testNumber();
  testValue();
  testArray();
  testSet();
  testDic();
  testPersist();
  enumerateCollection();
}