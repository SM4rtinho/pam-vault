# pam-vault

A simple Bash-based password manager for securely storing and retrieving credentials using AES-256 encryption.

## Features

- Add credentials with service name, username, and password
- AES-256 encrypted local storage
- Master password required only once at startup
- View all saved credentials in decrypted form
- Lightweight and dependency-free (uses `openssl`)

## Usage

```bash
chmod +x vault.sh
./vault.sh
```

### Menu options:

1. Add credential  
2. List credentials  
3. Exit

## Encryption

Passwords are encrypted with `openssl` using AES-256-CBC and a master password. This password is required only once at launch and used for both encryption and decryption during the session.

## Requirements

- Bash
- OpenSSL

## Notes

- Credentials are stored in `vault.db`
- Do **not** push `vault.db` to GitHub. Add it to `.gitignore`:
  
```bash
echo "vault.db" >> .gitignore
```

## License

MIT
