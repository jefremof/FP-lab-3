open Utils

module type Settings = sig
  val step : float
  val stream : point Iter.t
  val techniques : technique list
end

module type Runner = sig
  val run : unit -> unit
end

module MakeRunner (_ : Settings) : Runner
