package semver

import (
	"regexp"
	"strings"
	"strconv"
)

#SemVer: {
	version: string

	let matches = regexp.FindAllSubmatch(patterns.FULL, version, -1)
	//TODO: handle failed match
	major: strconv.Atoi(matches[0][1])
	minor: strconv.Atoi(matches[0][2])
	patch: strconv.Atoi(matches[0][3])
	if matches[0][4] == "" {
		prerelease: []
	}
	if matches[0][4] != "" {
		prerelease: [for id in strings.Split(matches[0][4], ".") {
			if regexp.Find("^[0-9]+$", id) != _|_ { strconv.Atoi(id) }
			if regexp.Find("^[0-9]+$", id) == _|_ { id }
		}]
	}
	if matches[0][5] == "" {
		build: []
	}
	if matches[0][5] != "" {
		build: [strings.Split(matches[0][5], ".")]
	}
}
