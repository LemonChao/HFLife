# 汉富项目开发具体规范
各位兄弟们 为了让我们 合作开发的更愉快 别的兄弟能够快速读懂你的代码，以帮助你修复bug, 也是为了在我们走向大牛的道路上对我们最基本的代码风格做一个美化 养成一个好的习惯 我们这个项目做了一下 几点 `必须要准守的规范` 请大家相互配合！
## 1.使用全局类命名
大驼峰命名类名 ： MyClass
```
选择项目.xcodeproj -> 打开左侧菜单->找到 class prefix -> 添加 
age: HF_SXF（大写）_Classname
```
## 2.property命名
```
小驼峰命名 + 英文命名 + 注释
注意：添加注释  添加方式不要用 // 而是使用
/**
Description
*/  
快捷键方式 （option + command + /）
```
## 3.method写法
```
1.带有返回值的使用 set开头
2.数据加载           统一方法名 : - (void)loadServerData;
3.给cell 赋值       统一方法名 :  - (void)setDataForCell:();
4.给view赋值        统一方法名 :  - (void)setDataForView:();
5.设置UI（addView）  统一方法名 :  - (void)setUpUI;
以上方法自行添加快捷代码块

6.view布局如果使用代码布局 建议使用Masonry  ：约束代码 写在 
- (void)layoutSubviews{
[super layoutSubviews];
}
7.方法书写 返回值前空格 后不空  (参照系统方法书写) 
8.能用 ？： (三目运算) 不要用 if else 
9.回调传值 尽可能用 闭包操作（注意循环引用）
10.渲染UI必须要到主线程
dispatch_async(dispatch_get_main_queue(), ^{
yourCode
});
或
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
yourCode
}];
11.controller中 如有自定义方法 给方法添加 方法索引：
#pragma mark - description

```
## 4.view的创建
在controller 中尽可能把子view封装起来 尽量保持controller中代码 在500行以内
## 5.文件夹创建
在项目框架中已固定以及文件夹结构 创建 MVC 文件夹（项目框架已创建一级）
最多分出三级模块 创建（Controllers + Views + Models + Mells + ViewMode(根据个人可不用创建)）





