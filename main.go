package main

import (
    "net/http"
    "encoding/json"

    "github.com/gorilla/mux"
)

func main() {
    router := mux.NewRouter()

    router.HandleFunc("/version", func(w http.ResponseWriter, r *http.Request) {
        json.NewEncoder(w).Encode("Hello World Version One")
    })

    http.ListenAndServe(":8080", router)
}
