terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-20220727195122327400000001"
    region     = "ru-central1-a"
    key        = "bucket/terraform.tfstate"
    access_key = "YCAJE6Nl3oTTACxnr5Ama-cVM"
    secret_key = "YCO-UkomsPYPwdy6GlXfGePsVyx1piJ1TIVCJduW"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}