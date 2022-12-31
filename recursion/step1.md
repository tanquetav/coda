# Notes

### First, let's load the java sdk and change to the code repository:

`source "/root/.sdkman/bin/sdkman-init.sh"`{{exec}}

`cd recursion`{{exec}}

### Let's compile the java and the clojure sample:

`mvn compile`{{exec}}

`mvn clojure:compile`{{exec}}

### Switch expression

Modern java has this syntax to switch expression:

```
        return switch (i) {
            case 0 -> acc;
            case 1 -> acc + 1L;
            default ->  fibo(i - 1, i + acc);
        };

```

Clojure has similar syntax to switch expression: 

```
(defn fibo-tail-recursive-internal
  ([n acc]
    ( case  n
      0 1
      1 (+ 1 acc)
      (recur (dec n) (+ n acc)))
  )
)
```

On both syntax , the matching of 0 or 1, which are exit cases, return the final number, and the default method call the function recursively. Clojure has a special keyword to recursion: *recur*.

### Let's execute switch expressions with a small number

`mvn exec:java -Dexec.mainClass="br.collabtime.Pattern"  -Dexec.args="small"`{{exec}}

`mvn exec:java -Dexec.mainClass="br.collabtime.PatClojure"  -Dexec.args="small"`{{exec}}

Both examples are able to execute with a small number. Recursion does not given any error.

### Now let's execute it with a bigger number

`mvn exec:java -Dexec.mainClass="br.collabtime.PatClojure"  -Dexec.args="big"`{{exec}}

`mvn exec:java -Dexec.mainClass="br.collabtime.Pattern"  -Dexec.args="big"`{{exec}}

The Java version should trigger a stackoverflow exception. Why closure version does not trigger this exception?

### Let's check bytecode why clojure version does not trigger stac overflow exception

`javap -c -p target/classes/br/collabtime/Pattern.class`{{exec}}

The switch construct compiles to lookupswitch bytecode:

```
       1: lookupswitch  { // 2
                     0: 32
                     1: 38
               default: 51
          }
```

Recursion use a method call: 

```
      46: invokestatic  #21                 // Method fibo:(II)J
```

The recursion construct use invokestatic bytecode, with push values to execution stack

`javap -c -p target/classes/br/collabtime/PatClojure\$fibo_tail_recursive_internal.class`{{exec}}

On the clojure construct, a similar tableswitch is used
```
      16: tableswitch   { // 0 to 1
                     0: 40
                     1: 56
               default: 76
          }
 ```
 For recursion a simple goto is used:
```
       91: goto          0
```

However to recursion a goto statement is used, which does not push data to execution stack

This is possible because Clojure can implement a Tail Call Optimization. Usually functional languages can detect it is not necessarily come back to caller function and implement this optimization. This is possible because this implementation of fibonacci uses an accumator to store the value from the previous interation. 

Scala is other language on JVM that is able to implement Tail Call Optimization. Clojure uses the *recur* to help to discover tail call optimization, but some other functional languages can detect it by themselves.

Maybe with the evolution of pattern matching and case switches the java compiler could implement similar bytecode generation.


### Workaround (time consuming) with virtual threads

`mvn exec:java -Dexec.mainClass="br.collabtime.PatternVirtualThread"  -Dexec.args="small"`{{exec}}

`mvn exec:java -Dexec.mainClass="br.collabtime.PatternVirtualThread"  -Dexec.args="big"`{{exec}}

Recursion is simulated by invoking new virtual threads on executor service. The previous virtual thread is put on hold on suspended state and a new virtual thread can be started.

This is not the best approach, but it is interesting to discover some assemblies in java maybe solve some problems. In this case, Virtual Thread take a lot more time to finish the work, because the context switch, but does not trigger StackOverflow.
