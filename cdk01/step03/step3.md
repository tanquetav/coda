# Using some language features

In this section we will use some language structures to create several deployments

### Create a configuration array after the import section:

```plain
const deploys = [ 
    {
        name: "myapp02",
        image: "nginx:latest",
        replicas: 2,
    },
    {
        name: "myapp03",
        image: "nginx:latest",
        replicas: 1,
    },
    {
        name: "myapp04",
        image: "redis:latest",
        replicas: 1,
    }
];
```

###  Replace the WebDeployment with this loop structure

```plain
    for (let i = 0; i < deploys.length ; i++) {
        const deploy = deploys[i];
        new WebDeployment(this, deploy.name, deploy.image , deploy.replicas);
    }
```
### On node01, inside the env directory, deploy the cdk (approve it). Two new deploys will be created:

`cdktf deploy`{{exec}}

### check if deploy is running
`kubectl get pod`{{exec}}
