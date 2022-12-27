(ns br.collabtime.PatClojure
  (:gen-class))


(defn fibo-tail-recursive-internal
  ([n acc]
    ( case  n
      0 1
      1 (+ 1 acc)
      (recur (dec n) (+ n acc)))
  )
)
(defn -main
      [arg]
      (
        case arg
             "big"  (println (fibo-tail-recursive-internal 20000 0))
             (println (fibo-tail-recursive-internal 10 0))
        ))
