variable "flow" {
  type    = string
  default = "24-01"
}

variable "cloud_id" {
  type    = string
  default = "b1gn3ndpua1j6jaabf79"
}
variable "folder_id" {
  type    = string
  default = "b1gfu61oc15cb99nqmfe"
}

variable "test" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

