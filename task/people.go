package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var db *gorm.DB
var err error

func InitialMigration() {
	db, err = gorm.Open("postgres", "test.db")
	if err != nil {
		fmt.Println(err.Error())
		panic("Failed to connect to database")
	}
	defer db.Close()

	db.AutoMigrate(&People{})
}

type People struct {
	gorm.Model
	Name string
	Age  int
}

func AllPeoples(w http.ResponseWriter, r *http.Request) {
	db, err = gorm.Open("postgres", "test.db")
	if err != nil {
		panic("Could not connect to database")
	}
	defer db.Close()

	var peoples []People
	db.Find(&peoples)
	json.NewEncoder(w).Encode(peoples)
}

func NewPeople(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World")
}
