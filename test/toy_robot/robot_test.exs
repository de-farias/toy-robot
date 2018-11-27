defmodule RobotTest do
  use ExUnit.Case

  alias ToyRobot.Robot

  test "place/1" do
    assert Robot.place(0, 0, :north) == %Robot{position: {0, 0}, facing: :north}
    assert Robot.place(0, 1, :south) == %Robot{position: {0, 1}, facing: :south}
    assert Robot.place(1, 1, :east) == %Robot{position: {1, 1}, facing: :east}
    assert Robot.place(2, 1, :WEST) == %Robot{position: {2, 1}, facing: :WEST}
  end

  test "report/1" do
    assert Robot.report(%Robot{position: {0, 0}, facing: :north}) == "0,0,NORTH"
    assert Robot.report(%Robot{position: {0, 1}, facing: :south}) == "0,1,SOUTH"
    assert Robot.report(%Robot{position: {1, 1}, facing: :east}) == "1,1,EAST"
    assert Robot.report(%Robot{position: {2, 1}, facing: :west}) == "2,1,WEST"
  end

  test "move/1" do
    assert Robot.move(%Robot{position: {0, 0}, facing: :north}) == %Robot{
             position: {1, 0},
             facing: :north
           }

    assert Robot.move(%Robot{position: {1, 0}, facing: :south}) == %Robot{
             position: {0, 0},
             facing: :south
           }

    assert Robot.move(%Robot{position: {0, 1}, facing: :east}) == %Robot{
             position: {0, 0},
             facing: :east
           }

    assert Robot.move(%Robot{position: {0, 0}, facing: :west}) == %Robot{
             position: {0, 1},
             facing: :west
           }
  end

  test "left/1" do
    assert Robot.left(%Robot{position: {0, 0}, facing: :north}) == %Robot{
             position: {0, 0},
             facing: :west
           }

    assert Robot.left(%Robot{position: {0, 0}, facing: :south}) == %Robot{
             position: {0, 0},
             facing: :east
           }

    assert Robot.left(%Robot{position: {0, 0}, facing: :east}) == %Robot{
             position: {0, 0},
             facing: :north
           }

    assert Robot.left(%Robot{position: {0, 0}, facing: :west}) == %Robot{
             position: {0, 0},
             facing: :south
           }
  end

  test "right/1" do
    assert Robot.right(%Robot{position: {0, 0}, facing: :north}) == %Robot{
             position: {0, 0},
             facing: :east
           }

    assert Robot.right(%Robot{position: {0, 0}, facing: :south}) == %Robot{
             position: {0, 0},
             facing: :west
           }

    assert Robot.right(%Robot{position: {0, 0}, facing: :east}) == %Robot{
             position: {0, 0},
             facing: :south
           }

    assert Robot.right(%Robot{position: {0, 0}, facing: :west}) == %Robot{
             position: {0, 0},
             facing: :north
           }
  end
end
