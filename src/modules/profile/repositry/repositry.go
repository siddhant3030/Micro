package repositry

import (
	"https://github.com/siddhant3030/KubernetesApi/tree/master/src/modules/profile/module"
)

type ProfileRepository interface {
	Save(*model.Profile) error
	Update(string, *model.Profile) error
	Delete(string) error
	FindByID(string) (*model.Profile, error)
	FindAll() (model.Profiles, error)
  }