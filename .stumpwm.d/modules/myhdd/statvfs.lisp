(in-package #:myhdd)

(defcfun ("statvfs" %statvfs) :int
  (path :string)
  (buf :pointer))

(defun statvfs (path)
  (with-foreign-object (buf '(:struct statvfs))
    (%statvfs path buf)
    (with-foreign-slots ((bsize frsize blocks bfree bavail files
                                ffree favail fsig flag namemax)
                         buf
                         (:struct statvfs))
      (values bsize frsize blocks bfree bavail files
              ffree favail fsig flag namemax))))

(defun disk-space (path &optional human-readable-p)
  "Disk space information include total/free/available space."
  (multiple-value-bind (bsize frsize blocks bfree bavail files
                        ffree favail fsig flag namemax)
      (statvfs path)
    (declare (ignore bsize files ffree favail fsig flag namemax))
    (if human-readable-p
        (values (size-in-human-readable (* frsize blocks))
                (size-in-human-readable (* frsize bfree))
                (size-in-human-readable (* frsize bavail)))
        (values (* frsize blocks) (* frsize bfree) (* frsize bavail)))))
