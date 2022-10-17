package main

import (
	"encoding/json"
	logs "github.com/sirupsen/logrus"
	"net/http"

	"github.com/gorilla/mux"
)

func main() {
	router := mux.NewRouter()

	router.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		logs.Infof("Hello Echo Server")
		json.NewEncoder(w).Encode("Hello Echo Server")
	})

	router.HandleFunc("/version", func(w http.ResponseWriter, r *http.Request) {
		logs.Infof("Hello Echo Server v1.0")
		json.NewEncoder(w).Encode("Hello Echo Server v1.0")
	})

	http.ListenAndServe(":8080", router)
}
