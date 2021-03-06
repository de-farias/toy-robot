defmodule RobotTest do
  use ExUnit.Case

  alias ToyRobot.Robot

  describe "place/3" do
    test 'when the coordinates are invalid' do
      assert Robot.place(-1, 0, :north) == %Robot{
               position: {-1, 0},
               facing: :north,
               placed: false
             }

      assert Robot.place(0, -1, :north) == %Robot{
               position: {0, -1},
               facing: :north,
               placed: false
             }

      assert Robot.place(5, 0, :north) == %Robot{
               position: {5, 0},
               facing: :north,
               placed: false
             }

      assert Robot.place(0, 5, :north) == %Robot{
               position: {0, 5},
               facing: :north,
               placed: false
             }
    end

    test 'when the coordinates are valid' do
      assert Robot.place(0, 0, :north) == %Robot{position: {0, 0}, facing: :north, placed: true}
      assert Robot.place(0, 1, :south) == %Robot{position: {0, 1}, facing: :south, placed: true}
      assert Robot.place(1, 1, :east) == %Robot{position: {1, 1}, facing: :east, placed: true}
      assert Robot.place(2, 1, :west) == %Robot{position: {2, 1}, facing: :west, placed: true}
    end
  end

  describe "before a valid place command" do
    test "report/1" do
      unplaced_robot = %Robot{position: {0, 0}, facing: :north, placed: false}
      assert Robot.report(unplaced_robot) == unplaced_robot
    end

    test "move/1" do
      unplaced_robot = %Robot{position: {0, 0}, facing: :north, placed: false}
      assert Robot.move(unplaced_robot) == unplaced_robot
    end

    test "left/1" do
      unplaced_robot = %Robot{position: {0, 0}, facing: :north, placed: false}
      assert Robot.left(unplaced_robot) == unplaced_robot
    end

    test "right/1" do
      unplaced_robot = %Robot{position: {0, 0}, facing: :north, placed: false}
      assert Robot.right(unplaced_robot) == unplaced_robot
    end
  end

  describe "after a valid place command" do
    test "report/1" do
      assert Robot.report(%Robot{position: {0, 0}, facing: :north, placed: true}) == "0,0,NORTH"
      assert Robot.report(%Robot{position: {0, 1}, facing: :south, placed: true}) == "0,1,SOUTH"
      assert Robot.report(%Robot{position: {1, 1}, facing: :east, placed: true}) == "1,1,EAST"
      assert Robot.report(%Robot{position: {2, 1}, facing: :west, placed: true}) == "2,1,WEST"
    end

    test "move/1 when placed in the edges of the board" do
      assert Robot.move(%Robot{position: {4, 1}, facing: :north, placed: true}) == %Robot{
               position: {4, 1},
               facing: :north,
               placed: true
             }

      assert Robot.move(%Robot{position: {0, 2}, facing: :south, placed: true}) == %Robot{
               position: {0, 2},
               facing: :south,
               placed: true
             }

      assert Robot.move(%Robot{position: {1, 4}, facing: :east, placed: true}) == %Robot{
               position: {1, 4},
               facing: :east,
               placed: true
             }

      assert Robot.move(%Robot{position: {3, 0}, facing: :west, placed: true}) == %Robot{
               position: {3, 0},
               facing: :west,
               placed: true
             }
    end

    test "move/1 when placed in other positons" do
      assert Robot.move(%Robot{position: {0, 0}, facing: :north, placed: true}) == %Robot{
               position: {1, 0},
               facing: :north,
               placed: true
             }

      assert Robot.move(%Robot{position: {1, 0}, facing: :south, placed: true}) == %Robot{
               position: {0, 0},
               facing: :south,
               placed: true
             }

      assert Robot.move(%Robot{position: {0, 1}, facing: :east, placed: true}) == %Robot{
               position: {0, 2},
               facing: :east,
               placed: true
             }

      assert Robot.move(%Robot{position: {0, 1}, facing: :west, placed: true}) == %Robot{
               position: {0, 0},
               facing: :west,
               placed: true
             }
    end

    test "left/1" do
      assert Robot.left(%Robot{position: {0, 0}, facing: :north, placed: true}) == %Robot{
               position: {0, 0},
               facing: :west,
               placed: true
             }

      assert Robot.left(%Robot{position: {0, 0}, facing: :south, placed: true}) == %Robot{
               position: {0, 0},
               facing: :east,
               placed: true
             }

      assert Robot.left(%Robot{position: {0, 0}, facing: :east, placed: true}) == %Robot{
               position: {0, 0},
               facing: :north,
               placed: true
             }

      assert Robot.left(%Robot{position: {0, 0}, facing: :west, placed: true}) == %Robot{
               position: {0, 0},
               facing: :south,
               placed: true
             }
    end

    test "right/1" do
      assert Robot.right(%Robot{position: {0, 0}, facing: :north, placed: true}) == %Robot{
               position: {0, 0},
               facing: :east,
               placed: true
             }

      assert Robot.right(%Robot{position: {0, 0}, facing: :south, placed: true}) == %Robot{
               position: {0, 0},
               facing: :west,
               placed: true
             }

      assert Robot.right(%Robot{position: {0, 0}, facing: :east, placed: true}) == %Robot{
               position: {0, 0},
               facing: :south,
               placed: true
             }

      assert Robot.right(%Robot{position: {0, 0}, facing: :west, placed: true}) == %Robot{
               position: {0, 0},
               facing: :north,
               placed: true
             }
    end
  end
end
