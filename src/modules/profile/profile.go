package profile

import (
	"math/big"
	"time"
)

type Profile struct {
	ID         big.Int
	Name       string
	Email      string
	InsertedAt time.Time
	UpdatedAt  time.Time
}
