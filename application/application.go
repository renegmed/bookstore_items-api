package application

import (
	"log"
	"net/http"
	"time"

	"bookstore_items-api/clients/elasticsearch"

	"github.com/gorilla/mux"

	"github.com/renegmed/bookstore_utils-go/logger"
)

var (
	router = mux.NewRouter()
)

func StartApplication(addr, esAddr string) {

	log.Println("...Starting application with address:", addr)

	elasticsearch.Init(esAddr)

	mapUrls()

	srv := &http.Server{
		Addr: addr,
		// Good practice to set timeouts to avoid Slowloris attacks.
		WriteTimeout: 500 * time.Millisecond,
		ReadTimeout:  2 * time.Second,
		IdleTimeout:  60 * time.Second,
		Handler:      router,
	}

	log.Println("Starting application server..at port ", srv.Addr)

	logger.Info("about to start the application...")
	if err := srv.ListenAndServe(); err != nil {
		panic(err)
	}
}
