# mac-setup-playbook
Mac setup Ansible playbook

## Usage

### install all

```bash
./install.sh
```

### specify tags

```bash
ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass --tags brew
ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass --tags brew-cask
ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass --tags dotfiles
ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass --tags neovim
ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass --tags anyenv
ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass --tags sdkman
ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass --tags aws
```