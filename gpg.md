# GPG

## default key or name to sign with
" https://stackoverflow.com/questions/11292196/gnupg-how-to-encrypt-decrypt-files-using-a-certain-key/11293559#11293559
`gpg --encrypt --local-user <id>`


## gpg unattended key generation
https://security.stackexchange.com/q/213709
https://gist.github.com/vrillusions/5484422


/tmp/non-interactive-gpg-key:
```
%echo Generating a OpenPGP key
%no-protection
Key-Type: eddsa
Key-Curve: Ed25519
Key-Usage: cert


---------------------- either
Subkey-Type: ecdh
Subkey-Curve: Curve25519
Subkey-Usage: encrypt

---------------------- or
Subkey-Type: eddsa
Subkey-Curve: Ed25519
Subkey-Usage: sign



Name-Real: Name_test
Name-Email: email_test@xxx.com
Name-Comment: Unattended Testing
Expire-Date: 0
%commit
```

```
$ gpg --batch --gen-key  /tmp/non-interactive-gpg-key
gpg: Generating a OpenPGP key
gpg: key BLUB marked as ultimately trusted
gpg: revocation certificate stored as '/Users/blub/.gnupg/openpgp-revocs.d/ASDFASDF.rev'
```
