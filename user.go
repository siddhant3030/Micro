package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/lib/pq"
)

type User struct {
	Name  string
	Email string
}

func InitialMigration() {
	connStr := "user=postgres dbname=elixirgoo sslmode=verify-full"
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		fmt.Println(err.Error())
		panic("Failed to connect to database")
	}
	defer db.Close()

	db.AutoMigrate(&User{})
}

func AllUsers(w http.ResponseWriter, r *http.Request) {
	connStr := "user=postgres dbname=elixirgoo sslmode=verify-full"
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		panic("Could not connect to database")
	}
	defer db.Close()

	var users []User
	db.Find(&users)
	json.NewEncoder(w).Encode(users)
}

func NewUser(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "User")
}
