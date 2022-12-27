# First project using CDK

### Create a new terminal and access node01

`ssh node01`{{exec}}

### Go to env directory on both nodes

`cd env`{{exec}}

### Install provider on controlplane and node01

`npm install @cdktf/provider-kubernetes`{{exec}}

### Open the main.ts file on env directory of control plane and add these includes 

```plain
import * as kubernetes from "@cdktf/provider-kubernetes"
import * as path from "path";
```

### Add this provider to contructor of the class, after the "super" invocation

```plain
    new kubernetes.provider.KubernetesProvider(this, 'k8s', {
      configPath: path.join(__dirname, "../.kube/config"),
    })
```

### Add the deployment after the provider definition

```plain
    new kubernetes.deployment.Deployment(this, "myapp", {
      metadata: {
        labels: {
          app: "myapp",
        },
        name: "myapp01",
      },
      spec: {
        replicas: "1",
        selector: {
          matchLabels: {
            app: "myapp",
          },
        },
        template: {
          metadata: {
            labels: {
              app: "myapp",
            }
          },
          spec: {
            container: [
              {
                image: "nginx:latest",
                name: "myapp",
              },
            ],
          },
        }
      }
    })
```
### On node01, inside the env directory, synth the cdk
`cdktf synth`{{exec}}

check on cdktf.out/stacks/env/ the terraform json generated (the copy is outside env folder)

### On node01, inside the env directory, deploy the cdk (approve it):
`cdktf deploy`{{exec}}

### check if deploy is running
`kubectl get pod`{{exec}}
