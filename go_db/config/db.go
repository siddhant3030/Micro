package config

import (
	"log"
	"os"

	"github.com/go-pg/pg/v9"

	controllers "github.com/siddhant3030/go_db/controllers"
)

// Connecting to db
func Connect() *pg.DB {
	opts := &pg.Options{
		User:     "postgres",
		Password: "postgres",
		Addr:     "localhost:5432",
		Database: "users",
	}

	var db *pg.DB = pg.Connect(opts)
	if db == nil {
		log.Printf("Failed to connect")
		os.Exit(100)
	}
	log.Printf("Connected to db")
	controllers.CreateTodoTable(db)
	controllers.InitiateDB(db)
	return db
}
