package br.collabtime;

import java.math.BigInteger;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class PatternVirtualThread {
    private static ExecutorService executor;

    public static void main(String[] args) throws Exception {
        executor = Executors.newVirtualThreadPerTaskExecutor();
        if (args.length>0 && args[0].equals("big")) {
            System.out.println(fibo(BigInteger.valueOf(200000L), BigInteger.ZERO));
        }
        else {
            System.out.println(fibo(BigInteger.valueOf(10L), BigInteger.ZERO));
        }
    }

    private static BigInteger fibo(BigInteger i, BigInteger acc) throws Exception {
        return switch (i.intValue()) {
            case 0 -> acc;
            case 1 -> acc.add(BigInteger.valueOf(1l));
            default -> {
                BigInteger result;
                try {
                    var s = executor.submit(
                            () -> fibo(i.add(BigInteger.valueOf(-1L)), i.add(acc) )
                    );
                    result = s.get();
                }
                catch (Exception e) {
                    result = BigInteger.ZERO;
                }
                yield result;
            }
        };
    }
}
