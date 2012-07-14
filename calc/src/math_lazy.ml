(* Evaluation paresseuse *)
    
type 'a glacon =
    Gele of (unit -> 'a)
  | Connu of 'a 
;;
