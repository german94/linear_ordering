require 'genotype'

class LinearOrderingSolutionsGenerator
  def initialize(population_size:,
                 original_matrix:,
                 max_iterations:,
                 parent_selection_criteria:,
                 crossover_criteria:,
                 mutation_criteria:)
    @population_size = population_size
    @original_matrix = original_matrix
    @max_iterations = max_iterations
    @parent_selection_criteria = parent_selection_criteria
    @crossover_criteria = crossover_criteria
    @mutation_criteria = mutation_criteria
  end

  def dimension
    @original_matrix[0].size
  end

  def generate_solution
    generate_initial_population
    @max_iterations.times do
      parents = @parents_selection_criteria.select(@population)
      offspring = @crossover_criteria.cross(parents)
      offspring = mutation_criteria.mutate(offspring)
      select_survivors
      select_best
    end
  end

private
  def generate_initial_population
    @population = Set.new
    loop do
      @population << Genotype.new [*0..dimension - 1].shuffle [*0..dimension - 1].shuffle @original_matrix
      break if @population.size == @population_size
    end
  end
end
