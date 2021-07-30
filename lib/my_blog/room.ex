defmodule MyBlog.Room do
  # Do end spin
  def move({x, y, :east}, size)
    when x === 0 and y+1 > size, do: :done

  def move({x, y, :north}, size)
    when x === 0 and y+1 > size, do: {x, y, :west}

  def move({x, y, :west}, size)
    when x === 0 and y+1 > size, do: {x, y, :south}

  def move({x, y, :south}, size)
    when x === 0 and y+1 > size, do: {x, y, :east}

  # Regular Move
  def move({x, y, :east}, size)
    when x+1 > size, do: {x, y, :south}

  def move({x, y, :east}, _size), do: {x+1, y, :east}

  def move({x, y, :south}, _size)
    when x-1 < 0, do: {x, y+1, :east}

  def move({x, y, :south}, _size), do: {x, y+1, :west}

  def move({x, y, :west}, _size)
    when x-1 < 0, do: {x, y, :south}

  def move({x, y, :west}, _size), do: {x-1, y, :west}

  # def move({x, y, :west}, size) do
  #   west({x, y, :west}, size)
  # end

  # def move({x, y, :south}, size) do
  #   south({x, y, :south}, size)
  # end

  # defp east({x, y, _dir}, size) when x+1 > size do
  #   {x, y, :south}
  # end

  # defp east({x, y, :west}, _size) when x-1 < 0 do
  #   IO.puts "Does this happen?!"
  #   {x, y, :south}
  # end

  # defp east({x, y, dir}, _size) do
  #   {x+1, y, dir}
  # end

  # defp west({x, y, :east}, size) when x+1 > size do
  #   south({x, y, :east}, size)
  # end

  # defp west({x, y, dir}, size) when x-1 < 0 do
  #   south({x, y, dir}, size)
  # end

  # defp west({x, y, dir}, _size) do
  #   {x-1, y, dir}
  # end

  # defp south({x, y, :east}, _size) do
  #   {x, y+1, :west}
  # end

  # defp south({x, y, :west}, _size) do
  #   {x, y+1, :east}
  # end
end
