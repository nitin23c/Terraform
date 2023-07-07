terraform {
  required_version = "~> 1.3"

  backend "s3" {
    # replace the bucket name with the bucket name created with backend/main.tf
    bucket = "game-bucket-name"
    key    = "2048-infra/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }

}

module "ecrModule" {
  source = "./modules/ecr"

  ecr_repo_name = local.ecr_repo_name
}

module "ecsModule" {
  source = "./modules/ecs"

  game_cluster_name            = local.game_cluster_name
  availability_zones           = local.availability_zones
  game_task_famliy             = local.game_task_famliy
  game_task_name               = local.game_task_name
  ecr_repo_url                 = module.ecrModule.repository_url
  container_port               = local.container_port
  ecs_task_execution_role_name = local.ecs_task_execution_role_name
  game_load_balancer_name      = local.game_load_balancer_name
  target_group_name            = local.target_group_name
  game_service_name            = local.game_service_name

}
