package models

// Users - Model for the uses table
type Users struct {
	UserId   int    `json:"user_id" orm:"auto"`
	Email    string `json:"email" orm:"size(128)"`
	Password string `json:"password" orm:"size(64)"`
	UserName string `json:"user_name" orm:"size(32)"`
}
