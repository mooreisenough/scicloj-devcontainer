# Integrations

## python works

```clojure
(require '[libpython-clj2.python :refer [py. py.. py.-] :as py])
(py/initialize!)
(py/run-simple-string "print(1+1)")
```

## R works

```clojure
(require '[clojisr.v1.r :refer [r]])
(r '(+ 1 2))
```

## Julia works

```clojure
(require '[libjulia-clj.julia :as julia])
(julia/initialize!)
(def ones-fn (julia/jl "Base.ones"))
(ones-fn 3 4)
```

## APL Works

```Clojure
(require '[libapl-clj.apl :as apl :refer [display!]])
(apl/+ 1 2)
(apl/+ [1 2 3] [4 5 6])
(apl/display! (apl/+ [1 2 3] [4 5 6]))
(apl/× [1 2 3] [4 5 6])
(apl/⍴ [2 3 5] (first "a"))
(apl/display! (apl/⍴ [2 3 5] (first "a")))
(apl/reduce apl/⌈ [[1 2 3] [3 5 6] [1 2 3]])
(apl/reduce apl/⌈ 1 [[1 2 3] [3 5 6] [1 2 3]])
```
