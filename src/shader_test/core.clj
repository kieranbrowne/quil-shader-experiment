(ns shader-test.core
  (:require [quil.core :as q]
            [quil.middleware :as m]))

(defn set-shader [kv-map & files]
  (let [sh (apply q/load-shader files)]
    (doseq [[k v] kv-map]
      (.set sh k v))
    sh))
    


(defn setup []
  {:shader (set-shader {"fraction" (float 1.0)} "Frag.glsl" "Vert.glsl")})
  


(defn update-state [state]
  (if (= 0 (mod (q/frame-count) 100))
    {:shader (set-shader {"fraction" (float 1.0)} "Frag.glsl" "Vert.glsl")}
    state))

(defn center []
  [(+ (/ (q/width) 2) (* (q/sin (/ (q/frame-count) 40)) 18)) 
   (/ (q/height) 2)])

(defn weird-shape []
  (q/begin-shape)
  (q/vertex -100 -100 -100)
  (q/vertex  100 -100 -100)
  (q/vertex   0    0  100)

  (q/vertex 100 -100 -100)
  (q/vertex 100  100 -100)
  (q/vertex   0    0  100)

  (q/vertex 100 100 -100)
  (q/vertex 100 100 -100)
  (q/vertex   0   0  100)

  (q/vertex 100  100 -100)
  (q/vertex 100 -100 -100)
  (q/vertex   0    0  100)
  (q/end-shape :close))

(defn draw-state [state]
  ;; (q/stroke 0 0 0)
  (q/no-stroke)
  (q/background 255)
  ;; just yellow shader
  (q/shader (:shader state))
  (q/directional-light 204 204 200  0 0 -1)
  (q/lights)
  (q/with-translation (center)
    ;; (weird-shape)
    (q/fill 250 00 200)
    (q/sphere-detail 30)
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
