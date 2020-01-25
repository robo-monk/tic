module Rules
  BOARD_DIMENSIONS = 3
  DEFAULT_BOARD = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  PATTERN_BLOCKS = [[2,1]]
  attr_accessor :last_xy_call
  private
  def boot
    self.access(0,0)
  end
  def board_iterator start_xy=[0, 0], end_xy=[BOARD_DIMENSIONS**2, BOARD_DIMENSIONS**2]
    out_arrays = Array.new()
    self.board_matrix.each_with_index do |row, y|
      row.each_with_index do |col, x|
        yield(x, y, col, :x) if block_given?
      end
      yield(0, y, row, :y) if block_given?
    end
  end
  def get_rows
    @board_matrix
  end
  def get_cols
    board_cols = Array.new()
    BOARD_DIMENSIONS.times do board_cols << Array.new() end
    board_iterator do |x_index, y_index, data, scope|
      if scope == :y
        data.each_with_index do |block, i|
          board_cols[i]<<block
        end
      end
    end
    board_cols
  end
  def get_dias
    dia_1 = Array.new()
    dia_2= Array.new()
    (BOARD_DIMENSIONS).times do |i|
      dia_1 << @board_matrix[i][i]
      dia_2 << @board_matrix[i][BOARD_DIMENSIONS-i-1]
    end
    return dia_1, dia_2
  end
  def check
    grouped_arrays = get_cols, get_rows, get_dias
    grouped_arrays.each do |arr|
      arr.each do |sub_arr|
        yield(sub_arr)
      end
    end
  end 
  public
  def access x, y, write_pawn=nil
    if !write_pawn.nil? then self.board_matrix[y][x] = write_pawn end
    # @last_xy_call = [x, y]
    self.board_matrix[y][x]
  end
  def write x, y, write_pawn
    access x, y, write_pawn
  end
  def clipper n, range
    if range.include? n then n else range.first>n ? range.first : range.last end
  end
end
