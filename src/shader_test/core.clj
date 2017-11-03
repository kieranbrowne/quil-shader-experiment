(ns shader-test.core
  (:require [quil.core :as q]
            [quil.middleware :as m]))

(defn setup []
  (let [shader (q/load-shader "Frag.glsl" "Vert.glsl")]
    ;; (.set shader "fraction" (float 1.0)) 
    ;; ;; (.set shader "resolution" (float (q/width)) (float (q/height))) 
    {:shader shader}))


(defn update-state [state]
  (if (= 0 (mod (q/frame-count) 100))
    {:shader (q/load-shader "Frag.glsl" "Vert.glsl")}
    state))

(defn center []
  [(+ (/ (q/width) 2) (* (q/sin (/ (q/frame-count) 40)) 18)) 
   (/ (q/height) 2)])

(defn draw-state [state]
  (q/stroke 0 0 0)
  (q/background 255)
  ;; just yellow shader
  (q/shader (:shader state))
  (q/directional-light 204 204 200  0 0 -1)
  (q/with-translation (center)
    (q/sphere 120)))

(q/defsketch shader-test
  :title "Shader tests"
  :size [500 500]
  :renderer :p3d
  :setup setup
  :update update-state
  :draw draw-state
  :features [:keep-on-top]
  :middleware [m/fun-mode])
