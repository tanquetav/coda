// Copyright (c) HashiCorp, Inc
// SPDX-License-Identifier: MPL-2.0
import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
// Insert imports here

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);
      // Insert objects here
  }
}

const app = new App();
new MyStack(app, "env");
app.synth();
