module "eks_core_apps" {
  source       = "./module"
  region       = "ca-central-1"
  cluster_name = "portofazneo-dev"
 
  # kube_proxy - https://docs.aws.amazon.com/pt_br/eks/latest/userguide/managing-kube-proxy.html
  kube_proxy_enable  = true
  kube_proxy_version = "v1.29.3-eksbuild.2"

  # coredns - https://docs.aws.amazon.com/pt_br/eks/latest/userguide/managing-coredns.html
  coredns_enable  = true
  coredns_version = "v1.11.1-eksbuild.6"

  # vpc_cni - https://artifacthub.io/packages/helm/aws/aws-vpc-cni
  vpc_cni_enable      = true
  vpc_cni_version     = "1.18.0"
  subnets_filter_name = "cni-pods"      # subnets da rede CNI
  sg_filter_name      = "eks_worker_sg" # sg do node

  # aws_load_balancer_controller - https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller
  alb_controller_enable  = true
  alb_controller_version = "1.7.1"

  # autoscaler - https://artifacthub.io/packages/helm/cluster-autoscaler/cluster-autoscaler
  autoscaler_enable  = true
  autoscaler_version = "9.36.0"

  # metrics_server - https://artifacthub.io/packages/helm/metrics-server/metrics-server
  metrics_server_enable  = true
  metrics_server_version = "3.12.1"

  # nginx_controler - https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
  nginx_controler_enable  = false
  certificate_arn         = ""
  nginx_controler_version = "4.10.0"

  # kube_dashboard - https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard
  kube_dashboard_enable        = false
  kube_dashboard_version       = "7.3.2"
  kube_dashboard_ingress_class = "nginx"
  kube_dashboard_url           = ""

  # kubecost - https://artifacthub.io/packages/helm/kubecost/cost-analyzer
  kubecost_enable        = false
  kubecost_version       = "2.2.2"
  kubecost_ingress_class = "nginx"
  kubecost_url           = ""
}