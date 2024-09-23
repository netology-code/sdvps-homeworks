#docker rm -f $(docker ps -a -q)
#terraform console
#curl -L  http://127.0.0.1:1080 ; curl -L  http://127.0.0.1:2080

resource "docker_image" "nginx" {
  name         = var.containers.nginx.image
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

