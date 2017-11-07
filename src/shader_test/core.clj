(ns shader-test.core
  (:require [quil.core :as q]
            [quil.middleware :as m]))

(defn setup []
  {:shader (q/load-shader "Frag.glsl")})
  
(defn update-shader [shader]
  (doto shader 
    (.set "u_resolution" (float (q/width)) (float (q/height)))
    (.set "u_mouse" (float (q/mouse-x)) (float (q/mouse-x)))
    (.set "u_time" (float (/ (q/millis) 1000)))))

(defn update-state [state]
  (let [shader 
        (if (= 0 (mod (q/frame-count) 100))
          (q/load-shader "Frag.glsl")
          (:shader state))]
    (update-shader shader)
    {:shader shader}))

(defn draw-state [state]
  (q/shader (:shader state))
  (q/rect 0 0 (q/width) (q/height)))

(q/defsketch shader-test
  :title "Shader tests"
  :size [500 500]
  :renderer :p3d
  :setup setup
  :update update-state
  :draw draw-state
  :features [:keep-on-top]
  :middleware [m/fun-mode])
