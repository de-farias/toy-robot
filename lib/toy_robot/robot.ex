defmodule ToyRobot.Robot do
  defstruct [:position, :facing, placed: false]

  def place(x, y, facing) do
    %__MODULE__{position: {x, y}, facing: facing, placed: true}
  end

  def report(robot = %__MODULE__{placed: false}), do: robot

  def report(robot = %__MODULE__{}) do
    "#{elem(robot.position, 0)},#{elem(robot.position, 1)},#{
      robot.facing
      |> to_string()
      |> String.upcase()
    }"
  end

  def move(robot = %__MODULE__{placed: false}), do: robot
  def move(robot = %__MODULE__{facing: :north, position: {4, _y}}), do: robot

  def move(robot = %__MODULE__{facing: :north, position: {x, y}}),
    do: %{robot | position: {x + 1, y}}

  def move(robot = %__MODULE__{facing: :south, position: {0, _y}}), do: robot

  def move(robot = %__MODULE__{facing: :south, position: {x, y}}),
    do: %{robot | position: {x - 1, y}}

  def move(robot = %__MODULE__{facing: :east, position: {_x, 4}}), do: robot

  def move(robot = %__MODULE__{facing: :east, position: {x, y}}),
    do: %{robot | position: {x, y + 1}}

  def move(robot = %__MODULE__{facing: :west, position: {_x, 0}}), do: robot

  def move(robot = %__MODULE__{facing: :west, position: {x, y}}),
    do: %{robot | position: {x, y - 1}}

  def left(robot = %__MODULE__{placed: false}), do: robot
  def left(robot = %__MODULE__{facing: :north}), do: %{robot | facing: :west}
  def left(robot = %__MODULE__{facing: :south}), do: %{robot | facing: :east}
  def left(robot = %__MODULE__{facing: :east}), do: %{robot | facing: :north}
  def left(robot = %__MODULE__{facing: :west}), do: %{robot | facing: :south}

  def right(robot = %__MODULE__{facing: :north}), do: %{robot | facing: :east}
  def right(robot = %__MODULE__{facing: :south}), do: %{robot | facing: :west}
  def right(robot = %__MODULE__{facing: :east}), do: %{robot | facing: :south}
  def right(robot = %__MODULE__{facing: :west}), do: %{robot | facing: :north}
end

#           N + L -> W
#           | + R -> E
#           |
#           |
# W -------- -------- E + L -> N
# + L -> S  |           + R -> S
# + R -> N  |
#           |
#           S + L -> E
#             + R -> W
