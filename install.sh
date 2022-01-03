#!/bin/bash

ansible-playbook -i inventory/localhost.yml localhost.yml --ask-become-pass -vvv