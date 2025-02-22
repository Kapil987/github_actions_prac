resource "aws_instance" "green" {

  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.public_subnets[1]
  vpc_security_group_ids = [aws_security_group.web.id]

  associate_public_ip_address = true

  user_data = templatefile("init.sh", {
    GITHUB_TOKEN = var.git_token,
    REPO_URL = var.repo_url
    RUNNER_VERSION = var.runner_version
    WORK_DIR = var.work_dir
    RUNNER_NAME = var.runner_name
  })

  tags = {
    Name = "Github-runner-demo"
  }
}