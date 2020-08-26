# wycorder-api

This is the project for the Flask REST API for the wycorder app.

## Implementation

Set up as you would any other flask app. You will need to adjust the database credentials in models/DB.py and create a new secret key for the app.

You can generate the secret key with Python.
```
import os
print(os.urandom(24))
```

The database is designed for PostgreSQL. However, you could set it up however you would like as long as the same objects exist.

When you store system_user records, use the Werkzueg package to create and store password hashes:
`werkzeug.security.generate_password_hash("PlainTextPassword", "sha256")`