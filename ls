package main

/*
	CLI to use pq:                                       > go get github.com/lib/pq
	CLI to use mux router from the Gorilla Web Toolkit:  > go get github.com/gorilla/mux
  
	SQL Script:
		CREATE TABLE Customer
		(
			CustomerId serial NOT NULL,
			CustomerName character varying(250) NOT NULL,
			CONSTRAINT CustomerId_pkey PRIMARY KEY (CustomerId)
		)
		WITH (OIDS=FALSE);
*/

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

// Customer represents a customer object
type Customer struct {
	CustomerID   int
	CustomerName string
}

// Customers represents a set of Customer
type Customers []Customer

func openDb() *sql.DB {
	db, err := sql.Open("postgres", "user=postgres password=postgres dbname=elixirgoo_dev sslmode=disable")
	if err != nil {
		panic(err)
	}
	return db
}

func createTestData() {
	db := openDb()
	db.Exec("INSERT INTO Customer(CustomerName) SELECT thename FROM unnest(ARRAY['Acme Rocket Launchers','Barry''s Dongles','No Soup 4 U','Dude where''s my database?']) thename")
	db.Close()
}

func createHTTPEndpoint() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/customers", CustomerList)
	http.ListenAndServe(":8899", router)
}

// CustomerList returns customers as JSON
func CustomerList(w http.ResponseWriter, r *http.Request) {
	customers := getCustomersFromDb()
	json.NewEncoder(w).Encode(customers)
}

func getCustomersFromDb() Customers {
	db := openDb()

	rows, err := db.Query("SELECT * FROM customer")
	if err != nil {
		panic(err)
	}

	fmt.Println("customerID | customerName")
	var customers Customers
	for rows.Next() {
		var customerID int
		var customerName string
		rows.Scan(&customerID, &customerName)
		fmt.Printf("%3v | %8v\n", customerID, customerName)
		customers = append(customers, Customer{CustomerID: customerID, CustomerName: customerName})
	}
	db.Close()
	return customers
}

func main() {
	createTestData()
	createHTTPEndpoint()
	//browse to http://localhost:8899/customers
}