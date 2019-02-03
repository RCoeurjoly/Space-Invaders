; SMT-LIBv2 description generated by Yosys 0.8+143 (git sha1 c4b61f2, clang 3.8.0-2ubuntu4 -fPIC -Os)
; yosys-smt2-module ship
(declare-sort |ship_s| 0)
(declare-fun |ship_is| (|ship_s|) Bool)
; yosys-smt2-output o_ship_x 5
; yosys-smt2-register o_ship_x 5
; yosys-smt2-wire o_ship_x 5
(declare-fun |ship#0| (|ship_s|) (_ BitVec 5)) ; \o_ship_x
(define-fun |ship_n o_ship_x| ((state |ship_s|)) (_ BitVec 5) (|ship#0| state))
; yosys-smt2-wire next_x 5
(declare-fun |ship#1| (|ship_s|) (_ BitVec 1)) ; \i_left_debounced
(define-fun |ship#2| ((state |ship_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ship#1| state)) #b1) #b0 #b1)) ; $78\next_x[4:0]
(declare-fun |ship#3| (|ship_s|) (_ BitVec 1)) ; \i_reset
(define-fun |ship#4| ((state |ship_s|)) (_ BitVec 5) (ite (= ((_ extract 0 0) (|ship#3| state)) #b1) (concat #b1001 (|ship#2| state)) #b00101)) ; \next_x
(define-fun |ship_n next_x| ((state |ship_s|)) (_ BitVec 5) (|ship#4| state))
; yosys-smt2-input i_right_debounced 1
; yosys-smt2-wire i_right_debounced 1
(declare-fun |ship#5| (|ship_s|) Bool) ; \i_right_debounced
(define-fun |ship_n i_right_debounced| ((state |ship_s|)) Bool (|ship#5| state))
; yosys-smt2-input i_reset 1
; yosys-smt2-wire i_reset 1
(define-fun |ship_n i_reset| ((state |ship_s|)) Bool (= ((_ extract 0 0) (|ship#3| state)) #b1))
; yosys-smt2-input i_left_debounced 1
; yosys-smt2-wire i_left_debounced 1
(define-fun |ship_n i_left_debounced| ((state |ship_s|)) Bool (= ((_ extract 0 0) (|ship#1| state)) #b1))
; yosys-smt2-input i_enable 1
; yosys-smt2-wire i_enable 1
(declare-fun |ship#6| (|ship_s|) Bool) ; \i_enable
(define-fun |ship_n i_enable| ((state |ship_s|)) Bool (|ship#6| state))
; yosys-smt2-input i_clk_36MHz 1
; yosys-smt2-wire i_clk_36MHz 1
; yosys-smt2-clock i_clk_36MHz posedge
(declare-fun |ship#7| (|ship_s|) Bool) ; \i_clk_36MHz
(define-fun |ship_n i_clk_36MHz| ((state |ship_s|)) Bool (|ship#7| state))
; yosys-smt2-register $formal$ship.v:64$24_CHECK 1
(declare-fun |ship#8| (|ship_s|) (_ BitVec 1)) ; $formal$ship.v:64$24_CHECK
(define-fun |ship_n $formal$ship.v:64$24_CHECK| ((state |ship_s|)) Bool (= ((_ extract 0 0) (|ship#8| state)) #b1))
; yosys-smt2-register $formal$ship.v:63$23_CHECK 1
(declare-fun |ship#9| (|ship_s|) (_ BitVec 1)) ; $formal$ship.v:63$23_CHECK
(define-fun |ship_n $formal$ship.v:63$23_CHECK| ((state |ship_s|)) Bool (= ((_ extract 0 0) (|ship#9| state)) #b1))
; yosys-smt2-register $formal$ship.v:62$22_CHECK 1
(declare-fun |ship#10| (|ship_s|) (_ BitVec 1)) ; $formal$ship.v:62$22_CHECK
(define-fun |ship_n $formal$ship.v:62$22_CHECK| ((state |ship_s|)) Bool (= ((_ extract 0 0) (|ship#10| state)) #b1))
; yosys-smt2-register $formal$ship.v:61$21_EN 1
(declare-fun |ship#11| (|ship_s|) (_ BitVec 1)) ; $formal$ship.v:61$21_EN
(define-fun |ship_n $formal$ship.v:61$21_EN| ((state |ship_s|)) Bool (= ((_ extract 0 0) (|ship#11| state)) #b1))
; yosys-smt2-register $formal$ship.v:61$21_CHECK 1
(declare-fun |ship#12| (|ship_s|) (_ BitVec 1)) ; $formal$ship.v:61$21_CHECK
(define-fun |ship_n $formal$ship.v:61$21_CHECK| ((state |ship_s|)) Bool (= ((_ extract 0 0) (|ship#12| state)) #b1))
; yosys-smt2-assert 0 ship.v:64
(define-fun |ship_a 0| ((state |ship_s|)) Bool (or (= ((_ extract 0 0) (|ship#8| state)) #b1) (not (= ((_ extract 0 0) (|ship#11| state)) #b1)))) ; $assert$ship.v:64$84
; yosys-smt2-assert 1 ship.v:63
(define-fun |ship_a 1| ((state |ship_s|)) Bool (or (= ((_ extract 0 0) (|ship#9| state)) #b1) (not (= ((_ extract 0 0) (|ship#11| state)) #b1)))) ; $assert$ship.v:63$83
; yosys-smt2-assert 2 ship.v:62
(define-fun |ship_a 2| ((state |ship_s|)) Bool (or (= ((_ extract 0 0) (|ship#10| state)) #b1) (not (= ((_ extract 0 0) (|ship#11| state)) #b1)))) ; $assert$ship.v:62$82
; yosys-smt2-assert 3 ship.v:61
(define-fun |ship_a 3| ((state |ship_s|)) Bool (or (= ((_ extract 0 0) (|ship#12| state)) #b1) (not (= ((_ extract 0 0) (|ship#11| state)) #b1)))) ; $assert$ship.v:61$81
(define-fun |ship#13| ((state |ship_s|)) Bool (bvuge (|ship#0| state) #b00000)) ; $0$formal$ship.v:61$21_CHECK[0:0]$69
(define-fun |ship#14| ((state |ship_s|)) Bool (bvule (|ship#0| state) #b10011)) ; $0$formal$ship.v:62$22_CHECK[0:0]$71
(define-fun |ship#15| ((state |ship_s|)) Bool (bvuge (|ship#4| state) #b00000)) ; $0$formal$ship.v:63$23_CHECK[0:0]$73
(define-fun |ship#16| ((state |ship_s|)) Bool (bvule (|ship#4| state) #b10011)) ; $0$formal$ship.v:64$24_CHECK[0:0]$75
(define-fun |ship_a| ((state |ship_s|)) Bool (and
  (|ship_a 0| state)
  (|ship_a 1| state)
  (|ship_a 2| state)
  (|ship_a 3| state)
))
(define-fun |ship_u| ((state |ship_s|)) Bool true)
(define-fun |ship_i| ((state |ship_s|)) Bool (and
  (= (|ship#0| state) #b00101) ; o_ship_x
  (= (= ((_ extract 0 0) (|ship#11| state)) #b1) false) ; $formal$ship.v:61$21_EN
))
(define-fun |ship_h| ((state |ship_s|)) Bool true)
(define-fun |ship_t| ((state |ship_s|) (next_state |ship_s|)) Bool (and
  (= (ite (|ship#13| state) #b1 #b0) (|ship#12| next_state)) ; $procdff$697 $formal$ship.v:61$21_CHECK
  (= #b1 (|ship#11| next_state)) ; $procdff$698 $formal$ship.v:61$21_EN
  (= (ite (|ship#14| state) #b1 #b0) (|ship#10| next_state)) ; $procdff$699 $formal$ship.v:62$22_CHECK
  (= (ite (|ship#15| state) #b1 #b0) (|ship#9| next_state)) ; $procdff$701 $formal$ship.v:63$23_CHECK
  (= (ite (|ship#16| state) #b1 #b0) (|ship#8| next_state)) ; $procdff$703 $formal$ship.v:64$24_CHECK
  (= (|ship#4| state) (|ship#0| next_state)) ; $procdff$705 \o_ship_x
)) ; end of module ship
; yosys-smt2-topmod ship
; end of yosys output
