# 05 - Test & Verification

High-level steps:
- Obtain the public endpoint (ALB DNS or public IP) exposed by the ECS service.
- Run a simple check: `curl http://<endpoint>/` and confirm the HelloWorld response.
- Optionally add health checks/monitoring; verify logs in CloudWatch for the task.
- Document any known ports, paths, or expected outputs.
