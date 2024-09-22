#docker rm -f $(docker ps -a -q)
#terraform console
#curl -L  http://127.0.0.1:1080 ; curl -L  http://127.0.0.1:2080
variable "string" {
    type=string
    default="some sting"
    }
variable "number" {
    type=number
    default=1
    }
variable "list_of_strings" {
    type=list(string)
    default=["a","b","c"]
    }
variable "list_of_numbers" {
    type=list(number)
    default=[1,2,3]
    }

variable "map" {
    type=map()
    default={
        name="John"
        surname="Connor"
    }
    }



variable "containers"{
    type = map(object({
        name  = string
        image=string
        ports = object({
            external = number
            internal = number
        })
    }))
    default = {
        nginx={
            name="reverse-proxy-nginx"
            image="nginx:1.21.1"
            ports={
                internal=80
                external=1080
            }
        },
        wordpress={
            name="web-wordpress"
            image="wordpress:latest"
            ports={
                internal=80
                external=2080
            }
        }
    }
}

resource "docker_image" "nginx" {
  name         = var.containers.wordpress.image
  keep_locally = true
}

resource "docker_image" "wordpress" {
  name         = var.containers.wordpress.image
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "our-cool-project-${var.containers.nginx.name}" #interpolation

  ports {
    internal = var.containers.nginx.ports.internal
    external = var.containers.nginx.ports.external
  }
}

resource "docker_container" "wordpress" {
  image = docker_image.wordpress.image_id
  name  = "our-cool-project-${var.containers.wordpress.name}" #interpolation

  ports {
    internal = var.containers.wordpress.ports.internal
    external = var.containers.wordpress.ports.external
  }
}
