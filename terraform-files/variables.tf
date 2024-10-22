variable "ami_id" {
  type = string
  default = "ami-0866a3c8686eaeeba"
}

variable "git_token" {
  description = "GitHub Runner Auth Token"
  type        = string
  sensitive   = true
}

variable "repo_url" {
  description = "Repo url"
  type        = string
}

variable "runner_version" {
  description = "Runner version"
  type        = string
  default = "2.320.0"
}

variable "bucket_name" {
  description = "Runner version"
  type        = string
  default = "abcd"
}

variable "work_dir" {
  description = "working dir for init.sh script"
  type = string
  default = "/home/ubuntu/gitlab_runner"
}

variable "runner_name" {
  description = "Name of the runner"
  type = string 
  default = "my-linux-runner"
}