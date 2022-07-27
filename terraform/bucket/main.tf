terraform {
 required_providers {
   yandex = {
     source  = "yandex-cloud/yandex"
   }
 }
 required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id = "b1g6ioils4l0vgmn5egd"
  folder_id = "b1g1l7a6m4hgqdqd3vi5"
  zone = "ru-central1-a"
}

resource "yandex_storage_bucket" "Netology-terraform" {
  access_key = ""
  secret_key = ""
}