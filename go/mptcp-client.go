package main

import (
	"log"
	"net"
	"os"
	"time"
)

func main() {
	addr := os.Args[1]

	d := &net.Dialer{}
	d.SetMultipathTCP(true)
	conn, err := d.Dial("tcp", addr)
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	tcp, ok := conn.(*net.TCPConn)
	if !ok {
		log.Fatal("struct is not a TCPConn")
	}

	/* This API is still under discussion: https://go.dev/issue/59166
	mptcp, err := tcp.MultipathTCP()
	if err != nil {
		log.Fatal(err)
	}
	*/mptcp := tcp != nil

	log.Printf("connection to %s mptcp %t", addr, mptcp)

	time.Sleep(time.Second)

	conn.Close()
}
