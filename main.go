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
		`
)

type Bulletin struct {
	Author string `json:"author" binding: "required"`
	Content string `json:"content" binding: "required"`
	CreatedAt time.Time `json:"created_at" `
}

func main() {

}
