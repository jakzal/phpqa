# Contributing

When contributing to this repository send a new pull request.
If your change is big or complex, or you simply want to suggest an improvement,
please discuss the change you wish to make via an issue.

Please note we have a [code of conduct](CODE_OF_CONDUCT.md). Please follow it in all your interactions with the project.

## Pull Request Process

* Add any new tools to the [`jakzal/toolbox` repository](https://github.com/jakzal/toolbox)
* Provide a good commit message describing what you've done.
* Ensure any install or build dependencies are removed before the end of the layer when doing a build.
* Make changes to both Debian and Alpine docker file templates (`Dockerfile-debian` and `Dockerfile-alpine`).
  Once you made your changes, regenerate docker files with `make generate`.
