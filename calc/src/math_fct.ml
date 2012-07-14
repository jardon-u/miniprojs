type 'a term =
  | X
  | Id of 'a
  | Neg of 'a term
  | Add of ('a term)*('a term)
  | Sous of ('a term)*('a term)
  | Mult of ('a term)*('a term)
  | Div of ('a term)*('a term)
  | Pow of ('a term)*('a term)
  | Cos of 'a term
  | Sin of 'a term
  | Acos of 'a term
  | Asin of 'a term
  | Ln of 'a term
  | Exp of 'a term
  | Primit of 'a term
;;

let rec eval fct v =
  let eval f = eval f v in
    match fct with
      | X           -> v
      | Id x        -> x

      | Neg x       -> 0. -. eval x
      | Add(x,y)    -> eval x +. eval y
      | Sous(x,y)   -> eval x -. eval y
      | Mult(x,y)   -> eval x *. eval y
      | Div(x,y)    -> eval x /. eval y
      | Pow(x,y)    -> exp(eval x *. log(eval y))
      | Cos Acos x  -> eval x
      | Cos x       -> cos (eval x)
      | Sin Asin x  -> eval x
      | Sin x       -> sin (eval x)
      | Acos x      -> acos (eval x)
      | Asin x      -> asin (eval x)
      | Ln x        -> log(eval x)
      | Exp x       -> exp(eval x) (* pas le bon  *)

      | Primit x    -> failwith "Primitive non calculable"
;;

let rec parcourt g fct =
  let f t = parcourt g t in
    match fct with
      | X         -> X
      | Id x      -> Id x
      | Neg x     -> g (Neg (f x))
      | Add(x,y)  -> g (Add( f x,f y))
      | Sous(x,y) -> g (Sous(f x,f y))
      | Mult(x,y) -> g (Mult(f x,f y))
      | Div(x,y)  -> g (Div(f x,f y))
      | Pow(x,y)  -> g (Pow(f x,f y))
      | Cos x     -> g (Cos (f x))
      | Sin x     -> g (Sin (f x))
      | Acos x    -> g (Acos (f x))
      | Asin x    -> g (Asin (f x))
      | Ln x      -> g (Ln (f x))
      | Exp x     -> g (Exp (f x))
      | Primit x  -> g (Primit (f x))
;;

let simplfct = function
  | X -> X
  | Id x -> Id x

  | Add(x,y) when x = y -> Mult(Id 2., x)
  | Add(x,Neg y)        -> Sous(x, y)
  | Add(Id x,Id y)      -> Id (x +. y)

  | Mult(Id 0.,x)|Mult(x,Id 0.)             -> Id 0.
  | Mult(Id 1.,x)|Mult(x,Id 1.)             -> x
  | Mult(Neg (Id 1.),x)|Mult(x,Neg (Id 1.)) -> Neg x
  | Mult(Neg x,y)|Mult(x,Neg y)             -> Neg (Mult(x, y))
  | Mult(Id x,Id y)                         -> Id (x *. y)

  | Sous(x,y) when x = y -> Id 0.
  | Sous(x,Id 0.)        -> x
  | Sous(Id 0.,x)        -> Neg x
  | Sous(Id x,Id y)      -> Id (x -. y)

  | Pow (x, Id 1.) -> x
  | Pow (x, Id 0.) -> Id 1.
  | Pow (Id 0., x) -> Id 0.

  | Primit ( Mult(Id x,y)|Mult(y,Id x) ) -> Mult(Id x,Primit y)

  | x -> x
;;

let forme_simple f =
  parcourt simplfct f
;;

let rec deriver = function
  | X           -> Id 1.
  | Id x        -> Id 0.
  | Neg x       -> Neg (deriver x)
  | Add(x,y)    -> Add(deriver x,deriver y)
  | Sous(x,y)   -> Sous(deriver x,deriver y)
  | Mult(x,y)   -> Add(Mult(deriver x,y), Mult(x,deriver y))
  | Div(x,y)    -> Div(Sous(Mult(deriver x,y),Mult(x,deriver y)),Pow(y,Id 2.))
  | Pow(x,Id n) -> Mult(Id n, Pow(x,Id (n-.1.)))
  | Pow(x,y)    -> deriver (Exp(Mult(y,Ln(x))))
  | Cos x       -> Mult(deriver x, Neg (Sin x))
  | Sin x       -> Mult(deriver x, Neg (Cos x))
  | Acos x      -> Neg(Mult(deriver x, Div(Id 1.,Pow(Sous(Id 1., x),Id 0.5))))
  | Asin x      -> Mult(deriver x, Div(Id 1.,Pow(Sous(Id 1., x),Id 0.5)))
  | Ln x        -> Div(deriver x, x)
  | Exp x       -> Mult(deriver x, Exp x)
  | Primit x    -> x
;;

let derivee f =
  forme_simple (deriver f)
;;

(* Primitive avec constante d'integration a 0 *)
let rec primitiver = function
  | X           -> Div(Pow(X,Id 2.),Id 2.)
  | Id x        -> Mult(Id x,X)
  | Neg x       -> Neg(primitiver x)
  | Add(x,y)    -> Add(primitiver x,primitiver y)
  | Sous(x,y)   -> Sous(primitiver x,primitiver y)

  | Ln X        -> Sous(Mult(X,Ln X), X)
  | Exp x       -> Exp x

  | Cos X       -> Sin X
  | Sin X       -> Neg (Cos X)

  | x     -> Primit x
;;


let primitive f =
  forme_simple (primitiver f)
;;

let integrale f a b =
  let pf = primitive f in
    (eval pf b)-.(eval pf a)
;;

let rec lineariser_arbre = function
    Id c          -> ["Id"; string_of_float c]
  | X             -> ["x"]
  | Add (e1, e2)  -> ["+"] @ (lineariser_arbre e1) @ (lineariser_arbre e2)
  | Mult (e1, e2) -> ["*"] @ (lineariser_arbre e1) @ (lineariser_arbre e2)
  | Sous (e1, e2) -> ["-"] @ (lineariser_arbre e1) @ (lineariser_arbre e2)
  | Div (e1, e2)  -> ["/"] @ (lineariser_arbre e1) @ (lineariser_arbre e2)
  | Neg e      -> ["neg"] @ (lineariser_arbre e)
  | Ln e        -> ["ln"] @ (lineariser_arbre e)
  | Exp e       -> ["exp"] @ (lineariser_arbre e)
  | Cos e       -> ["cos"] @ (lineariser_arbre e)
  | Sin e       -> ["sin"] @ (lineariser_arbre e)
;;

let elever_linearisation liste =
  let rec elever suite = function
      [] -> failwith "Manque des termes"
  | "Id" :: c :: reste -> suite (Id (float_of_string c)) reste
  | "x" :: reste  -> suite (X) reste
  | "+" :: reste1           ->
      elever (fun e1 reste2 ->
                elever (fun e2 reste3 ->
                          suite (Add (e1, e2)) reste3 )
                reste2 )
      reste1
  | "*" :: reste1           ->
      elever (fun e1 reste2 ->
                elever (fun e2 reste3 ->
                          suite (Mult (e1, e2)) reste3 )
                reste2 )
      reste1
  | "-" :: reste1           ->
      elever (fun e1 reste2 ->
                elever (fun e2 reste3 ->
                          suite (Sous (e1, e2)) reste3 )
                reste2 )
      reste1
  | "/" :: reste1           ->
      elever (fun e1 reste2 ->
                elever (fun e2 reste3 ->
                          suite (Div (e1, e2)) reste3 )
                reste2 )
      reste1
  | "neg" :: reste       ->
      elever (fun e reste1 ->
                suite (Neg e) reste1 )
      reste
  | _ :: reste             -> failwith "Manque des termes"
  in elever (fun e suite -> e) liste
;;


let string_of_char c =
  let s = " " in
    s.[0] <- c;
    s
;;

(*
 * String of string string list. useless?
 *)
let rec s_of_sl = function
    [] -> ""
  | e::l -> e ^ (s_of_sl l)
;;

(*
 * String list of string. useless?
 *)
let rec sl_of_s s =
  let i = ref 0
  and l = ref []
  in
    while !i<(String.length s) do
      match s.[!i] with
	| 'n' when ((s.[!i+1] = 'e') && (s.[!i+2] = 'g') )
	    -> l := !l @ ["neg"] ; i:= !i+3
	| 'I' when (s.[!i+1] = 'd')
	    -> l := !l @ ["Id"] ; i:= !i+2
	| '0'..'9' as c ->
	    let tmp = ref ""
	    and fin = ref false in
	      while !i<(String.length s) && (not !fin) do
		match s.[!i] with
		    ('0'..'9' | '.') as d  ->
		      tmp := (!tmp) ^ (string_of_char d);
		      i := !i+1
		  | _ -> fin := true
	      done;
	      l := !l @ [!tmp];
	| a -> l := !l @ [string_of_char a] ; i := !i+1
    done;
    !l
;;
