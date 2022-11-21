#!/usr/bin/sbcl --script
; maxsize variable
; obtained from https://www.tutorialspoint.com/lisp/lisp_variables.htm
; BEGIN PROGRAM
(defvar maxsize 10)

; declare the cube https://stackoverflow.com/questions/869529/difference-between-set-setq-and-setf-in-common-lisp
(defvar cube)
(setf cube(make-array(list maxsize maxsize maxsize)))

; zero cube --
; http://clhs.lisp.se/Body/f_aref.htm
(loop for i from 0 to(- maxsize 1) do
    (loop for j from 0 to (- maxsize 1) do
        (loop for k from 0 to (- maxsize 1) do
            (setf(aref cube i j k) 0))))

; declaring the variables
(defvar room_dimension 5)
(defvar speed_of_gas_molecules 250.0)
(defvar diffusion_coefficient 0.175)
(defvar timestep(/(room_dimension speed_of_gas_molecules)maxsize))
(defvar distance_between_blocks(/room_dimension maxsize))
(defvar dterm(/(* diffusion_coefficient timestep)(* distance_between_blocks distance_between_blocks)))
(defvar time 0.0)
(defvar ratio 0.0)
(defvar change 0.0)

; set cube initial value
(setf(aref cube 0 0 0) 1.0e21)

; start loop here
(loop while(<ratio 0.99) do
    (loop i from 0 to ( - maxsize 1) do
        (loop for j from 0 to (- maxsize 1) do
            (loop for k from 0 to (- maxsize 1) do
                (loop for l from 0 to (- maxsize 1) do
                    (loop for m from 0 to (- maxsize 1) do
                        (loop for n from 0 to (- maxsize 1) do
                            (when (or (or (or (and (and (= i l) (= j m)) (= k (+ n 1)))
                                (and (and (= i l) (= j m)) (= k (- n 1))))
                                (or (and (and (= i l) (= j (+ m 1))) (= k n))
                                (and (and (= i l) (= j (- m 1))) (= k n))))
                                (or (and (and (= i (+ l 1)) (= j m)) (= k n))
                                (and (and (= i (- l 1)) (= j m)) (= k n))))
                                (when (or (/= (aref cube i j k) -1) (/= (aref cube l m n) -1))
                                    (setf change (* (- (aref cube i j k) (aref cube l m n) ) dterm))
                                    (decf (aref cube i j k) change)
                                    (incf (aref cube l m n)  change)))))))))

    ; http://clhs.lisp.se/Body/m_incf_.htm incf obtained here
    ; time functions
    (incf ratio timestep)
    (defvar minval(aref cube 0 0 0))
    (defvar maxval(aref cube 0 0 0))
    (defvar sumval 0.0)

    ;time loop here
    (loop for i from 0 to ( - maxsize 1) do 
        (loop for j from 0 to (- maxsize 1) do 
            (loop for k from 0 to ( - maxsize 1) do
                (when (/=(aref cube i j k) - 1)
                    (setf maxval (max(aref cube i j k) maxval)
                    (setf minval (min(aref cube i j k) minval)
                    (incf sumval (aref xube i j k))))))

    (setf ratio (/ minval maxval))
    (write ratio)
    (princ "      ")
    (write time)
    (terpri)

)
(princ "Box equilibrated in ")
(write time)
(princ " seconds of time")


