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
	"encoding/json"
	"fmt"
	"net/http"
	"regexp"
	"runtime"
	"strings"

	"github.com/spf13/cobra"
)

type assetReturn struct {
	Name        string `json:"name"`
	URL         string `json:"url"`
	ContentType string `json:"type"`
	Tag         string `json:"tag"`
}

type filterFunc func(asset assetReturn) bool

func filterPlatform(asset assetReturn) bool {
	debugPrint("Filter: %s | Name: %s\n", assetPlatform, asset.Name)
	matched, err := regexp.MatchString(assetPlatform, strings.ToLower(asset.Name))
	if err != nil {
		return false
	}
	return matched
}

func filterShaFiles(asset assetReturn) bool {
	f := strings.HasSuffix(asset.URL, ".sha256")
	debugPrint("Filter: %s | Name: %s | Result: %v\n", "sha256", asset.Name, f)
	return !f
}

func filterArchitecture(asset assetReturn) bool {
	var arch string
	switch runtime.GOARCH {
	case "amd64":
		arch = "amd64|x86_64|x8664|64bit"
	}
	debugPrint("Filter: %s | Name: %s\n", arch, asset.Name)
	matched, err := regexp.MatchString(arch, strings.ToLower(asset.Name))
	if err != nil {
		return false
	}
	return matched
}

func filterAssets(assets []assetReturn, filter filterFunc) []assetReturn {
	debugPrint("Filtering results\n")
	var ret []assetReturn
	for _, a := range assets {
		if filter(a) {
			ret = append(ret, a)
		}
	}
	return ret
}

var (
	// Vars
	assetAll      bool
	prerelease    bool
	assetPlatform string
	ghHost        string
	ghOwner       string
	ghRepo        string
	// Commands
	githubCmd = &cobra.Command{
		Use:     "github",
		Aliases: []string{"gh"},
		Short:   "Various text helpers",
	}
	getCmd = &cobra.Command{
		Use:     "get",
		Aliases: []string{"g"},
		Short:   "Several options to get data from GitHub",
	}
	getAssetURLCmd = &cobra.Command{
		Use:   "asset",
		Short: "Download an asset from a GitHub release",
		RunE: func(cmd *cobra.Command, args []string) error {
			if ghOwner == "" || ghRepo == "" {
				return fmt.Errorf("no Repo and/or Owner specified")
			}
			ret := getLatestAssetContent()
			if assetAll {
				b, e := json.Marshal(ret)
				if e != nil {
					return e
				}
				fmt.Printf("%s\n", string(b))
			} else {
				assets := filterAssets(ret, filterPlatform)
				assets = filterAssets(assets, filterShaFiles)
				if len(assets) > 1 {
					assets = filterAssets(assets, filterArchitecture)
				}
				b, e := json.Marshal(assets)
				if e != nil {
					return e
				}
				fmt.Printf("%s\n", string(b))
			}
			return nil
		},
	}
)

func getLatestAssetContent() []assetReturn {
	ret := []assetReturn{}
	ghURL := fmt.Sprintf("https://%s/repos/%s/%s/releases", ghHost, ghOwner, ghRepo)
	if !prerelease {
		ghURL += "/latest"
	}
	debugPrint("Getting information from %s\n", ghURL)
	resp, httpErr := http.Get(ghURL)
	if httpErr != nil {
		debugPrint("HTTP Get failed %v\n", httpErr)
		return ret
	}
	if resp.StatusCode > 399 {
		debugPrint("HTTP Response failed %v\n", resp.Status)
		return ret
	}
	defer resp.Body.Close()
	m := make(map[string]interface{})
	jsonErr := json.NewDecoder(resp.Body).Decode(&m)
	if jsonErr != nil {
		debugPrint("Failed to marshal JSON %v\n", jsonErr)
		return ret
	}
	tagName := m["tag_name"].(string)
	assets := m["assets"].([]interface{})

	for _, asset := range assets {
		a := asset.(map[string]interface{})
		ret = append(ret, assetReturn{
			Name:        a["name"].(string),
			URL:         a["browser_download_url"].(string),
			Tag:         tagName,
			ContentType: a["content_type"].(string),
		})
	}

	return ret
}

func getPlatform() string {
	switch runtime.GOOS {
	case "darwin":
		return "darwin|macos|osx"
	default:
		return ""
	}
}

func init() {
	getAssetURLCmd.Flags().StringVarP(&assetPlatform, "platform-regex", "p", getPlatform(), "Download only assets that contain this platform designation")
	getAssetURLCmd.Flags().BoolVarP(&assetAll, "all", "a", false, "Downloads all assets regardless of what platform its for")
	getAssetURLCmd.Flags().BoolVarP(&prerelease, "prerelease", "e", false, "Include pre-release assets to be considered as latest")

	githubCmd.PersistentFlags().StringVar(&ghHost, "host", "api.github.com", "GitHub instance to query")
	githubCmd.PersistentFlags().StringVar(&ghOwner, "owner", "", "Owner to query")
	githubCmd.PersistentFlags().StringVar(&ghRepo, "repo", "", "Repository to query")

	getCmd.AddCommand(getAssetURLCmd)
	githubCmd.AddCommand(getCmd)
	rootCmd.AddCommand(githubCmd)
}
