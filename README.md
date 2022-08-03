# devops-exercise

<!-- Following test will give us a view of your skillset on AWS well-architected framework. No need to implement it completely so please watch your time and implement as much as possible in the duration of 8 to 10 hours.

1. Build a secure and small dockerized hello world Laravel app which can be successfully connected to a MySQL server.
2. Automate the process of building the app and pushing to a container registry using GitLab.
3. Bring up an autoscale EC2 cluster as a worker node group of an EKS cluster (For this IaC is enough, no need to apply on real infra)
4. Automate the deployment of built app on K8s cluster (locally you can use `minikube` or `kind` for K8s)
5. Add documentation of the whole procedure and how you made it well architected.

Please use technologies you have expertise on (GitLab, Ansible, Bash, Terraform, Helm, etc.) and send us all repositories. -->


TODO:
- [ ] Setup EKS Cluster Terraform, structure module, install Helm, EKS add-ons
- [ ] Clone source code https://github.com/nahidulhasan/laravel-docker-k8s and running local test.
- [ ] Install MySQL K8S, prepare script migrate DB for Laravel, automate pipeline migrate if necessary at the end stage.
- [ ] Setup Helm repository in S3 using Terraform module, base helm chart application
- [ ] Using Helm app to deploy Dockerfile locally
- [ ] Using https://github.com/GoogleContainerTools/kaniko to Build Docker in Gitlab CI and publish to ECR
- [ ] Deploy and manage GitLab Runner in cluster EKS, to make pipeline runnable
- [ ] Using autoscaler to scale the cluster's worker nodes by number of pods or metrics.
- [ ] Document, draw architecture, how it work

