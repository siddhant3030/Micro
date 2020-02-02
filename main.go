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

func GetBulletins() ([]Bulletin, error){
	const q = `SELECT author, content, created_at FROM bulletins ORDER BY created_at DESC LIMIT 100`

rows, err := db.Query(q)
if err != nil {
	return nil, err
}

results := make([]Bulletin, 0)

for rows.Next() {
	var author string
	var content string
	var createAt time.Time
	// scanning the data from the returned rows
	err = rows.Scan(&author, &content, &createAt)
	if err != nil {
		return nil, err
	}
	// creating a new result
	results = append(results, Bulletin{author, content, createAt})
}

return results, nil
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

	dbInfo := fmt.Sprintf("host=%s user=%s password=%s dbname=%s sslmode=disable", DbHost, DbUser, DbPassword, DbName)
	db, err = sql.Open("postgres", dbInfo)
	if err != nil {
		panic(err)
	}
	// do not forget to close the connection
	defer db.Close()
	// ensuring the table is created
	_, err = db.Query(Migration)
	if err != nil {
		log.Println("failed to run migrations", err.Error())
		return
	}
	// running the http server
	log.Println("running..")
	if err := r.Run(":8080"); err != nil {
		panic(err)
	}
}
