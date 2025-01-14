open Fp_lab_3.Input
open Fp_lab_3.Runners
open Fp_lab_3.Presets

let file_dispenser filename =
  Iter.IO.lines_of filename |> Iter.filter_map parse_point

let run_golden step filename techniques =
  let module TestSettings : Settings = struct
    let step = step
    let stream = file_dispenser filename
    let techniques = techniques
  end in
  let module TestRunner = MakeRunner (TestSettings) in
  TestRunner.run ()

let%expect_test "Repository example" =
  run_golden 1.0 "examples/repository"
    [ linear_interpolation; lagrange_interpolation ];
  [%expect
    {|
    Linear Interpolation:
    (0.000000, 0.000000) (1.000000, 0.636537) (2.000000, 1.273074)

    Linear Interpolation:
    (1.571000, 1.000000) (2.571000, 0.363463) (3.571000, -0.273074)

    Linear Interpolation:
    (3.142000, 0.000000) (4.142000, -0.636943) (5.142000, -1.273885)

    Lagrange Interpolation:
    (0.000000, 0.000000) (1.000000, 0.973033) (2.000000, 0.841202) (3.000000, 0.120277) (4.000000, -0.673973) (5.000000, -1.025780)

    Linear Interpolation:
    (4.712000, -1.000000) (5.712000, -0.872709) (6.712000, -0.745418) (7.712000, -0.618126) (8.712000, -0.490835) (9.712000, -0.363544) (10.712000, -0.236253) (11.712000, -0.108961) (12.712000, 0.018330)

    Lagrange Interpolation:
    (1.571000, 1.000000) (2.571000, 0.372564) (3.571000, -0.280414) (4.571000, -0.914629) (5.571000, -1.485773) (6.571000, -1.949539) (7.571000, -2.261623) (8.571000, -2.377717) (9.571000, -2.253514) (10.571000, -1.844709) (11.571000, -1.106995) (12.571000, 0.003935)
    |}]

let%expect_test "Diagonal line example" =
  run_golden 1.0 "examples/diagonal" [ linear_interpolation ];
  [%expect
    {|
    Linear Interpolation:
    (1.000000, 1.000000) (2.000000, 2.000000) (3.000000, 3.000000) (4.000000, 4.000000) (5.000000, 5.000000)

    Linear Interpolation:
    (5.000000, 5.000000) (6.000000, 6.000000)

    Linear Interpolation:
    (6.000000, 6.000000) (7.000000, 7.000000) (8.000000, 8.000000) (9.000000, 9.000000) (10.000000, 10.000000)

    Linear Interpolation:
    (10.000000, 10.000000) (11.000000, 11.000000) (12.000000, 12.000000) (13.000000, 13.000000) (14.000000, 14.000000)
    |}]
