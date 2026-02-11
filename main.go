package main

import (
	"fmt"
	"net/http"
	"os"
	"runtime"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from Ko! Running on %s/%s\n", runtime.GOOS, runtime.GOARCH)
	fmt.Fprintf(w, "Pod Name: %s\n", os.Getenv("POD_NAME"))
	config, err := os.ReadFile("/var/run/ko/config.txt")
	if err != nil {
		fmt.Println("Error reading config file:", err)
		return
	}
	fmt.Println("Config:", string(config))
}

func main() {
	// 读取 /var/run/ko/config.txt 文件
	config, err := os.ReadFile("/var/run/ko/config.txt")
	if err != nil {
		fmt.Println("Error reading config file:", err)
		return
	}

	fmt.Println("Config:", string(config))
	fmt.Println(os.Getenv("POD_NAME"))
	fmt.Println("hello world")
	fmt.Println("hello wochong")
	fmt.Println("Server starting on port 8080...")
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
