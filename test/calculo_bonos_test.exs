defmodule CalculoBonosTest do
  use ExUnit.Case
  doctest CalculoBonos

  test "Input jugadores" do
    assert CalculoBonos.jugadores() ==
             [
               %{
                 nombre: "Juan Perez",
                 nivel: "C",
                 goles: 10,
                 sueldo: 50000,
                 bono: 25000,
                 equipo: "rojo",
                 sueldo_completo: nil
               },
               %{
                 nombre: "EL Cuauh",
                 nivel: "Cuauh",
                 goles: 30,
                 sueldo: 100_000,
                 bono: 30000,
                 equipo: "azul",
                 sueldo_completo: nil
               },
               %{
                 nombre: "Cosme Fulanito",
                 nivel: "A",
                 goles: 7,
                 sueldo: 20000,
                 bono: 10000,
                 equipo: "azul",
                 sueldo_completo: nil
               },
               %{
                 nombre: "El Rulo",
                 nivel: "B",
                 goles: 9,
                 sueldo: 30000,
                 bono: 10000,
                 equipo: "rojo",
                 sueldo_completo: nil
               }
             ]
  end

  test "Resultado" do
    assert CalculoBonos.resuelveFc() ==
             [
               %{
                 bono: 25000,
                 equipo: "rojo",
                 goles: 10,
                 nivel: "C",
                 nombre: "Juan Perez",
                 sueldo: 50000,
                 sueldo_completo: "67833.33"
               },
               %{
                 bono: 10000,
                 equipo: "rojo",
                 goles: 9,
                 nivel: "B",
                 nombre: "El Rulo",
                 sueldo: 30000,
                 sueldo_completo: "38300.0"
               },
               %{
                 bono: 30000,
                 equipo: "azul",
                 goles: 30,
                 nivel: "Cuauh",
                 nombre: "EL Cuauh",
                 sueldo: 100_000,
                 sueldo_completo: "130000.0"
               },
               %{
                 bono: 10000,
                 equipo: "azul",
                 goles: 7,
                 nivel: "A",
                 nombre: "Cosme Fulanito",
                 sueldo: 20000,
                 sueldo_completo: "30000.0"
               }
             ]
  end
end
