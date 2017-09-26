# Contributing

When contributing to this repository send a new pull request.
If your change is big or complex, or you simply want to suggest an improvement,
please discuss the change you wish to make via an issue.

Please note we have a [code of conduct](CODE_OF_CONDUCT.md). Please follow it in all your interactions with the project.

## Pull Request Process

* Prefer `phar` downloads over `composer global` installations to avoid dependency conflicts.
* Update the `README.md` and `tools.json` with any new tools'd like to add.
* Ensure any install or build dependencies are removed before the end of the layer when doing a build.
* Make changes to both Debian and Alpine images (`Dockerfile` and `Dockerfile-alpine`).
* Provide a good commit message describing what you've done.
