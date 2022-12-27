# Constructs are like modules

Terraform already have the concept of modules to share some blocks between projects. Programming languages have more powerful strategies with OOP to achieve this and can use "Constructs" to share this reusable content. Let's create a simple construct:

### Check the webdeployment.ts 

This file is very similar with deployment we created before, but it is a separete class and receive the name, the image, and the number of replicas to create the k8s deployment.

### Open the main.ts file on env directory of control plane and add these includes 

```plain
import WebDeployment from "./webdeployment"
```

###  Remove previous deployment and use construct (keep the KubernetesProvider)

```plain
    new WebDeployment(this, "myapp02","nginx:latest",2);
```
### On node01, inside the env directory, deploy the cdk (approve it). This deployment should remove previous deployment and create this new deployment:

`cdktf deploy`{{exec}}

### check if deploy is running
`kubectl get pod`{{exec}}
