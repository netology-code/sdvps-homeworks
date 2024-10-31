1. Создать сервисный аккаунт в облаке. Выдать права editor
2. Выпустить авторизованный ключ для этого аккаунта. 
3. Вписать в переменные cloud_id и folder_id в variables.tf
4. Изменить ssh-ключ в файле cloud-init.yml (ssh-keygen -t ed25519)
5. terraform apply
6. Выполнить playbook ansible-playbook -i ./hosts.ini test.yml

https://www.jeffgeerling.com/blog/2022/using-ansible-playbook-ssh-bastion-jump-host

Настройка доступа по ssh через ssh config: 
~/.ssh/config
```
Host 51.250.80.97  #адрес вашего бастиона
   User user

Host 10.0.*
        ProxyJump 51.250.80.97
        User user
```

Или более простой для понимания, но менее удобный для частого применения: ssh -J <jump server> <remote server>
