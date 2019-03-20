(in-package #:myhdd)

(cc-flags "-I/usr/include")

(include "sys/statvfs.h")

(ctype fsblkcnt "fsblkcnt_t")
(ctype fsfilcnt "fsfilcnt_t")

(cstruct statvfs "struct statvfs"
         (bsize   "f_bsize"   :type :unsigned-long)
         (frsize  "f_frsize"  :type :unsigned-long)
         (blocks  "f_blocks"  :type fsblkcnt)
         (bfree   "f_bfree"   :type fsblkcnt)
         (bavail  "f_bavail"  :type fsblkcnt)
         (files   "f_files"   :type fsfilcnt)
         (ffree   "f_ffree"   :type fsfilcnt)
         (favail  "f_favail"  :type fsfilcnt)
         (fsig    "f_fsid"    :type :unsigned-long)
         (flag    "f_flag"    :type :unsigned-long)
         (namemax "f_namemax" :type :unsigned-long))

(constant (st-rdonly "ST_RDONLY"))
(constant (st-nosuid "ST_NOSUID"))
