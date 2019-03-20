(in-package #:myhdd)

(defun size-in-human-readable (number)
  (check-type number integer)
  (loop :for size :in '(80 70 60 50 40 30 20 10)
        :and unit :in '("Y" "Z" "E" "P" "T" "G" "M" "K")
        :when (> (ash number (- size)) 0)
          :do (return-from size-in-human-readable
                (format nil "~d~a"
                        (truncate (/ number (ash 1 size)))
                        unit))
        :finally (return (format nil "~d" number))))
