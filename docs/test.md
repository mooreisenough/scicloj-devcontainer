# python works

```clojure
(require '[libpython-clj2.python :refer [py. py.. py.-] :as py])
(py/initialize!)
(py/run-simple-string "print(1+1)")
```
# R works

```clojure
(require '[clojisr.v1.r :refer [r]])
(r '(+ 1 2))
```

