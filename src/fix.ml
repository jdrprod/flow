(**
  {1 Computation of post fixpoints over Semi-lattices}
*)

open Dom

module Pfp (D : SemiLattice) : sig
  val set_max_iter : int -> unit
  (** set the maximum number of iterations *)
  
  val compute : (D.t -> D.t) -> D.t
  (** [compute f] computes a postfixpoint of the function, i.e.
    a value [d] such that [D.le (f d) d] holds.
    If no postfixpoint is found after [n] iterations, returns [D.top]
  *)
end = struct

let max_iter = ref 15

let set_max_iter i = max_iter := i

let rec iter i (f : D.t -> D.t) x =
  if i = 0 then begin
    Format.printf "%a\n" D.pp_print D.top;
    D.top
  end else
    let x' = f x in
    Format.printf "%a <=? %a = %a\n" D.pp_print x' D.pp_print x Format.pp_print_bool (D.le x' x);
    if D.le x' x then x
    else iter (i - 1) f x'

let compute f =
  iter !max_iter f D.bot

end