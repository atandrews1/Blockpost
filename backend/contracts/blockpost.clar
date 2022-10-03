
;; blockpost
;; <contract thats writes a post on chain for a small fee>
 
;;the wallet that gets the STX fee
(define-constant contract-owner tx-sender)

;; how much to post
(define-constant price u1000000) ;;1 STX

(define-data-var total-posts uint u0)

(define-map post principal (string-utf8 500))

(define-read-only (get-total-posts)
  (var-get total-posts)
)

(define-read-only (get-posts (user principal)) 
(map-get? post user)
)

;; #[allow(unchecked_data)]
(define-public (write-post (message (string-utf8 500)))
  (begin
   (try! (stx-transfer? price tx-sender contract-owner))
   (map-set post tx-sender message)
   (var-set total-posts (+ (var-get total-posts) u1))
   (ok "SUCCESS")
 )
)

