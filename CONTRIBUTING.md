# Contributing

When contributing to this repository send a new pull request.
If your change is big or complex, or you simply want to suggest an improvement,
please discuss the change you wish to make via an issue.

Please note we have a [code of conduct](CODE_OF_CONDUCT.md). Please follow it in all your interactions with the project.

## Pull Request Process

* Prefer `phar` downloads or `composer-bin-plugin` installation over `composer global` installations to avoid dependency conflicts.
* Update the `README.md` and `tools.json` with any new tools'd like to add (`php tools.php update-readme`).
* Ensure any install or build dependencies are removed before the end of the layer when doing a build.
* Make changes to both Debian and Alpine images (`Dockerfile` and `Dockerfile-alpine`).
* Provide a good commit message describing what you've done.

## Adding a new tool

To add support for a new tool, add it to the list in `tools.json`:

```json
{
  "name": "behat",
  "summary": "Helps to test business expectations",
  "website": "http://behat.org/",
  "command": {
    "composer-bin-plugin": {
      "package": "behat/behat",
      "namespace": "behat"
    }
  },
  "test": "behat --version"
}
```

Each tool should have the following properties specified:

* `name` - name of the tool, most of the time the name of executable;
* `summary` - shortly stated purpose of the tool;
* `website` - link to the tool's website;
* `command` - the command to install the tool. See supported commands below;
* `test` - the command to verify if the tool is installed. Most of the time it will be the command to show the version or help;

Once you added a new tool to the list, update the list in `README.md` by running the following command:

```bash
php tools.php update-readme
```

### Commands

There are several supported ways to install tools in the phpqa image.
All of them are listed below in order of preference.

#### composer-bin-plugin

The `composer-bin-plugin` method Uses [bamarni/composer-bin-plugin](https://github.com/bamarni/composer-bin-plugin)
to install the package in isolated directory.
Thanks to the isolation we're less likely to run into problem with conflicting dependencies between tools.

```json
{
  "command": {
    "composer-bin-plugin": {
      "package": "behat/behat",
      "namespace": "behat"
    }
  }
}
```

#### phar-download

Downloads a phar from the given URL and puts it into the specified location.

```json
{
  "command": {
    "phar-download": {
      "phar": "https://github.com/phpspec/phpspec/releases/download/4.3.0/phpspec.phar",
      "bin": "/usr/local/bin/phpspec"
    }
  }
}
```

#### file-download

Downloads a file from the given URL and puts it into the specified location.

```json
{
  "command": {
    "file-download": {
      "url": "https://github.com/vimeo/psalm/releases/download/2.0.0/psalm.phar.asc",
      "file": "/usr/local/bin/psalm.phar.asc"
    }
  }
}
```

#### box-build

Uses [box](https://box-project.github.io/box2/) to build a phar and puts it into the specified location.
It will clone the given repository and checkout the latest tag if available.

```json
{
  "command": {
    "box-build": {
      "repository": "https://github.com/behat/behat.git",
      "phar": "behat.phar",
      "bin": "/usr/local/bin/behat"
    }
  }
}
```

#### composer-global-install

Uses the `composer global require` command to install a composer package globally.

```json
{
  "command": {
    "composer-global-install": {
      "package": "bmitch/churn-php"
    }
  }
}
```

#### composer-install

Clones the specified repository, checkouts the latest tag (if available), and runs `composer install` inside.
Mostly useful for applications.

```json
{
  "command": {
    "composer-install": {
      "repository": "https://github.com/Qafoo/QualityAnalyzer.git"
    }
  }
}
```

#### Executing multiple commands

It's sometimes useful to run multiple installation commands i.e. when downloading a phar and its signature.

```json
{
  "command": {
    "file-download": {
      "url": "https://github.com/vimeo/psalm/releases/download/2.0.0/psalm.phar.asc",
      "file": "/usr/local/bin/psalm.phar.asc"
    },
    "phar-download": {
      "phar": "https://github.com/vimeo/psalm/releases/download/2.0.0/psalm.phar",
      "bin": "/usr/local/bin/psalm"
    }
  }
}
```