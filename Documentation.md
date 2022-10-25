# Documentation


First I googled `simple web app github python` and after skipping those that were dockerized already, I found [Blur-Detection-Web-App](https://github.com/Furkan-Gulsen/Blur-Detection-Web-App) for the assignment 

 **microk8s** (Kubernetes for workstations and appliances from canonical) was used to set up the k8s cluster.

 
### Scenario:
1. Deploy on k8s
    * Wrote Dockerfile for the app
    * Build the image and pushed it to ghrc.io
    * Created a github personal access token and added it as `secret` for image pull
    * Applied `deploy/secrets.yaml`
    * Applied `deploy/blur-k8s-manifests.yaml`
    * (a)
        * Created helm chart
        * installed helm chart on `tst` namespace `helm install blurrr blur-detection -n tst`

2.  Expose the web app
I installed an ingress controller (nginx) and added an ingress manifest to expose the service. I also added the following entry to /etc/hosts `127.0.0.1 blurrr.kube' to be able to actually open it as a web page.

On could simply use pod's IP or create a service and use it's IP, but I guess the only way to expose a service except loadbalancer service type is ingress. So ingress!
