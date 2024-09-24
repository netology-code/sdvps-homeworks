terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version="0.129.0"
    }
  }

  # backend "s3" {
    
  #   region="ru-central1"

  #   bucket  = "tfstate-develop" #use FIO-netology-tfstate
  #   key = "fops/terraform.tfstate"
    

  #   # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
  #   # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!

  #   skip_region_validation      = true
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
  #   skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  # endpoints ={
  #   s3 = "https://storage.yandexcloud.net"
  # }

  # }


  required_version = "~>1.8.4"
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = "b1gn3ndpua1j6jaabf79"
  folder_id                = "b1gfu61oc15cb99nqmfe"
  service_account_key_file = file("~/.authorized_key.json")
}
