package main

import (
	"fmt"
	"github.com/urfave/cli"
	"os"
)

type Plot struct {
	Name string
}

func main() {
	app := cli.NewApp()
	app.Name = "hatch"
	app.Usage = "Hatch a new project."

	app.Action = func(c *cli.Context) error {
		fmt.Println(c.String("plot"))
		return nil
	}

	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:  "plot",
			Value: "default",
			Usage: "plot to hatch",
		},
	}

	app.Run(os.Args)
}
