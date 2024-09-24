1. Изменить ssh-ключ в файле cloud-init.yml
2. Проверить доступность хостов ansible -i ./hosts.ini all  -m ping -u user
3. Выполнить playbook ansible-playbook -i ./hosts.ini test.yml