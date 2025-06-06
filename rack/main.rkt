#lang racket

(require (for-syntax syntax/parse))

(provide (all-from-out racket)
         def say say/ln bgn
         use out fun)

;; def → define
(define-syntax-rule (def name (args ...) body ...)
  (define (name args ...) body ...))

;; say → display
(define-syntax-rule (say x)
  (display x))

;; say/ln → displayln
(define-syntax-rule (say/ln x)
  (displayln x))

;; bgn → begin
(define-syntax-rule (bgn expr ...)
  (begin expr ...))

;; use → require
(define-syntax (use stx)
  (syntax-parse stx
    [(_ spec:expr ...+)
     #'(require spec ...)]))

;; out → provide
(define-syntax (out stx)
  (syntax-parse stx
    [(_ spec:expr ...+)
     #'(provide spec ...)]))

;; fun → lambda
(define-syntax (fun stx)
  (syntax-parse stx
    [(_ (args:id ...) body:expr ...+)
     #'(lambda (args ...) body ...)]))
