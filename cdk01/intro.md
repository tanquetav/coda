# Notes

We cannot run this lab on a one-node cluster because of memory constraints. CDK must run on a second node to not cause memory starvation.

There is a daemon process copying the env folder from control plane to node01.

When you start the lab, please click on the hamburguer menu and create a new terminal. On this new terminal ssh to node01:

`ssh node01`{{exec}}

Check instructions to run the command on the controlplane node, node01 node or both.

# IaC

Infrastructure as Code is the process to use some kind of descritive file to create and maintain an infrastructure in an environment.

There are some IaC more aligned to "ops" of devops, like cloudformation and terraform, which work with declarative files with few logic and loop operators. On the other side we have tools like Pulumi and CDK, that works together with a programming environment to provide infrastructure definition and can use the full power of a programming language to work.

![Alt text](https://raw.githubusercontent.com/tanquetav/coda/main/cdk01/cdk.drawio.svg)

CDK is a technology developed by AWS and some partners, using typescript definitions to render cloudformation files. Hashicorp is one of these partners, and they render typescript definitions to create terraform files. This render process is called *synth*

I nice trick used by CDK is to use jsii library which generates stubs from this typescript code to several languages, like Java, C#, Python. With this strategy, all target languages are paired with features. Pulumi has a similar feature called CrossCode to generate the stubs for all supported languages. Terraform CDK can generate typescript from all terraform modules and providers. There are some strategies to convert terraform files to CDK too.

![Alt text](https://raw.githubusercontent.com/tanquetav/coda/main/cdk01/process.drawio.svg)