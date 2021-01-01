package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/tcnksm/go-input"
)

func ExitIfError(err error, statusCode int) {
	if err == nil {
		return
	}

	fmt.Println(err)
	os.Exit(statusCode)
}

func main() {
	userHomeDir, err := os.UserHomeDir()

	ExitIfError(err, 1)

	currentDir, err := os.Getwd()

	ExitIfError(err, 1)

	dotfiles := []string{}

	err = filepath.Walk("dotfiles", func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if !info.IsDir() {
			dotfiles = append(dotfiles, filepath.Join(currentDir, path))
		}

		return nil
	})

	ExitIfError(err, 1)

	ui := &input.UI{
		Writer: os.Stdout,
		Reader: os.Stdin,
	}

	response, err := ui.Ask("Symlink dotfiles?", &input.Options{
		Required: true,
		Loop:     true,
		ValidateFunc: func(input string) error {
			downcasedInput := strings.ToLower(input)

			if downcasedInput != "y" && downcasedInput != "n" {
				return fmt.Errorf("please enter y or n")
			}

			return nil
		},
	})

	ExitIfError(err, 1)

	if response == "n" {
		fmt.Println("Not copying dotfiles. Exiting")
		os.Exit(0)
	}

	for _, dotfile := range dotfiles {
		baseFilename := filepath.Base(dotfile)
		newFilepath := filepath.Join(userHomeDir, baseFilename)

		err = os.Symlink(dotfile, newFilepath)

		ExitIfError(err, 1)

		fmt.Printf("Symlinked %q to %q", dotfile, newFilepath)
	}
}
