# string 长度

注意下面代码及其输出：

```go
println(len("你好"))  // 6
println(utf8.RuneCountInString("你好"))  // 2
println(utf8.RuneCountInString("你好ab"))  // 4
```

len(str) 获取字节长度，和编码无关。

RuneCountInString 获取字符数量，和编码有关。
