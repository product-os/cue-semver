import * as path from 'path';
import { expect } from './chai';
import cue from 'cuelang-js';

describe('cue', function () {
	it('should parse version string to semver', async function () {
		const fixturePath = path.join(__dirname, './fixtures/version-to-semver.cue')
		const semverPath = path.join(__dirname, '../lib/semver.cue')
		const regexpPath = path.join(__dirname, '../lib/regexp.cue')
		const result = await cue('export', [fixturePath, semverPath, regexpPath], {"--inject": "version=1.2.3-alpha+build.1", "-e": "out"})
		expect(result.code).to.equal(0)
		const semver = JSON.parse(result.stdout)
		expect(semver.major).to.equal(1)
	});
});
