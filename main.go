package main

import (
	"fmt"
)

func main() {
	power := 9000
	fmt.Printf("It's over %d\n", power)

	// COMPILER ERROR:
	// no new variables on left side of :=
	power := 9001
	fmt.Printf("It's also over %d\n", power)
}
