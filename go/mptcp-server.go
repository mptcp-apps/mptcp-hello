package main

import (
	"context"
	"log"
	"net"
	"os"
)

func main() {
	addr := os.Args[1]

	lc := &net.ListenConfig{}
	lc.SetMultipathTCP(true)

	ln, err := lc.Listen(context.Background(), "tcp", addr)
	if err != nil {
		log.Fatal(err)
	}
	defer ln.Close()

	for {
		conn, err := ln.Accept()
		if err != nil {
			log.Fatal(err)
		}

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

		log.Printf("connection from %s mptcp %t", addr, mptcp)

		conn.Close()
	}
}
