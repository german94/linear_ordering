require 'set'

class Genotype
  def initialize(rows, cols)
    @rows = rows
    @columns = cols
  end

  def calculate_fitness_function(original_matrix)
    permuted_matrix = create_permuted_matrix(original_matrix)
    total = 0
    @rows.size.times do |i|
      for j in (i + 1)..@columns
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

  def self.select_best(population:, matrix:)
    candidates.inject(candidates.first) do |current_best, candidate|
      #quizas current_best_fitness_value podria declararse afuera, entonces se "cachea" y no se tiene que recalcular
      #en cada iteracion del inject, que tal vez no cambie si se encuentra el mejor al principio por ejemplo
      current_best_fitness_value = current_best.calculate_fitness_function(matrix)
      candidate_fitness_value = candidate.calculate_fitness_function(matrix)
      current_best_fitness_value < candidate_fitness_value ? candidate : current_best
    end
  end
end
