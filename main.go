package main

import (
	"encoding/json"
	"github.com/gorilla/mux"
	logs "github.com/sirupsen/logrus"
	"net/http"
)

func main() {
	router := mux.NewRouter()

	router.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		logs.Infof("Hello Echo Web Server")
		json.NewEncoder(w).Encode("Hello Echo Web Server")
	})

	router.HandleFunc("/version", func(w http.ResponseWriter, r *http.Request) {
		logs.Infof("Hello Echo Web Server v2.0 @oversea")
		json.NewEncoder(w).Encode("Hello Echo Web Server v2.0 @oversea")
	})

	http.ListenAndServe(":8080", router)
}
