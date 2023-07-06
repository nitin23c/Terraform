locals {
  tags = {
    created_by = "terraform"
  }

  region                       = "us-east-1"
  aws_ecr_url                  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.region}.amazonaws.com"
  ecr_repo_name                = "2048-ecr-repo"
  game_cluster_name            = "game-cluster"
  availability_zones           = ["us-east-1a", "us-east-1b", "us-east-1c"]
  game_task_famliy             = "game-app-task"
  game_task_name               = "game-app-task"
  container_port               = 80
  ecs_task_execution_role_name = "game-task-execution-role"
  game_load_balancer_name      = "game-alb"
  target_group_name            = "game-targetGroup"
  game_service_name            = "game-service"
}