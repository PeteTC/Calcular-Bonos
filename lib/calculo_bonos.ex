defmodule CalculoBonos do
  @moduledoc """
  Modulo para calcular el sueldo completo
  de los jugadores de Resuelve FC dependiendo
  de sus goles obtenidos y su nivel
  """

  def calcular_bonos do
    jugadores()
    |> remp_nivel
    |> crear_vt
    |> div_equipo
    |> sueldo_completo
    |> unir_listas
    |> remp_nivel2
    |> eliminar_vt
  end

  @doc """
  Se recibe el input de los jugadores
  """
  def jugadores() do
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

  @doc """
  Remplaza la propiedad "Nivel" de los mapas
  al numero minimo de goles que corresponda
  """
  def remp_nivel(jugador) do
    Enum.map(jugador, fn j ->
      case j.nivel do
        "A" -> Map.put(j, :nivel, 5)
        "B" -> Map.put(j, :nivel, 10)
        "C" -> Map.put(j, :nivel, 15)
        "Cuauh" -> Map.put(j, :nivel, 20)
      end
    end)
  end

  @doc """
  Se crea una variable temporal para
  hacer los calculos del sueldo completo
  """
  def crear_vt(val1) do
    Enum.map(val1, fn j ->
      if j.nivel < j.goles do
        Map.put_new(j, :vt, j.nivel)
      else
        Map.put_new(j, :vt, j.goles)
      end
    end)
  end

  @doc """
  Se agrupan los mapas segun su equipo
  """
  def div_equipo(val2) do
    Enum.sort_by(val2, & &1.equipo) |> Enum.chunk_by(& &1.equipo)
  end

  @doc """
  Se obtienen los goles obtenidos y los goles por equipo
  para realizar el calculo del sueldo completo
  """
  def sueldo_completo(val3) do
    Enum.reduce(val3, [], fn x, acc ->
      goles_por_equipo = Enum.reduce(x, 0, fn y, acc2 -> y.nivel + acc2 end)
      goles_obtenidos = Enum.reduce(x, 0, fn y, acc2 -> y.vt + acc2 end)

      [
        Enum.map(x, fn y ->
          %{
            nombre: y.nombre,
            nivel: y.nivel,
            goles: y.goles,
            sueldo: y.sueldo,
            bono: y.bono,
            vt: y.vt,
            sueldo_completo:
              :erlang.float_to_binary(
                y.vt * (y.bono / 2) / y.nivel + goles_obtenidos / goles_por_equipo * (y.bono / 2) +
                  y.sueldo,
                [:compact, {:decimals, 2}]
              ),
            equipo: y.equipo
          }
        end)
      ] ++ acc
    end)
  end

  @doc """
  Se unen las listas divididas por equipo
  """
  def unir_listas(val4) do
    Enum.concat(val4)
  end

  @doc """
  Se vuelve a remplazar la propiedad "Nivel"
  de los mapas a como estaba originalmente
  """
  def remp_nivel2(val5) do
    Enum.map(val5, fn j ->
      case j.nivel do
        5 -> Map.put(j, :nivel, "A")
        10 -> Map.put(j, :nivel, "B")
        15 -> Map.put(j, :nivel, "C")
        20 -> Map.put(j, :nivel, "Cuauh")
      end
    end)
  end

  @doc """
  Se remueve de los mapas la variable temporal
  """
  def eliminar_vt(val6) do
    Enum.map(val6, fn j -> Map.delete(j, :vt) end)
  end
end
