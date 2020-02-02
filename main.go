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

var db *sql.DB

func GetBulltins() ([]Bulletin, error){
	return nil, nil
}

func AddBulletin(bulletin Bulletin) error {
	return nil
}


func main() {
	var err error
	// create a router with a default configuration
	r := gin.Default()
	// endpoint to retrieve all posted bulletins
	r.GET("/board", func(context *gin.Context) {
		results, err := GetBulletins()
		if err != nil {
			context.JSON(http.StatusInternalServerError, gin.H{"status": "internal error: " + err.Error()})
			return
		}
		context.JSON(http.StatusOK, results)
	})

	r.POST("/board", func(context *gin.Context) {
		var b Bulletin
		// reading the request's body & parsing the json
		if context.Bind(&b) == nil {
			b.CreatedAt = time.Now()
			if err := AddBulletin(b); err != nil {
				context.JSON(http.StatusInternalServerError, gin.H{"status": "internal error: " + err.Error()})
				return
			}
			context.JSON(http.StatusOK, gin.H{"status": "ok"})
			return
		}
		// if binding was not successful, return an error
		context.JSON(http.StatusUnprocessableEntity, gin.H{"status": "invalid body"})
	})
}
