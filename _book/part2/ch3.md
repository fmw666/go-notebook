# goroutine

用关键字 go 启动：

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	GoRoutine()
}

func GoRoutine() {
	go func() {
		time.Sleep(10 * time.Second)
	}()

    // 不会等待 10 秒才执行
	fmt.Println("I am here")
}
```
