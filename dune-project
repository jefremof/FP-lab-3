(lang dune 3.17)

(name fp_lab_3)

(generate_opam_files true)

(source
 (github jefremof/FP-lab-3))

(authors
 "Mark Efremov <jefremovmark@gmail.com>")

(maintainers
 "Mark Efremov <jefremovmark@gmail.com>")

(bug_reports "https://github.com/jefremof/FP-lab-3/issues")

(homepage "https://github.com/jefremof/FP-lab-3")

(license BSD-3-Clause)

(package
 (name fp_lab_3)
 (synopsis "Laboratory focused on the stream processing")
 (depends ocaml
  ocamlformat 
  core 
  ppx_deriving
  ppx_assert
  ppx_sexp_conv
  ppx_inline_test
  ppx_jane
  sexplib
  (iter (= 1.6))
  )
 )