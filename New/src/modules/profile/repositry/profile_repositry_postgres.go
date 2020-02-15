package repository

import (
	"database/sql"
)

func NewProfileRepositoryPostgres(db *sql.DB) *profileRepositoryPostgres {
	return &profileRepositoryPostgres{db}
}

func (r *profileRepositoryPostgres) Save(profile *model.Profile) error {

	query := `INSERT INTO "profile"("id", "name", "email", "password", "inserted_at", "updated_at")
		  VALUES($1, $2, $3, $4, $5, $6)`

	statement, err := r.db.Prepare(query)

	if err != nil {
		return err
	}

	defer statement.Close()

	_, err = statement.Exec(profile.ID, profile.Name, profile.Email, profile.InsertedAt, profile.UpdatedAt)

	if err != nil {
		return err
	}

	return nil
}
