# ASDF

Currently, I am using [asdf](https://asdf-vm.com/) for efficient runtime version management.

## Node

First we need to install nodejs plugin

```sh
asdf plugin add nodejs
```

Installation of Node requires GnuPG, the GNU Privacy Guard, to verify the authenticity of the downloaded files.

```sh
brew install gnupg
```

Download and install authentication keys (to assure the Node files are authentic):

```sh
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
```

Install nodejs version

```sh
asdf install nodejs <version>
asdf install nodejs lastest
```

Specify default nodejs version

```sh
asdf global nodejs 16.3.0
```

To override the default version of nodejs for a particular project, move into the project root directory and enter the following command:

```sh
asdf local nodejs 16.3.0
```

## Yarn

```sh
asdf plugin add yarn
```

```sh
asdf list all yarn
```

```sh
asdf install yarn latest
asdf install yarn <version>
```

```sh
asdf global yarn 1.22.10
```

## Ruby

```sh
asdf plugin add ruby
```

```sh
asdf list all ruby
```

```sh
asdf plugin-update ruby
```

```sh
asdf install ruby latest
asdf install ruby <version>
```

```sh
asdf list ruby
```

```sh
asdf global ruby 3.3.0
asdf local ruby 2.7.3
```
