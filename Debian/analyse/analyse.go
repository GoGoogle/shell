package main

import (
	"log"
	"net/http"
	"time"
	"os"
	"path"
	"fmt"
	"strings"
	"io"
)

// hello world, the web server
func HelloServer(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, req.RemoteAddr)
	now:=time.Now()
	dir:=os.Args[1]
	filename:=now.Format("2006.01.02.15.04.05.000000000.txt")
	filePath:=path.Join(dir,filename)
	f, err := os.Create(filePath)
	if err != nil {
		fmt.Println(err)
		return
	}
	f.WriteString(req.RemoteAddr)
	f.WriteString("\r\n")
	for k, v := range req.Header {
		f.WriteString(k+":"+strings.Join(v[:],","))
		f.WriteString("\r\n")
	}
}

func main() {
	http.HandleFunc("/analyse", HelloServer)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}