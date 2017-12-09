require 'set'

class Genotype
  def initialize(rows, cols, original_matrix)
    @rows = rows
    @columns = cols
    @fitness_value = calculate_fitness_function(original_matrix)
  end

  def calculate_fitness_function(original_matrix)
    permuted_matrix = create_permuted_matrix(original_matrix)
    total = 0
    @rows.size.times do |i|
      for j in (i + 1)..@columns.size - 1
        total += permuted_matrix[i][j]
      end
    end
    total
  end

  def create_permuted_matrix(original_matrix)
    permute_columns(permute_rows(original_matrix))
  end

  def permute_rows(original_matrix)
    permuted_matrix = []
    @rows.each do |row|
      permuted_matrix << original_matrix[row]
    end
    permuted_matrix
  end

  def rows
  	@rows
  end

  def cols
  	@columns
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

  def fitness_value
    @fitness_value
  end

  def self.select_worst(candidates:)
    criteria = Proc.new { |current, candidate| current.fitness_value < candidate.fitness_value ? current : candidate }
    self.select(candidates: candidates,
                selection_criteria: criteria)
  end

  def self.select_best(candidates:)
    criteria = Proc.new { |current, candidate| current.fitness_value > candidate.fitness_value ? current : candidate }
    self.select(candidates: candidates,
                selection_criteria: criteria)
  end

  def self.select(candidates:, selection_criteria:)
    candidates.inject(candidates.first) do |current_selected, candidate|
      selection_criteria.call current_selected, candidate
    end
  end
end
