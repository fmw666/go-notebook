# channel

带缓存和不带缓存：

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	channelWithoutCache()
	channelWithCache()
}

func channelWithoutCache() {
	ch := make(chan string, 1)
	go func() {
		ch <- "Hello, first msg from channel"
		time.Sleep(time.Second)
		ch <- "Hello, second msg from channel"
	}()

	time.Sleep(2 * time.Second)
	msg := <-ch
	fmt.Println(time.Now().String() + msg)
	msg = <-ch
	fmt.Println(time.Now().String() + msg)
	// 因为前面我们先睡了 2 秒，而且其实会有一个已经在缓冲了
	// 当我们尝试输出的时候，这个输出间隔会明显小于 1 秒
}

func channelWithCache() {
	// 不带缓冲
	ch := make(chan string)
	go func() {
		time.Sleep(time.Second)
		ch <- "Hello, msg from channel"
	}()

	msg := <-ch
	fmt.Println(msg)
}
```

select 顺序是不定的：

```go
func Select() {
	ch1 := make(chan string)
	ch2 := make(chan string)

	go func() {
		time.Sleep(time.Second)
		ch1 <- "msg from channel1"
	}()

	go func() {
		time.Sleep(time.Second)
		ch2 <- "msg from channel2"
	}()

	// select 在同时的情况下，不保证顺序
	for i := 0; i < 2; i++ {
		select {
		case msg := <-ch1:
			fmt.Println(msg)
		case msg := <-ch2:
			fmt.Println(msg)
		}
	}
}
```
