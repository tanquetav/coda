# Notes

### First, let's load the java sdk and change to the code repository:

`source "/root/.sdkman/bin/sdkman-init.sh"`{{exec}}

`cd recursion`{{exec}}

### Let's compile the java and the clojure sample:

`mvn compile`{{exec}}

`mvn clojure:compile`{{exec}}

### Let's execute switch expressions with a small number

`mvn exec:java -Dexec.mainClass="br.collabtime.Pattern"  -Dexec.args="small"`{{exec}}

`mvn exec:java -Dexec.mainClass="br.collabtime.PatClojure"  -Dexec.args="small"`{{exec}}

### Now let's execute it with a bigger number

`mvn exec:java -Dexec.mainClass="br.collabtime.PatClojure"  -Dexec.args="big"`{{exec}}

`mvn exec:java -Dexec.mainClass="br.collabtime.Pattern"  -Dexec.args="big"`{{exec}}

The non clojure version should trigger a stackoverflow exception.

### Let's check bytecode why clojure version does not trigger stac overflow exception

`javap -c -p target/classes/br/collabtime/Pattern.class`{{exec}}

Pattern matching: fibo:1
Recursion: fibo:46

`javap -c -p target/classes/br/collabtime/PatClojure\$fibo_tail_recursive_internal.class`{{exec}}

Pattern matching: invokeStatic:16
Recursion: invokeStatic:91

goto operand does not push items to stack

### Workaround (time consuming) with virtual threads

`mvn exec:java -Dexec.mainClass="br.collabtime.PatternVirtualThread"  -Dexec.args="small"`{{exec}}

`mvn exec:java -Dexec.mainClass="br.collabtime.PatternVirtualThread"  -Dexec.args="big"`{{exec}}

Recursion is simulated invoking new virtual threads on executor service. The previous virtual thread is hold on suspended state
