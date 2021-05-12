# cue-semver

CUE based implementation of SemVer, version ranges and comparison. 

Implementation based upon [semantic versioner for npm](https://docs.npmjs.com/cli/v7/using-npm/semver).

## Usage

### Test if version string satisfies a range 

Use `#SemVer` to evaluate a version string into semantic version components. Unify it with `#SemVerSatisfies` and provide a range string. The unification will error if the version does not fall within the range.
```cue
foo: {
    version: "1.0.0"
}

foo: this={
    semVer: #SemVer&{#version: this.version} & #SemVerSatisfies&{#range: ">=1.0.0"}
}
```

## Notes

- `node-semver` `loose` option not supported.

## TODO

- Use CUE modules once complete see [Proposal: package management #851](https://github.com/cuelang/cue/issues/851).
