open Utils

module type Settings = sig
  val step : float
  val stream : point Iter.t
  val techniques : technique list
end

module type Runner = sig
  val run : unit -> unit
end

module MakeRunner (Config : Settings) : Runner = struct
  open Config

  let initial_windows = List.init (List.length techniques) (fun _ -> [])

  let apply_body body window p =
    let interpolation = body window in
    let series = gen_series (Core.List.last_exn window) p step in
    List.map interpolation series |> List.combine series

  let run () =
    let use_point (windows : point list list) (p : point) =
      let apply_technique i ys =
        let technique = List.nth techniques i in
        let window_size = technique.window_size in
        let window = Core.List.take (p :: ys) window_size in
        let enough_points = List.length window = window_size in
        let export () =
          let ps = apply_body technique.body window p in
          print technique.name ps ()
        in
        if enough_points then export () else ();
        window
      in
      List.mapi apply_technique windows
    in
    stream |> Iter.fold use_point initial_windows |> ignore
end
