package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func helloWorld(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World")
}

func handleRequests() {
	myRouter := mux.NewRouter().StrictSlash(true)
	myRouter.HandleFunc("/", helloWorld).Methods("GET")
	log.Fatal(http.ListenAndServe(":8081", myRouter))
}

func main() {

	db, err := gorm.Open("postgres", "user=postgres password=postgres dbname=gorm sslmode=disable")

	if err != nil {
		panic(err.Error())
	}

	defer db.Close()

	database := db.DB()

	err = database.Ping()

	if err != nil {
		panic(err.Error())
	}

	fmt.Println("Connection was successfull")
}
