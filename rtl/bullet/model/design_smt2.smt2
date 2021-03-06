; SMT-LIBv2 description generated by Yosys 0.8+143 (git sha1 c4b61f2, clang 3.8.0-2ubuntu4 -fPIC -Os)
; yosys-smt2-module $paramod/timer_1us/PERIOD=90000
(declare-sort |$paramod/timer_1us/PERIOD=90000_s| 0)
(declare-fun |$paramod/timer_1us/PERIOD=90000_is| (|$paramod/timer_1us/PERIOD=90000_s|) Bool)
; yosys-smt2-input reset 1
; yosys-smt2-wire reset 1
(declare-fun |$paramod/timer_1us/PERIOD=90000#0| (|$paramod/timer_1us/PERIOD=90000_s|) Bool) ; \reset
(define-fun |$paramod/timer_1us/PERIOD=90000_n reset| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool (|$paramod/timer_1us/PERIOD=90000#0| state))
; yosys-smt2-output q 1
; yosys-smt2-register q 1
; yosys-smt2-wire q 1
(declare-fun |$paramod/timer_1us/PERIOD=90000#1| (|$paramod/timer_1us/PERIOD=90000_s|) (_ BitVec 1)) ; \q
(define-fun |$paramod/timer_1us/PERIOD=90000_n q| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool (= ((_ extract 0 0) (|$paramod/timer_1us/PERIOD=90000#1| state)) #b1))
; yosys-smt2-input en 1
; yosys-smt2-wire en 1
(declare-fun |$paramod/timer_1us/PERIOD=90000#2| (|$paramod/timer_1us/PERIOD=90000_s|) Bool) ; \en
(define-fun |$paramod/timer_1us/PERIOD=90000_n en| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool (|$paramod/timer_1us/PERIOD=90000#2| state))
; yosys-smt2-register count 32
; yosys-smt2-wire count 32
(declare-fun |$paramod/timer_1us/PERIOD=90000#3| (|$paramod/timer_1us/PERIOD=90000_s|) (_ BitVec 32)) ; \count
(define-fun |$paramod/timer_1us/PERIOD=90000_n count| ((state |$paramod/timer_1us/PERIOD=90000_s|)) (_ BitVec 32) (|$paramod/timer_1us/PERIOD=90000#3| state))
; yosys-smt2-input clk_25MHz 1
; yosys-smt2-wire clk_25MHz 1
; yosys-smt2-clock clk_25MHz posedge
(declare-fun |$paramod/timer_1us/PERIOD=90000#4| (|$paramod/timer_1us/PERIOD=90000_s|) Bool) ; \clk_25MHz
(define-fun |$paramod/timer_1us/PERIOD=90000_n clk_25MHz| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool (|$paramod/timer_1us/PERIOD=90000#4| state))
(define-fun |$paramod/timer_1us/PERIOD=90000#5| ((state |$paramod/timer_1us/PERIOD=90000_s|)) (_ BitVec 32) (bvadd (|$paramod/timer_1us/PERIOD=90000#3| state) #b00000000000000000000000000000001)) ; $add$timer_1us.v:30$36_Y
(define-fun |$paramod/timer_1us/PERIOD=90000#6| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool (= (|$paramod/timer_1us/PERIOD=90000#3| state) #b00000000001100010111000000111111)) ; $eq$timer_1us.v:27$35_Y
(define-fun |$paramod/timer_1us/PERIOD=90000#7| ((state |$paramod/timer_1us/PERIOD=90000_s|)) (_ BitVec 32) (ite (|$paramod/timer_1us/PERIOD=90000#6| state) #b00000000000000000000000000000000 (|$paramod/timer_1us/PERIOD=90000#5| state))) ; $procmux$41_Y
(define-fun |$paramod/timer_1us/PERIOD=90000#8| ((state |$paramod/timer_1us/PERIOD=90000_s|)) (_ BitVec 32) (ite (|$paramod/timer_1us/PERIOD=90000#2| state) (|$paramod/timer_1us/PERIOD=90000#7| state) #b00000000000000000000000000000000)) ; $procmux$43_Y
(define-fun |$paramod/timer_1us/PERIOD=90000#9| ((state |$paramod/timer_1us/PERIOD=90000_s|)) (_ BitVec 32) (ite (|$paramod/timer_1us/PERIOD=90000#0| state) (|$paramod/timer_1us/PERIOD=90000#8| state) #b00000000000000000000000000000000)) ; $0\count[31:0]
(define-fun |$paramod/timer_1us/PERIOD=90000#10| ((state |$paramod/timer_1us/PERIOD=90000_s|)) (_ BitVec 1) (ite (|$paramod/timer_1us/PERIOD=90000#6| state) #b1 #b0)) ; $0\q[0:0]
(define-fun |$paramod/timer_1us/PERIOD=90000_a| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool true)
(define-fun |$paramod/timer_1us/PERIOD=90000_u| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool true)
(define-fun |$paramod/timer_1us/PERIOD=90000_i| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool (and
  (= (= ((_ extract 0 0) (|$paramod/timer_1us/PERIOD=90000#1| state)) #b1) false) ; q
  (= (|$paramod/timer_1us/PERIOD=90000#3| state) #b00000000000000000000000000000000) ; count
))
(define-fun |$paramod/timer_1us/PERIOD=90000_h| ((state |$paramod/timer_1us/PERIOD=90000_s|)) Bool true)
(define-fun |$paramod/timer_1us/PERIOD=90000_t| ((state |$paramod/timer_1us/PERIOD=90000_s|) (next_state |$paramod/timer_1us/PERIOD=90000_s|)) Bool (and
  (= (|$paramod/timer_1us/PERIOD=90000#9| state) (|$paramod/timer_1us/PERIOD=90000#3| next_state)) ; $procdff$122 \count
  (= (|$paramod/timer_1us/PERIOD=90000#10| state) (|$paramod/timer_1us/PERIOD=90000#1| next_state)) ; $procdff$121 \q
)) ; end of module $paramod/timer_1us/PERIOD=90000
; yosys-smt2-module bullet
(declare-sort |bullet_s| 0)
(declare-fun |bullet_is| (|bullet_s|) Bool)
; yosys-smt2-wire tick 1
; yosys-smt2-cell $paramod/timer_1us/PERIOD=90000 timer_1us1
(declare-fun |bullet#0| (|bullet_s|) Bool) ; \tick
(declare-fun |bullet_h timer_1us1| (|bullet_s|) |$paramod/timer_1us/PERIOD=90000_s|)
(define-fun |bullet_n tick| ((state |bullet_s|)) Bool (|bullet#0| state))
; yosys-smt2-input shoot 1
; yosys-smt2-wire shoot 1
(declare-fun |bullet#1| (|bullet_s|) Bool) ; \shoot
(define-fun |bullet_n shoot| ((state |bullet_s|)) Bool (|bullet#1| state))
; yosys-smt2-input ship_x 5
; yosys-smt2-wire ship_x 5
(declare-fun |bullet#2| (|bullet_s|) (_ BitVec 5)) ; \ship_x
(define-fun |bullet_n ship_x| ((state |bullet_s|)) (_ BitVec 5) (|bullet#2| state))
; yosys-smt2-input reset 1
; yosys-smt2-wire reset 1
(declare-fun |bullet#3| (|bullet_s|) Bool) ; \reset
(define-fun |bullet_n reset| ((state |bullet_s|)) Bool (|bullet#3| state))
; yosys-smt2-input hit 1
; yosys-smt2-wire hit 1
(declare-fun |bullet#4| (|bullet_s|) Bool) ; \hit
(define-fun |bullet_n hit| ((state |bullet_s|)) Bool (|bullet#4| state))
; yosys-smt2-input enable 1
; yosys-smt2-wire enable 1
(declare-fun |bullet#5| (|bullet_s|) Bool) ; \enable
(define-fun |bullet_n enable| ((state |bullet_s|)) Bool (|bullet#5| state))
; yosys-smt2-input clk_25MHz 1
; yosys-smt2-wire clk_25MHz 1
; yosys-smt2-clock clk_25MHz posedge
(declare-fun |bullet#6| (|bullet_s|) Bool) ; \clk_25MHz
(define-fun |bullet_n clk_25MHz| ((state |bullet_s|)) Bool (|bullet#6| state))
; yosys-smt2-output bullet_y 4
; yosys-smt2-register bullet_y 4
; yosys-smt2-wire bullet_y 4
(declare-fun |bullet#7| (|bullet_s|) (_ BitVec 4)) ; \bullet_y
(define-fun |bullet_n bullet_y| ((state |bullet_s|)) (_ BitVec 4) (|bullet#7| state))
; yosys-smt2-output bullet_x 5
; yosys-smt2-register bullet_x 5
; yosys-smt2-wire bullet_x 5
(declare-fun |bullet#8| (|bullet_s|) (_ BitVec 5)) ; \bullet_x
(define-fun |bullet_n bullet_x| ((state |bullet_s|)) (_ BitVec 5) (|bullet#8| state))
; yosys-smt2-output bullet_flying 1
; yosys-smt2-register bullet_flying 1
; yosys-smt2-wire bullet_flying 1
(declare-fun |bullet#9| (|bullet_s|) (_ BitVec 1)) ; \bullet_flying
(define-fun |bullet_n bullet_flying| ((state |bullet_s|)) Bool (= ((_ extract 0 0) (|bullet#9| state)) #b1))
; yosys-smt2-register $formal$bullet.v:70$2_CHECK 1
(declare-fun |bullet#10| (|bullet_s|) (_ BitVec 1)) ; $formal$bullet.v:70$2_CHECK
(define-fun |bullet_n $formal$bullet.v:70$2_CHECK| ((state |bullet_s|)) Bool (= ((_ extract 0 0) (|bullet#10| state)) #b1))
; yosys-smt2-register $formal$bullet.v:69$1_EN 1
(declare-fun |bullet#11| (|bullet_s|) (_ BitVec 1)) ; $formal$bullet.v:69$1_EN
(define-fun |bullet_n $formal$bullet.v:69$1_EN| ((state |bullet_s|)) Bool (= ((_ extract 0 0) (|bullet#11| state)) #b1))
; yosys-smt2-register $formal$bullet.v:69$1_CHECK 1
(declare-fun |bullet#12| (|bullet_s|) (_ BitVec 1)) ; $formal$bullet.v:69$1_CHECK
(define-fun |bullet_n $formal$bullet.v:69$1_CHECK| ((state |bullet_s|)) Bool (= ((_ extract 0 0) (|bullet#12| state)) #b1))
; yosys-smt2-assert 0 bullet.v:70
(define-fun |bullet_a 0| ((state |bullet_s|)) Bool (or (= ((_ extract 0 0) (|bullet#10| state)) #b1) (not (= ((_ extract 0 0) (|bullet#11| state)) #b1)))) ; $assert$bullet.v:70$19
; yosys-smt2-assert 1 bullet.v:69
(define-fun |bullet_a 1| ((state |bullet_s|)) Bool (or (= ((_ extract 0 0) (|bullet#12| state)) #b1) (not (= ((_ extract 0 0) (|bullet#11| state)) #b1)))) ; $assert$bullet.v:69$18
(define-fun |bullet#13| ((state |bullet_s|)) Bool (bvult (concat #b0 (|bullet#7| state)) #b10000)) ; $0$formal$bullet.v:69$1_CHECK[0:0]$12
(define-fun |bullet#14| ((state |bullet_s|)) Bool (bvuge (|bullet#7| state) #b0000)) ; $0$formal$bullet.v:70$2_CHECK[0:0]$14
(define-fun |bullet#15| ((state |bullet_s|)) (_ BitVec 1) (ite (|bullet#1| state) #b1 #b0)) ; $3\bullet_flying[0:0]
(define-fun |bullet#16| ((state |bullet_s|)) Bool (not (or  (= ((_ extract 0 0) (|bullet#7| state)) #b1) (= ((_ extract 1 1) (|bullet#7| state)) #b1) (= ((_ extract 2 2) (|bullet#7| state)) #b1) (= ((_ extract 3 3) (|bullet#7| state)) #b1)))) ; $eq$bullet.v:50$8_Y
(define-fun |bullet#17| ((state |bullet_s|)) Bool (or  (|bullet#4| state) false  (|bullet#16| state) false)) ; $logic_or$bullet.v:50$9_Y
(define-fun |bullet#18| ((state |bullet_s|)) (_ BitVec 1) (ite (|bullet#17| state) #b0 #b1)) ; $procmux$84_Y
(define-fun |bullet#19| ((state |bullet_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|bullet#9| state)) #b1) (|bullet#18| state) (|bullet#15| state))) ; $2\bullet_flying[0:0]
(define-fun |bullet#20| ((state |bullet_s|)) (_ BitVec 1) (ite (|bullet#3| state) (|bullet#19| state) #b0)) ; $0\bullet_flying[0:0]
(define-fun |bullet#21| ((state |bullet_s|)) (_ BitVec 5) (ite (|bullet#1| state) (|bullet#2| state) #b00000)) ; $procmux$114_Y
(define-fun |bullet#22| ((state |bullet_s|)) (_ BitVec 5) (ite (|bullet#17| state) #b00000 (|bullet#8| state))) ; $procmux$110_Y
(define-fun |bullet#23| ((state |bullet_s|)) (_ BitVec 5) (ite (= ((_ extract 0 0) (|bullet#9| state)) #b1) (|bullet#22| state) (|bullet#21| state))) ; $procmux$116_Y
(define-fun |bullet#24| ((state |bullet_s|)) (_ BitVec 5) (ite (|bullet#3| state) (|bullet#23| state) #b00000)) ; $0\bullet_x[4:0]
(define-fun |bullet#25| ((state |bullet_s|)) (_ BitVec 4) (ite (|bullet#1| state) #b1100 (|bullet#7| state))) ; $procmux$94_Y
(define-fun |bullet#26| ((state |bullet_s|)) (_ BitVec 4) (bvsub (|bullet#7| state) #b0001)) ; $auto$wreduce.cc:350:run$130 [3:0]
(define-fun |bullet#27| ((state |bullet_s|)) (_ BitVec 4) (ite (|bullet#0| state) (|bullet#26| state) (|bullet#7| state))) ; $4\bullet_y[3:0]
(define-fun |bullet#28| ((state |bullet_s|)) (_ BitVec 4) (ite (|bullet#17| state) #b1111 (|bullet#27| state))) ; $3\bullet_y[3:0]
(define-fun |bullet#29| ((state |bullet_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|bullet#9| state)) #b1) (|bullet#28| state) (|bullet#25| state))) ; $2\bullet_y[3:0]
(define-fun |bullet#30| ((state |bullet_s|)) (_ BitVec 4) (ite (|bullet#3| state) (|bullet#29| state) #b1110)) ; $0\bullet_y[3:0]
(define-fun |bullet_a| ((state |bullet_s|)) Bool (and
  (|bullet_a 0| state)
  (|bullet_a 1| state)
  (|$paramod/timer_1us/PERIOD=90000_a| (|bullet_h timer_1us1| state))
))
(define-fun |bullet_u| ((state |bullet_s|)) Bool 
  (|$paramod/timer_1us/PERIOD=90000_u| (|bullet_h timer_1us1| state))
)
(define-fun |bullet_i| ((state |bullet_s|)) Bool (and
  (= (|bullet#7| state) #b1110) ; bullet_y
  (= (|bullet#8| state) #b00000) ; bullet_x
  (= (= ((_ extract 0 0) (|bullet#9| state)) #b1) false) ; bullet_flying
  (= (= ((_ extract 0 0) (|bullet#11| state)) #b1) false) ; $formal$bullet.v:69$1_EN
  (|$paramod/timer_1us/PERIOD=90000_i| (|bullet_h timer_1us1| state))
))
(define-fun |bullet_h| ((state |bullet_s|)) Bool (and
  (= (|bullet_is| state) (|$paramod/timer_1us/PERIOD=90000_is| (|bullet_h timer_1us1| state)))
  (= (|bullet#3| state) (|$paramod/timer_1us/PERIOD=90000_n reset| (|bullet_h timer_1us1| state))) ; $paramod/timer_1us/PERIOD=90000.reset
  (= (|bullet#0| state) (|$paramod/timer_1us/PERIOD=90000_n q| (|bullet_h timer_1us1| state))) ; $paramod/timer_1us/PERIOD=90000.q
  (= true (|$paramod/timer_1us/PERIOD=90000_n en| (|bullet_h timer_1us1| state))) ; $paramod/timer_1us/PERIOD=90000.en
  (= (|bullet#6| state) (|$paramod/timer_1us/PERIOD=90000_n clk_25MHz| (|bullet_h timer_1us1| state))) ; $paramod/timer_1us/PERIOD=90000.clk_25MHz
  (|$paramod/timer_1us/PERIOD=90000_h| (|bullet_h timer_1us1| state))
))
(define-fun |bullet_t| ((state |bullet_s|) (next_state |bullet_s|)) Bool (and
  (= (ite (|bullet#13| state) #b1 #b0) (|bullet#12| next_state)) ; $procdff$123 $formal$bullet.v:69$1_CHECK
  (= #b1 (|bullet#11| next_state)) ; $procdff$124 $formal$bullet.v:69$1_EN
  (= (ite (|bullet#14| state) #b1 #b0) (|bullet#10| next_state)) ; $procdff$125 $formal$bullet.v:70$2_CHECK
  (= (|bullet#20| state) (|bullet#9| next_state)) ; $procdff$127 \bullet_flying
  (= (|bullet#24| state) (|bullet#8| next_state)) ; $procdff$128 \bullet_x
  (= (|bullet#30| state) (|bullet#7| next_state)) ; $procdff$129 \bullet_y
  (|$paramod/timer_1us/PERIOD=90000_t| (|bullet_h timer_1us1| state) (|bullet_h timer_1us1| next_state))
)) ; end of module bullet
; yosys-smt2-topmod bullet
; end of yosys output
