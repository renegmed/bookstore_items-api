package main

import (
	"bookstore_items-api/application"
	"flag"
	"log"
	"os"
)

var usageStr = `
Usage: bookstore items API

Options:
	-a, --addr 				Server URL example: localhost:8080 
	-e, --elasticsearchhost Elasticsearch host address: localhost:9200
`

func usage() {
	log.Printf("%s\n", usageStr)
	os.Exit(0)
}

var (
	addr   string
	esAddr string
)

func init() {
	flag.StringVar(&addr, "a", "localhost:8084", "Application server address")
	flag.StringVar(&esAddr, "e", "http://127.0.0.1:9200", "Elasticsearch host address")
}

func main() {

	log.SetFlags(0)

	flag.Usage = usage
	flag.Parse()

	log.Println("...addr", addr, "  esAddr", esAddr)

	application.StartApplication(addr, esAddr)
}
