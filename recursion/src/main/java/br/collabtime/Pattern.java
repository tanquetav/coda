package br.collabtime;

public class Pattern {
    public static void main(String[] args) throws Exception {
        if (args.length>0 && args[0].equals("big")) {
            System.out.println(fibo(20000, 0));
        }
        else {
            System.out.println(fibo(10, 0));
        }
    }

    private static long fibo(int i, int acc) throws Exception {
        return switch (i) {
            case 0 -> acc;
            case 1 -> acc + 1L;
            default ->  fibo(i - 1, i + acc);
        };
    }
}
