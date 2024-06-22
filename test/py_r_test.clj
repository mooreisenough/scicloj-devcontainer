(ns py-r-test
  (:require  [clojure.test :as t]
             [libpython-clj2.python  :as py]
             [libpython-clj2.require :refer [require-python]]
             [clojisr.v1.r :as r :refer [r require-r]]))

;; check if R and python bindings work
(py/initialize!)
(require-python '[os :as py-os])
(require-python '[pandas])
(require-python '[numpy :as np])
(require-r '[base])

(t/deftest test-python []
  (t/is (= "/workspaces/scicloj-devcontainer"   (py-os/getcwd))))

(t/deftest test-R []
  (t/is (= "/workspaces/scicloj-devcontainer" (r.base/getwd))))


(t/deftest test-R2 []
  (t/is (= [3 4]
   (r.base/dim (-> (np/array [[1 2 3 4] [5 6 7 8] [9 10 11 12]])
                   (py/->jvm)
                   (r/clj->java->r)
                   (r.base/simplify2array)
                   (r.base/t))))))




