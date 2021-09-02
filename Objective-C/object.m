#import <Foundation/Foundation.h>
// 示例代码：https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithObjects/WorkingwithObjects.html#//apple_ref/doc/uid/TP40011210-CH4-SW1
//每个类的名称都必须是唯一的，即使在包含的库或者框架中也是如此，因为这个原因，所以建议任何类的名称之前使用定义的命名空间名称作为前缀
//为什么有这么多NS前缀，是因为Cocoa和Cocoa Touch过去的历史
@interface XYZPerson : NSObject
- (void)sayHello;
//声明函数的参数是string对象 - 表示它是一个实例方法
- (void)saySomething:(NSString *)greeting;
@end

@implementation XYZPerson
// OC方法名称区分大小写。通常方法名称应以小写开通。OC约定为了让方法比典型C函数更多描述性内容。如果方法设计多个单词，建议大驼峰。
- (void)sayHello {
  //@"Hello,world"字符串是OC中允许快捷方式创建的几种类型之一
  //通过self指向，向自己发送消息
  [self saySomething:@"Hello, world!"];
}
- (void)saySomething:(NSString *)greeting {
  //类似于c的printf，向控制台中插入字符串并格式化
  //%@来表示一个对象，会将说明符替换为对象的description方法。description方法由NSObject提供并返回对象的内存地址
  //但是许多 Cocoa and Cocoa Touch
  //会重写提供有用的信息。NSString会重写返回自身代表的字符串
  NSLog(@"%@", greeting);
}
@end

@interface XYZShoutingPerson : XYZPerson
@end

@implementation XYZShoutingPerson
//重写了父类的saySomething实现
- (void)saySomething:(NSString *)greeting {
  NSString *uppercaseGreeting = [greeting uppercaseString];
  //通过super来调用最原始的输出逻辑
  [super saySomething:uppercaseGreeting];
}
@end

//以上是类的实现部分
int main(int argc, const char *argv[]) {
  // OC的对象通常比方法调用的scope有更长的生命周期，对象的内存是动态分配和释放的。字符串也是内存对象
  // OC编译器的自动引用计数(ARC)会帮助我们回收堆上分配的内存，以免造成内存泄漏
  // alloc保证继承链上的所有属性都有足够的内存分配
  // init方法保证其属性创建时具有合适的值
  XYZShoutingPerson *shoutingPerson = [[XYZShoutingPerson alloc] init];
  //在没有参数的初始化的时候，使用new更为高效
  // XYZShoutingPerson *shoutingPerson = [XYZShoutingPerson new];
  //虽然oc中有几种不同的对象发送消息的方式，目前最常用的是用方括号的基本语法
  [shoutingPerson sayHello];
  // NSNumber提供了工厂方法来替换传统的alloc] init]
  NSNumber *magicNumber = [NSNumber numberWithInt:42];
  NSLog(@"%d", [magicNumber intValue]);
  return 0;
}

//示例代码：https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/DefiningClasses/DefiningClasses.html#//apple_ref/doc/uid/TP40011210-CH3-SW5
//在OC中，类本身就是一个对象，类型是不透明的。类不能显示的实例声明属性和方法，但可以接收消息，常见是作为工程方法，动态创建对象(分配和初始化)
@interface Person : NSObject
//都能被公开访问
@property NSString *firstName;
//设置property的Attribute为readonly，意味只读
@property(readonly) NSString *lastName;
@property int *yearOfBirth;
//声明的方法指示了对象可以接收的消息
// OC的方法声明包括参数也是函数名字的一部分
//一些编程语言允许使用命名参数定义函数，但是OC不行，方法调用参数顺序必须与声明匹配。sencond是方法名称的一部分
// initFullName:second: 这是OC可读性特性之一
//（ps:因为本身方法调用时传递给接收对象的消息，所以参数调用其实是组合方法名称一个完整的消息名)
//参数名不作为方法前面的一部分，参数类型是的。所以它支持方法重载
//+ 表示类方法声明。实现跟-一样。都是在implementation中实现
+ (void)initFullName:(NSString *)firstName sencond:(NSString *)lastName;
@end