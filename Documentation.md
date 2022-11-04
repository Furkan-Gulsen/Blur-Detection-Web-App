# Documentation


First I googled `simple web app github python` and after skipping those that were dockerized already, I found [Blur-Detection-Web-App](https://github.com/Furkan-Gulsen/Blur-Detection-Web-App) for the assignment 

 **microk8s** (Kubernetes for workstations and appliances from canonical) was used to set up the k8s cluster.
 If snap package manager is not already available follow [Installing snapd](https://snapcraft.io/docs/installing-snapd). Then installing microk8s is easy as running `snap install microk8s --classic`.
 It would be a good idea to enable ingress right now: `microk8s.enable ingress` 

**NOTE:** At any point `shecan.ir` can be used to bypass sanctions.

### Scenario:
**1. Assume we have a simple web application project and want to
deploy it on a k8s cluster. Provide and apply the related
manifests to deploy this app on the cluster (Dockerfile,
Manifests):**

For Dockerfile (python:3.9.15-slim-bullseye) is used as base image. Dockerfile is built and pushed to ghcr.io. For further pushing to and pulling from ghcr.io, I created a a github personal access token (it is used in both `k8s/secrets/dockerconfigjson-github-pat-r` and gitlab CI/CD). All three k8s components (deployment, service and ingress) are stored in `deploy/blur-k8s-manifests.yaml`. 

To get the project running on k8s:
* Secrets should be added first
```bash
kubectl apply -f deploy/secrets.yaml
```

* And applying the actual manifest
```bash
kubectl apply -f deploy/blur-k8s-manifests.yaml
```

1-a. [optional] create a helm chart to deploy the project:

helm chart is saved in `deploy/blur-detection`. To run the project using helm run
```bash
kubectl create namespace blur-ns
helm install blurrr blur-detection -n blur-ns
```

2. **We want to send traffic to this web application. What is your
approach? Apply the required steps on the k8s cluster and
describe your reason(s): “why did you choose this approach?” in
the document:**

I installed an ingress controller (nginx) and added an ingress manifest to expose the service. I also added the following entry to /etc/hosts `127.0.0.1 blurrr.kube' to be able to actually open it as a nice/fancy web page.

On could simply use pod's IP or create a service and use it to test the app. But I guess the only way to expose a service except loadbalancer service type is ingress. So ingress!

3. **[optional] Use Gitlab’s CI/CD to build and deploy the application
on the k8s cluster (also gitlab.com is acceptable).**

First runner and `.gitlab-ci.yaml` was added to the project. `.gitlab-ci.yaml` includes trivial/testing stages.