
# 练习

## 1.Modifier 顺序的影响

在 CalculatorButton 中，我们使用了一系列的 modifiler 来定义按钮和文本的样式：

```swift
var body: some View {
  Button(action: action) {
    Text(title)
      .font(.system(size: fontSize))
      .foregroundColor(.white)
      .frame(width: size.width, height: size.height)
      .background(Color(backgroundColorName))
      .cornerRadius(size.width / 2)
  }
}
```

我们可以调换 background 和 cornerRadius 的顺序吗？试试看它会造成什么影响， 并且对结果进行解释说明。另外，我们可以调换 font 和 foregroundColor 的顺序吗？ 它又会有怎么样的影响？

> 答案: **不可以**调换 background 和 cornerRadius 的顺序，因为它们两个是封装类 modifier, 对顺序敏感。如果调换顺序， cornerRadius 的效果不会作用在 background，也就是 background 的 modifier 返回的 view 上不会存在圆角  
>
> **可以**调换 font 和 foregroundColor 的顺序，因为它们两个一个是原地 modifier ，一个是封装类 modifier，对顺序不敏感

## 4. 使用 frame 和 Spacer 进行填充

本章示例中，最终选择了如下布局方式：

```swift
VStack(spacing: 12) {
  Spacer()
  Text("0")
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
  CalculatorButtonPad()
    .padding(.bottom)
}
```

1. 我们用 Spacer 的方法完成将整个界面推至屏幕底部。
2. 用 frame 方法对用于显示结果的 Text 进行了右对齐。

这两种方式在某种程度上来说是 “等效的”，请尝试改变原来的代码，使用 frame 的 方式完成界面下推，使用 Spacer 的方式实现文本右对齐。同时，请解释一下两种 “占满界面” 的方式有什么异同？它们分别适用于怎么样的场景？(比如多个 Spacer 时的行为，给定不同参数时 frame 表现的差异等。)

> 答案：采用下面的方式进行布局，相比于书中的“占满方式”，这种布局是在原有的 VStack 里嵌入了 HStack，左边的 Spacer 控制整体的高度并将文字挤到最右边。
> 对于两种布局方式，书中的布局方式在纵向的精确布局上会占优，而解答里的布局方式在横向的精确布局上会更占优。

```swift
VStack(spacing: 12) {
  HStack(alignment: .bottom) {
    Spacer().frame(
        minHeight: 1,
        maxHeight: .infinity)
      Text("0")
        .font(.system(size: 76))
        .minimumScaleFactor(0.5)
        .padding(.trailing, 24)
        .lineLimit(1)
        }
    CalculatorButtonPad()
    }.scaleEffect(scale)
}
```

## 5. 验证 Dark Mode

现有情况下 app 是不是已经能很好地适配 Dark Mode？如果我们为 ContentView 中 的 Text 设定一个 foregroundColor 的话 (比如 .black)，它是否还能适配 Dark Mode？将这个颜色改为 .primary 呢？

> 答：目前没有做 Dark Mode 的适配，如果只是设置成 .black 的话，颜色不会适配，如果设置成 .primary 会进行自动适配，这部分的详细信息可以阅读 HIG 和 SDK 里的内容。

