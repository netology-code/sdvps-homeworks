#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop-fops"
}

#создаем подсеть zone A
resource "yandex_vpc_subnet" "develop_a" {
  name           = "develop-fops-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

#создаем подсеть zone B
resource "yandex_vpc_subnet" "develop_b" {
  name           = "develop-fops-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu_2204_lts" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "bastion" {
  name        = "bastion"  #Имя ВМ в облачной консоли
  hostname    = "bastion" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = true
  }
}


resource "yandex_compute_instance" "web_a" {
  name        = "web-a"  #Имя ВМ в облачной консоли
  hostname    = "web-a" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = false
  }
}

resource "yandex_compute_instance" "web_b" {
  name        = "web-b"  #Имя ВМ в облачной консоли
  hostname    = "web-b" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v1"
  zone        = "ru-central1-b" #ЗДЕСЬ НАМЕРЕННАЯ ОШИБКА!!! ПРАВИЛЬНО "ru-central1-b"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = false
  }
}

resource "local_file" "from_resourse" {
  content  = <<-EOF
  [bastion]
  ${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}

  [webservers]
  ${yandex_compute_instance.web_a.network_interface.0.ip_address}
  ${yandex_compute_instance.web_b.network_interface.0.ip_address}  
  [webserer:vars]
  ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q user@${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}"'
  EOF
  filename = "./hosts.ini"
}


