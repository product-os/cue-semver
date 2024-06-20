package semver

import (
	"regexp"
	"strings"
	"strconv"
)

#Range: {
	#range: string
	range: (#hyphenReplace&{#incPr: false, #matches: regexp.FindAllSubmatch(patterns.HYPHENRANGE, #range, -1)[0]})
}

#isX: {
	#id: string
	#return: [
		if #id == "" { true },
		if strings.ToLower(#id) == "x" { true },
		if #id == "*" { true },
		false
	][0]
}

#hyphenReplace: {
	#incPr: bool
	#matches: [string, string, string, string, string, string, string, string, string, string, string, string, string]
	#$0: #matches[0]
	#from: #matches[1]
	#fM: #matches[2]
	#fm: #matches[3]
	#fp: #matches[4]
	#fpr: #matches[5]
	#fb: #matches[6]
	#to: #matches[7]
	#tM: #matches[8]
	#tm: #matches[9]
	#tp: #matches[10]
	#tpr: #matches[11]
	#tb: #matches[12]
	#fromNew: [
		if (#isX&{#id: #fM}).#return { "" },
		if #incPr {
			if (#isX&{#id: #fm}).#return != _|_ { ">=\(#fM).0.0-0" },
            if (#isX&{#id: #fp}).#return != _|_ { ">=\(#fM).\(#fm).0-0" },
            if #fpr != "" { ">=\(#from)" },
            ">=\(#from)-0",
		},
		if !#incPr {
			if (#isX&{#id: #fm}).#return != _|_ { ">=\(#fM).0.0" },
			if (#isX&{#id: #fp}).#return != _|_ { ">=\(#fM).\(#fm).0" },
			if #fpr != "" { ">=\(#from)" },
			">=\(#from)"
		},
	]
//   if (isX(fM)) {
//     from = ''
//   } else if (isX(fm)) {
//     from = `>=${fM}.0.0${incPr ? '-0' : ''}`
//   } else if (isX(fp)) {
//     from = `>=${fM}.${fm}.0${incPr ? '-0' : ''}`
//   } else if (fpr) {
//     from = `>=${from}`
//   } else {
//     from = `>=${from}${incPr ? '-0' : ''}`
//   }
	#toNew: [
		if (#isX&{#id: #tM}).#return { "" },
		if (#isX&{#id: #tm}).#return { "<\(strconv.Atoi(#tM) + 1).0.0-0" },
		if (#isX&{#id: #tp}).#return { "<\(#tM).\(strconv.Atoi(#tm) + 1).0-0" },
		if #tpr != "" { "<=\(#tM).\(#tm).\(#tp)-\(#tpr)" },
		if #incPr { "<=\(#tM).\(#tm).\(strconv.Atoi(#tp) + 1)-0" },
		if !#incPr { "<=\(#to)" }
	]
//   if (isX(tM)) {
//     to = ''
//   } else if (isX(tm)) {
//     to = `<${+tM + 1}.0.0-0`
//   } else if (isX(tp)) {
//     to = `<${tM}.${+tm + 1}.0-0`
//   } else if (tpr) {
//     to = `<=${tM}.${tm}.${tp}-${tpr}`
//   } else if (incPr) {
//     to = `<${tM}.${tm}.${+tp + 1}-0`
//   } else {
//     to = `<=${to}`
//   }
	#return: "\(#fromNew[0]) \(#toNew[0])"
//	#return: "\(#from) \(#to)"
}

range: #Range&{#range: "5.1.* - 7.2.3"}
