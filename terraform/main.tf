provider "yandex" {
 cloud_id = "b1g6ioils4l0vgmn5egd"
 folder_id = "b1g1l7a6m4hgqdqd3vi5"
 zone = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm1" {
 name = "vm1"
 hostname = "vm1.netology.cloud"
 zone = "ru-central1-a"

  resources {
 cores = 2
 memory = 2
  }

  boot_disk {
    initialize_params {
     image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
 subnet_id = yandex_vpc_subnet.subnet-1.id
 nat = true
  }

 metadata = {
 ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
 name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
 name = "subnet1"
 zone = "ru-central1-a"
 network_id = yandex_vpc_network.network-1.id
 v4_cidr_blocks = ["192.168.10.0/24"]
}
