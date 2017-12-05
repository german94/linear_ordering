require 'set'

class Genotype
  def initialize(rows, cols, original_matrix)
    @rows = rows
    @columns = cols
    @original_matrix = original_matrix
  end

  def fitness
    permuted_matrix = create_permuted_matrix
    total = 0
    @rows.size.times do |i|
      for j in (i + 1)..@columns
        total += permuted_matrix[i][j]
      end
    end
    total
  end

  def create_permuted_matrix
    permute_columns(permute_rows)
    # permute_rows
  end

  def permute_rows
    permuted_matrix = []
    @rows.each do |row|
      permuted_matrix << @original_matrix[row]
    end
    permuted_matrix
  end

  def permute_columns(permuted_matrix)
    final_matrix = @rows.inject([]) { |matrix, _| matrix << [] }
    @columns.each do |col|
      @rows.size.times do |row_index|
        final_matrix[row_index] << permuted_matrix[row_index][col]
      end
    end
    final_matrix
  end

  def rows
    @rows
  end

  def columns
    @columns
  end
end
