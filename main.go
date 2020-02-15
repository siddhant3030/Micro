package main

import (
	"github.com/siddhant3030/KubernetesApi/config"
	"github.com/siddhant3030/KubernetesApi/src/modules/profile/module"
	"github.com/siddhant3030/KubernetesApi/src/modules/profile/repositry"
)

func main() {
	fmt.Println("Go Postgres Tutorial")

	db, err := config.GetPostgersDB()
  
	if err != nil {
	  fmt.Println(err)
	}
  
  
	wury := model.NewProfile()
	wury.ID = "01"
	wury.Name = "Rob"
	wury.Email = "rob@yahoo.com"
	fmt.Println(wury)
  
	profileRepositoryPostgres := repository.NewProfileRepositoryPostgres(db)
  
	profiles, err := getProfiles(profileRepositoryPostgres)
  
	if err != nil {
	  fmt.Println(err)
	}
  
	fmt.Println("=======================")
  
	for _, v := range profiles {
	  fmt.Println(v)
	}
  }
  
  func saveProfile(p *model.Profile, repo repository.ProfileRepository) error{
	err := repo.Save(p)
  
	if err != nil {
	  return err
	}
  
	return nil
  }
}
