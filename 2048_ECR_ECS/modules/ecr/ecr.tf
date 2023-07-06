terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }

}

resource "aws_ecr_repository" "games_ecr_repo" {
  name = var.ecr_repo_name
}

resource "docker_registry_image" "game_2048" {
  name = "${aws_ecr_repository.games_ecr_repo.repository_url}:latest"

  build {
    context = "${path.cwd}/application"
  }
}