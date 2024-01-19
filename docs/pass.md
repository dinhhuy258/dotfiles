# Pass

Currently, I am using [pass](https://www.passwordstore.org/) for managing my personal passwords.

## GPG

Pass requires gpg key for encrypting passwords.

Here are some essential commands for managing your GPG keys:

**List all gpg keys**

```sh
gpg --list-keys
```

**Import gpg key**

```sh
gpg --import gpg-private.key
```

Trust gpg key if necessary. Find detailed instructions [here](https://www.gnupg.org/gph/en/manual.html#AEN346)

**Edit gpg key**

```
gpg --edit-key <fingerprint>
```

For a comprehensive list of supported commands in the edit-key mode, refer to the [official documentation](https://www.gnupg.org/gph/en/manual/r899.html).

**Safeguard your keypair by exporting it and storing it securely**

```sh
gpg --export-secret-keys --armor <fingerprint> > privkey.asc
gpg --export --armor <fingerprint> > pubkey.asc
```

## Start using pass

**Initialize Pass with your GPG key**

```sh
pass init <fingerprint>
```

**Create new password**

```sh
pass insert <pass-name>
```

**Edit a password**

```sh
pass edit <pass-name>
```

**Delete a password**

```sh
pass rm <pass-name>
```

**Rename existing password**

```sh
pass mv [--force -f] <old-path> <new-path>
```

**Managing your password-store with git**

```sh
pass git init
pass git remote add origin user@server:~/.password-store
pass git add .
pass git pull
pass git push
...
```

**Using existing password-store repository**

```sh
cd ~
git clone git@github.com:dinhhuy258/password-store.git
mv password-store .password-store
```
