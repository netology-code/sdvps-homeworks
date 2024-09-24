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
  route_table_id = yandex_vpc_route_table.rt.id
}

#создаем подсеть zone B
resource "yandex_vpc_subnet" "develop_b" {
  name           = "develop-fops-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}


resource "yandex_vpc_gateway" "nat_gateway" {
  name = "fops-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "fops-route-table"
  network_id =  yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}