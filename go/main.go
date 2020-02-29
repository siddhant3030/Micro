package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func helloWorld(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World")
}

// handle all the request
func handleRequests() {
	myRouter := mux.NewRouter().StrictSlash(true)
	myRouter.HandleFunc("/", helloWorld).Methods("GET")
	myRouter.HandleFunc("/users", AllUsers).Methods("GET")
	myRouter.HandleFunc("/users/{name}/{email}", NewUser).Methods("POST")
	log.Fatal(http.ListenAndServe(":8081", myRouter))
}

// code starting point
func main() {

	fmt.Println("GO orm tut")
	InitialMigration()
	handleRequests()
}
