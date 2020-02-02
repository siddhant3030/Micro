package main

import (
	_ "github.com/lib/pq"
)

const (
	DbHost = "db"
	DbUser = "postgres-dev"
	DbPassword = "mysecretpassword"
	DbName = "dev"
	Migration = `CREATE TALBE IF NOT EXISTS bulletins (
		id serial PRIMARY KEY
		author text NOT NULL,
		content text NOT NULL,
		created_at timestamp with time zone DEFAULT current_timestamp
		)`
)

func main() {
	
}
