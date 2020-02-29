package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/gorilla/mux"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var db *gorm.DB
var err error

type User struct {
	gorm.Model
	Name  string
	Email string
}

func InitialMigration() {
	db, err = gorm.Open("postgres", "user=postgres password=postgres dbname=test sslmode=disable")
	if err != nil {
		fmt.Println(err.Error())
		panic("Failed to connect to database")
	}
	defer db.Close()

	db.AutoMigrate(&User{})
}

// logic for getting all the user
func AllUsers(w http.ResponseWriter, r *http.Request) {
	db, err = gorm.Open("postgres", "user=postgres password=postgres dbname=test sslmode=disable")
	if err != nil {
		panic("Could not connect to database")
	}
	defer db.Close()

	var users []User
	db.Find(&users)
	json.NewEncoder(w).Encode(users)
}

// insert function
func NewUser(w http.ResponseWriter, r *http.Request) {
	db, err = gorm.Open("postgres", "user=postgres password=postgres dbname=test sslmode=disable")
	if err != nil {
		panic("Could not connect to database")
	}
	defer db.Close()

	vars := mux.Vars(r)
	name := vars["name"]
	email := vars["email"]

	db.Create(&User{Name: name, Email: email})
	fmt.Fprintf(w, "new user successfully created")
}
