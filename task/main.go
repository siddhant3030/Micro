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

func handleRequests() {
	myRouter := mux.NewRouter().StrictSlash(true)
	myRouter.HandleFunc("/", helloWorld).Methods("GET")
	myRouter.HandleFunc("/", AllPeoples).Methods("GET")
	myRouter.HandleFunc("/people/{name}/{age}", NewPeople).Methods("POST")
	log.Fatal(http.ListenAndServe(":8081", myRouter))
}

func main() {

	fmt.Println("GO orm tut")
	InitialMigration()
	handleRequests()
}
