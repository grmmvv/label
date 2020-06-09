const core = require('@actions/core');
const github = require('@actions/github');

const buildId = core.getInput('build-id');
console.log(`Hello ${buildId}!`);
