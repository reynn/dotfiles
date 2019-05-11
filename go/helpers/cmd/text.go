// Copyright © 2019 Nic Patterson <arasureynn@gmail.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cmd

import (
	"fmt"
	"strings"
	"strconv"

	"github.com/spf13/cobra"
)

var (
	// Vars
	delimiter string
	replaceCount string
	replaceSubstring string
	replaceReplacement string

	// Commands
	textCmd = &cobra.Command{
		Use:   "text",
		Short: "Various text helpers",
	}
	splitCmd = &cobra.Command{
		Use:   "split",
		Short: "Split a string by the provided delimiter",
		RunE: func(cmd *cobra.Command, args []string) error {
			if len(args) == 0 {
				return fmt.Errorf("Unable to execute no provided string")
			}
			for _, t := range strings.Split(strings.Join(args, " "), delimiter) {
				fmt.Printf("%s\n", t)
			}
			return nil
		},
	}
	replaceCmd = &cobra.Command{
		Use: "replace",
		Short: "Replace text in a string",
		RunE: func(cmd *cobra.Command, args []string) error {
			text := strings.Join(args, " ")
			count := -1
			if replaceCount != "-1" {
				i, e := strconv.Atoi(replaceCount)
				if e == nil {
					count = i
				}
			}
			fmt.Printf(strings.Replace(text, replaceSubstring, replaceReplacement, count) + "\n")
			return nil
		},
	}
)

func init() {
	splitCmd.Flags().StringVarP(&delimiter, "delimiter", "d", " ", "The delimiter to use when spliting the string")
	replaceCmd.Flags().StringVarP(&replaceCount, "count", "i", "-1", "The amount or times the substring will replace")
	replaceCmd.Flags().StringVarP(&replaceSubstring, "substring", "s", "\\", "The text that will be replaced")
	replaceCmd.Flags().StringVarP(&replaceReplacement, "replacement", "r", "-", "What will replace the substring")

	textCmd.AddCommand(splitCmd, replaceCmd)
	rootCmd.AddCommand(textCmd)
}
