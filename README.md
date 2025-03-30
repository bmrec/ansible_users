This playbook manage users

# Create users

To create users on the servers:

* fill in information about a user in the 
[file](group_vars/all/all.yaml) in format:

```yaml
user_db:
  "user1":  # Name (login) for a user
      shell: /bin/bash  # If omitted, /bin/bash will be used by default
      github: bmrec  # Github nickname. Used for fetching ssh key
      groups:
        - root  # List of groups to which the user will be added
      expiration_date: "2025-04-22"  # Set expiration day of a user. On this 
    #  day or day later, the user will be blocked at 3 AM (optionally).
```

* set user's password in a [file](group_vars/all/user_secrets.yaml) in format:

```yaml
---
user_passwords:
  user1: "<hashed password>"
```
To hash password you can use command e.g. `mkpasswd --method=sha-512`.

>[!IMPORTANT]
>At least one - password or GitHub must be defined.

* define `create_users` variable in each group you want to create users.

* decrypt `user_secrets` file by running command 
`ansible-vault decrypt group_vars/all/user_secrets.yaml` or specify 
`--ask-vault-pass` argument when you run playbook.
The password is `Ci9Dke$d`. This is a test task, so I exposed the password here.

* run playbook `ansible-playbook users.yaml -t create`.

# Disable users

This role disables a user by setting `/usr/sbin/nologin` as shell and locks 
password (`usermod -L`).

To disable users on the servers:

* define `disable_users` variable in each group and/or hosts you want to disable 
users.

* run playbook `ansible-playbook users.yaml -t disable`.

# Planned user blocking

You can set expiration date of user by defining `expiration_date` in `user_db` 
in format `yyyy-MM-dd`. Cron job will disable user at this date at 3 AM.   
Command to run `ansible-playbook users.yaml -t disable`.
